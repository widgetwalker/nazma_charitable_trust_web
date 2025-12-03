-- ============================================
-- Database Functions and Triggers
-- ============================================

-- ============================================
-- 1. GENERATE RECEIPT NUMBER
-- ============================================
CREATE OR REPLACE FUNCTION generate_receipt_number()
RETURNS TRIGGER AS $$
DECLARE
  year_suffix VARCHAR(4);
  sequence_num INTEGER;
  new_receipt_number VARCHAR(100);
BEGIN
  -- Only generate if donation is completed and receipt number is not set
  IF NEW.status = 'completed' AND NEW.receipt_number IS NULL THEN
    -- Get current fiscal year suffix (e.g., '2425' for 2024-25)
    year_suffix := TO_CHAR(NOW(), 'YY') || TO_CHAR(NOW() + INTERVAL '1 year', 'YY');
    
    -- Get next sequence number for this year
    SELECT COALESCE(MAX(SUBSTRING(receipt_number FROM '\d+$')::INTEGER), 0) + 1
    INTO sequence_num
    FROM donations
    WHERE receipt_number LIKE 'NCT/' || year_suffix || '/%';
    
    -- Generate receipt number: NCT/2425/0001
    new_receipt_number := 'NCT/' || year_suffix || '/' || LPAD(sequence_num::TEXT, 4, '0');
    
    NEW.receipt_number := new_receipt_number;
    NEW.receipt_issued_date := CURRENT_DATE;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for receipt generation
CREATE TRIGGER generate_donation_receipt
BEFORE INSERT OR UPDATE ON donations
FOR EACH ROW
EXECUTE FUNCTION generate_receipt_number();

-- ============================================
-- 2. UPDATE PROGRAM STATISTICS
-- ============================================
CREATE OR REPLACE FUNCTION update_program_statistics()
RETURNS TRIGGER AS $$
BEGIN
  -- Update budget spent when donation is completed
  IF NEW.status = 'completed' AND NEW.program_id IS NOT NULL THEN
    UPDATE programs
    SET budget_spent = budget_spent + NEW.amount
    WHERE id = NEW.program_id;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for program statistics
CREATE TRIGGER update_program_stats_on_donation
AFTER INSERT OR UPDATE ON donations
FOR EACH ROW
EXECUTE FUNCTION update_program_statistics();

-- ============================================
-- 3. SPAM DETECTION FOR CONTACT FORMS
-- ============================================
CREATE OR REPLACE FUNCTION detect_spam_inquiry()
RETURNS TRIGGER AS $$
DECLARE
  spam_keywords TEXT[] := ARRAY['viagra', 'casino', 'lottery', 'winner', 'bitcoin', 'crypto', 'investment opportunity'];
  keyword TEXT;
  recent_submissions INTEGER;
BEGIN
  -- Check for spam keywords
  FOREACH keyword IN ARRAY spam_keywords
  LOOP
    IF LOWER(NEW.message) LIKE '%' || keyword || '%' OR LOWER(NEW.subject) LIKE '%' || keyword || '%' THEN
      NEW.is_spam := true;
      NEW.spam_score := 0.9;
      RETURN NEW;
    END IF;
  END LOOP;
  
  -- Check for too many submissions from same email in short time
  SELECT COUNT(*)
  INTO recent_submissions
  FROM contact_inquiries
  WHERE email = NEW.email
  AND created_at > NOW() - INTERVAL '1 hour';
  
  IF recent_submissions > 3 THEN
    NEW.is_spam := true;
    NEW.spam_score := 0.8;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for spam detection
CREATE TRIGGER detect_spam_on_contact
BEFORE INSERT ON contact_inquiries
FOR EACH ROW
EXECUTE FUNCTION detect_spam_inquiry();

-- ============================================
-- 4. NEWSLETTER DOUBLE OPT-IN TOKEN
-- ============================================
CREATE OR REPLACE FUNCTION generate_verification_token()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.verification_token IS NULL THEN
    NEW.verification_token := uuid_generate_v4();
    NEW.verification_sent_at := NOW();
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for verification token
CREATE TRIGGER generate_newsletter_verification
BEFORE INSERT ON newsletter_subscribers
FOR EACH ROW
EXECUTE FUNCTION generate_verification_token();

-- ============================================
-- 5. AUTO-UPDATE BLOG POST VIEW COUNT
-- ============================================
CREATE OR REPLACE FUNCTION increment_blog_view_count(post_id UUID)
RETURNS VOID AS $$
BEGIN
  UPDATE blog_posts
  SET view_count = view_count + 1
  WHERE id = post_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- 6. GET DONATION STATISTICS
-- ============================================
CREATE OR REPLACE FUNCTION get_donation_stats(
  start_date DATE DEFAULT NULL,
  end_date DATE DEFAULT NULL
)
RETURNS TABLE (
  total_donations BIGINT,
  total_amount DECIMAL,
  average_donation DECIMAL,
  by_objective JSONB,
  by_month JSONB
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    COUNT(*)::BIGINT as total_donations,
    COALESCE(SUM(amount), 0) as total_amount,
    COALESCE(AVG(amount), 0) as average_donation,
    (
      SELECT jsonb_object_agg(allocated_to, total)
      FROM (
        SELECT allocated_to, SUM(amount) as total
        FROM donations
        WHERE status = 'completed'
        AND (start_date IS NULL OR created_at >= start_date)
        AND (end_date IS NULL OR created_at <= end_date)
        GROUP BY allocated_to
      ) objective_totals
    ) as by_objective,
    (
      SELECT jsonb_object_agg(month, total)
      FROM (
        SELECT TO_CHAR(created_at, 'YYYY-MM') as month, SUM(amount) as total
        FROM donations
        WHERE status = 'completed'
        AND (start_date IS NULL OR created_at >= start_date)
        AND (end_date IS NULL OR created_at <= end_date)
        GROUP BY TO_CHAR(created_at, 'YYYY-MM')
        ORDER BY month
      ) monthly_totals
    ) as by_month
  FROM donations
  WHERE status = 'completed'
  AND (start_date IS NULL OR created_at >= start_date)
  AND (end_date IS NULL OR created_at <= end_date);
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- 7. GET PROGRAM IMPACT SUMMARY
-- ============================================
CREATE OR REPLACE FUNCTION get_program_impact()
RETURNS TABLE (
  total_programs BIGINT,
  active_programs BIGINT,
  total_beneficiaries BIGINT,
  total_volunteers BIGINT,
  total_budget DECIMAL,
  by_category JSONB
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    COUNT(*)::BIGINT as total_programs,
    COUNT(*) FILTER (WHERE status = 'active')::BIGINT as active_programs,
    COALESCE(SUM(beneficiaries_count), 0)::BIGINT as total_beneficiaries,
    COALESCE(SUM(volunteers_enrolled), 0)::BIGINT as total_volunteers,
    COALESCE(SUM(budget_allocated), 0) as total_budget,
    (
      SELECT jsonb_object_agg(category_title, stats)
      FROM (
        SELECT 
          pc.title as category_title,
          jsonb_build_object(
            'programs', COUNT(p.*),
            'beneficiaries', SUM(p.beneficiaries_count),
            'budget', SUM(p.budget_allocated)
          ) as stats
        FROM programs p
        JOIN program_categories pc ON p.category_id = pc.id
        GROUP BY pc.title
      ) category_stats
    ) as by_category
  FROM programs;
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- 8. SEARCH PROGRAMS
-- ============================================
CREATE OR REPLACE FUNCTION search_programs(search_term TEXT)
RETURNS TABLE (
  id UUID,
  title VARCHAR,
  description TEXT,
  status program_status,
  category_title VARCHAR,
  similarity REAL
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    p.id,
    p.title,
    p.description,
    p.status,
    pc.title as category_title,
    (
      CASE
        WHEN LOWER(p.title) LIKE LOWER('%' || search_term || '%') THEN 1.0
        WHEN LOWER(p.description) LIKE LOWER('%' || search_term || '%') THEN 0.7
        WHEN LOWER(p.target_beneficiaries) LIKE LOWER('%' || search_term || '%') THEN 0.5
        ELSE 0.3
      END
    )::REAL as similarity
  FROM programs p
  JOIN program_categories pc ON p.category_id = pc.id
  WHERE 
    LOWER(p.title) LIKE LOWER('%' || search_term || '%')
    OR LOWER(p.description) LIKE LOWER('%' || search_term || '%')
    OR LOWER(p.target_beneficiaries) LIKE LOWER('%' || search_term || '%')
  ORDER BY similarity DESC, p.created_at DESC;
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- 9. VALIDATE EMAIL FORMAT
-- ============================================
CREATE OR REPLACE FUNCTION is_valid_email(email TEXT)
RETURNS BOOLEAN AS $$
BEGIN
  RETURN email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- 10. GET FINANCIAL SUMMARY
-- ============================================
CREATE OR REPLACE FUNCTION get_financial_summary(fiscal_year_param VARCHAR DEFAULT NULL)
RETURNS TABLE (
  fiscal_year VARCHAR,
  total_income DECIMAL,
  total_expenses DECIMAL,
  net_surplus DECIMAL,
  income_sources JSONB,
  expense_categories JSONB
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    fr.fiscal_year,
    fr.total_income,
    fr.total_expenses,
    (fr.total_income - fr.total_expenses) as net_surplus,
    fr.income_breakdown as income_sources,
    fr.expense_breakdown as expense_categories
  FROM financial_reports fr
  WHERE 
    (fiscal_year_param IS NULL OR fr.fiscal_year = fiscal_year_param)
    AND fr.is_published = true
  ORDER BY fr.fiscal_year DESC;
END;
$$ LANGUAGE plpgsql;
