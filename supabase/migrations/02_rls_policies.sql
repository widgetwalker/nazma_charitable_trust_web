-- ============================================
-- Row Level Security (RLS) Policies
-- ============================================
-- This file contains all RLS policies for secure data access

-- ============================================
-- ENABLE RLS ON ALL TABLES
-- ============================================

ALTER TABLE program_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE trustees ENABLE ROW LEVEL SECURITY;
ALTER TABLE programs ENABLE ROW LEVEL SECURITY;
ALTER TABLE contact_inquiries ENABLE ROW LEVEL SECURITY;
ALTER TABLE volunteers ENABLE ROW LEVEL SECURITY;
ALTER TABLE donations ENABLE ROW LEVEL SECURITY;
ALTER TABLE financial_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE newsletter_subscribers ENABLE ROW LEVEL SECURITY;
ALTER TABLE testimonials ENABLE ROW LEVEL SECURITY;
ALTER TABLE site_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE blog_posts ENABLE ROW LEVEL SECURITY;

-- ============================================
-- PUBLIC READ POLICIES (No Authentication Required)
-- ============================================

-- Program Categories - Public Read
CREATE POLICY "Public can view active program categories"
ON program_categories FOR SELECT
USING (is_active = true);

-- Trustees - Public Read (only public profiles)
CREATE POLICY "Public can view public trustees"
ON trustees FOR SELECT
USING (is_public = true AND is_active = true);

-- Programs - Public Read (only public programs)
CREATE POLICY "Public can view public programs"
ON programs FOR SELECT
USING (is_public = true);

-- Financial Reports - Public Read (only published)
CREATE POLICY "Public can view published financial reports"
ON financial_reports FOR SELECT
USING (is_published = true);

-- Testimonials - Public Read (only approved and public)
CREATE POLICY "Public can view approved testimonials"
ON testimonials FOR SELECT
USING (is_approved = true AND is_public = true);

-- Site Settings - Public Read (only public settings)
CREATE POLICY "Public can view public site settings"
ON site_settings FOR SELECT
USING (is_public = true);

-- Blog Posts - Public Read (only published)
CREATE POLICY "Public can view published blog posts"
ON blog_posts FOR SELECT
USING (is_published = true AND published_date <= NOW());

-- ============================================
-- PUBLIC WRITE POLICIES (For Forms)
-- ============================================

-- Contact Inquiries - Anyone can submit
CREATE POLICY "Anyone can submit contact inquiry"
ON contact_inquiries FOR INSERT
WITH CHECK (true);

-- Volunteers - Anyone can apply
CREATE POLICY "Anyone can submit volunteer application"
ON volunteers FOR INSERT
WITH CHECK (true);

-- Newsletter Subscribers - Anyone can subscribe
CREATE POLICY "Anyone can subscribe to newsletter"
ON newsletter_subscribers FOR INSERT
WITH CHECK (true);

-- Newsletter Subscribers - Can update own subscription
CREATE POLICY "Can update own newsletter subscription by email"
ON newsletter_subscribers FOR UPDATE
USING (true)
WITH CHECK (true);

-- ============================================
-- AUTHENTICATED USER POLICIES
-- ============================================
-- Note: These will be used when you implement admin authentication

-- Program Categories - Admin Full Access
CREATE POLICY "Authenticated users can manage program categories"
ON program_categories FOR ALL
USING (auth.role() = 'authenticated')
WITH CHECK (auth.role() = 'authenticated');

-- Trustees - Admin Full Access
CREATE POLICY "Authenticated users can manage trustees"
ON trustees FOR ALL
USING (auth.role() = 'authenticated')
WITH CHECK (auth.role() = 'authenticated');

-- Programs - Admin Full Access
CREATE POLICY "Authenticated users can manage programs"
ON programs FOR ALL
USING (auth.role() = 'authenticated')
WITH CHECK (auth.role() = 'authenticated');

-- Contact Inquiries - Admin Read/Update
CREATE POLICY "Authenticated users can view all contact inquiries"
ON contact_inquiries FOR SELECT
USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can update contact inquiries"
ON contact_inquiries FOR UPDATE
USING (auth.role() = 'authenticated')
WITH CHECK (auth.role() = 'authenticated');

-- Volunteers - Admin Read/Update
CREATE POLICY "Authenticated users can view all volunteers"
ON volunteers FOR SELECT
USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can update volunteers"
ON volunteers FOR UPDATE
USING (auth.role() = 'authenticated')
WITH CHECK (auth.role() = 'authenticated');

-- Donations - Admin Read
CREATE POLICY "Authenticated users can view all donations"
ON donations FOR SELECT
USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can update donations"
ON donations FOR UPDATE
USING (auth.role() = 'authenticated')
WITH CHECK (auth.role() = 'authenticated');

-- Financial Reports - Admin Full Access
CREATE POLICY "Authenticated users can manage financial reports"
ON financial_reports FOR ALL
USING (auth.role() = 'authenticated')
WITH CHECK (auth.role() = 'authenticated');

-- Newsletter Subscribers - Admin Read
CREATE POLICY "Authenticated users can view newsletter subscribers"
ON newsletter_subscribers FOR SELECT
USING (auth.role() = 'authenticated');

-- Testimonials - Admin Full Access
CREATE POLICY "Authenticated users can manage testimonials"
ON testimonials FOR ALL
USING (auth.role() = 'authenticated')
WITH CHECK (auth.role() = 'authenticated');

-- Site Settings - Admin Full Access
CREATE POLICY "Authenticated users can manage site settings"
ON site_settings FOR ALL
USING (auth.role() = 'authenticated')
WITH CHECK (auth.role() = 'authenticated');

-- Blog Posts - Admin Full Access
CREATE POLICY "Authenticated users can manage blog posts"
ON blog_posts FOR ALL
USING (auth.role() = 'authenticated')
WITH CHECK (auth.role() = 'authenticated');

-- ============================================
-- STORAGE POLICIES (For file uploads)
-- ============================================

-- Note: Configure these in Supabase dashboard > Storage
-- Buckets to create:
-- 1. program-images (public)
-- 2. trustee-photos (public)
-- 3. financial-reports (public for published reports)
-- 4. blog-images (public)
-- 5. testimonial-photos (public)

-- ============================================
-- HELPER FUNCTIONS FOR RLS
-- ============================================

-- Check if user is admin (customize based on your auth setup)
CREATE OR REPLACE FUNCTION is_admin()
RETURNS BOOLEAN AS $$
BEGIN
  RETURN (
    SELECT EXISTS (
      SELECT 1 FROM auth.users
      WHERE auth.uid() = id
      AND raw_user_meta_data->>'role' = 'admin'
    )
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Check if user is trustee
CREATE OR REPLACE FUNCTION is_trustee()
RETURNS BOOLEAN AS $$
BEGIN
  RETURN (
    SELECT EXISTS (
      SELECT 1 FROM trustees
      WHERE email = auth.jwt()->>'email'
      AND is_active = true
    )
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
