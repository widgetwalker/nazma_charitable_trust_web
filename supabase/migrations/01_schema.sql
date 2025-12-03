-- ============================================
-- Nazma Charitable Trust - Database Schema
-- ============================================
-- Version: 1.0
-- Date: December 3, 2025
-- Description: Complete database schema for the Nazma Charitable Trust web application

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- ENUMS
-- ============================================

CREATE TYPE inquiry_status AS ENUM ('new', 'in_progress', 'resolved', 'spam');
CREATE TYPE inquiry_category AS ENUM ('general', 'volunteer', 'beneficiary', 'donation', 'partnership', 'media');
CREATE TYPE donation_type AS ENUM ('one_time', 'recurring');
CREATE TYPE donation_status AS ENUM ('pending', 'completed', 'failed', 'refunded');
CREATE TYPE payment_method AS ENUM ('credit_card', 'debit_card', 'upi', 'net_banking', 'wallet');
CREATE TYPE volunteer_status AS ENUM ('applied', 'approved', 'active', 'inactive', 'rejected');
CREATE TYPE program_status AS ENUM ('planned', 'active', 'completed', 'suspended');
CREATE TYPE objective_type AS ENUM ('womens_welfare', 'elderly_support', 'science_innovation', 'general_welfare');

-- ============================================
-- TABLES
-- ============================================

-- --------------------------------------------
-- 1. PROGRAM CATEGORIES
-- --------------------------------------------
CREATE TABLE program_categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    objective_type objective_type NOT NULL UNIQUE,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    icon VARCHAR(50),
    color_scheme VARCHAR(50),
    image_url TEXT,
    display_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------
-- 2. TRUSTEES
-- --------------------------------------------
CREATE TABLE trustees (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    full_name VARCHAR(200) NOT NULL,
    role VARCHAR(100) NOT NULL, -- e.g., 'Founder', 'Trustee', 'Secretary'
    bio TEXT,
    photo_url TEXT,
    email VARCHAR(255),
    phone VARCHAR(20),
    tenure_start_date DATE,
    tenure_end_date DATE,
    display_order INTEGER DEFAULT 0,
    is_public BOOLEAN DEFAULT true,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------
-- 3. PROGRAMS
-- --------------------------------------------
CREATE TABLE programs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    category_id UUID REFERENCES program_categories(id) ON DELETE CASCADE,
    title VARCHAR(300) NOT NULL,
    slug VARCHAR(300) UNIQUE NOT NULL,
    description TEXT NOT NULL,
    short_description TEXT,
    target_beneficiaries TEXT,
    status program_status DEFAULT 'planned',
    start_date DATE,
    end_date DATE,
    image_url TEXT,
    gallery_urls TEXT[], -- Array of image URLs
    location VARCHAR(200),
    budget_allocated DECIMAL(15, 2),
    budget_spent DECIMAL(15, 2) DEFAULT 0,
    beneficiaries_count INTEGER DEFAULT 0,
    volunteers_needed INTEGER DEFAULT 0,
    volunteers_enrolled INTEGER DEFAULT 0,
    impact_metrics JSONB, -- Flexible metrics storage
    display_order INTEGER DEFAULT 0,
    is_featured BOOLEAN DEFAULT false,
    is_public BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------
-- 4. CONTACT INQUIRIES
-- --------------------------------------------
CREATE TABLE contact_inquiries (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    full_name VARCHAR(200) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    category inquiry_category DEFAULT 'general',
    subject VARCHAR(300),
    message TEXT NOT NULL,
    status inquiry_status DEFAULT 'new',
    ip_address INET,
    user_agent TEXT,
    referrer TEXT,
    assigned_to UUID REFERENCES trustees(id),
    response TEXT,
    responded_at TIMESTAMPTZ,
    is_spam BOOLEAN DEFAULT false,
    spam_score DECIMAL(3, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------
-- 5. VOLUNTEERS
-- --------------------------------------------
CREATE TABLE volunteers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    full_name VARCHAR(200) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    date_of_birth DATE,
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(100),
    pincode VARCHAR(10),
    occupation VARCHAR(200),
    organization VARCHAR(200),
    skills TEXT[], -- Array of skills
    interests objective_type[],
    availability TEXT, -- e.g., "Weekends", "Evenings", "Full-time"
    hours_per_week INTEGER,
    previous_volunteering_experience TEXT,
    motivation TEXT,
    status volunteer_status DEFAULT 'applied',
    application_date TIMESTAMPTZ DEFAULT NOW(),
    approval_date TIMESTAMPTZ,
    approved_by UUID REFERENCES trustees(id),
    total_hours_contributed INTEGER DEFAULT 0,
    programs_participated UUID[], -- Array of program IDs
    emergency_contact_name VARCHAR(200),
    emergency_contact_phone VARCHAR(20),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------
-- 6. DONATIONS
-- --------------------------------------------
CREATE TABLE donations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    donor_name VARCHAR(200),
    donor_email VARCHAR(255),
    donor_phone VARCHAR(20),
    donor_pan VARCHAR(10), -- For 80G tax receipts
    amount DECIMAL(15, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'INR',
    donation_type donation_type DEFAULT 'one_time',
    payment_method payment_method,
    status donation_status DEFAULT 'pending',
    
    -- Payment Gateway Info
    transaction_id VARCHAR(200) UNIQUE,
    payment_gateway VARCHAR(50), -- e.g., 'razorpay', 'instamojo'
    gateway_order_id VARCHAR(200),
    gateway_payment_id VARCHAR(200),
    gateway_signature VARCHAR(500),
    
    -- Allocation
    program_id UUID REFERENCES programs(id),
    allocated_to objective_type,
    
    -- Recurring Donations
    is_recurring BOOLEAN DEFAULT false,
    recurring_frequency VARCHAR(20), -- 'monthly', 'quarterly', 'yearly'
    recurring_start_date DATE,
    recurring_end_date DATE,
    parent_donation_id UUID REFERENCES donations(id), -- For recurring donations
    
    -- Tax Receipt
    receipt_number VARCHAR(100) UNIQUE,
    receipt_issued_date DATE,
    receipt_url TEXT,
    is_80g_eligible BOOLEAN DEFAULT true,
    
    -- Metadata
    donation_message TEXT,
    is_anonymous BOOLEAN DEFAULT false,
    ip_address INET,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    CONSTRAINT positive_amount CHECK (amount > 0)
);

-- --------------------------------------------
-- 7. FINANCIAL REPORTS
-- --------------------------------------------
CREATE TABLE financial_reports (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    fiscal_year VARCHAR(20) NOT NULL UNIQUE, -- e.g., '2024-2025'
    report_type VARCHAR(50) NOT NULL, -- 'annual', 'quarterly', 'audit'
    title VARCHAR(300) NOT NULL,
    
    -- Financial Data
    total_income DECIMAL(15, 2) DEFAULT 0,
    total_expenses DECIMAL(15, 2) DEFAULT 0,
    opening_balance DECIMAL(15, 2) DEFAULT 0,
    closing_balance DECIMAL(15, 2) DEFAULT 0,
    
    -- Breakdown (stored as JSON for flexibility)
    income_breakdown JSONB, -- {donations: 100000, grants: 50000, ...}
    expense_breakdown JSONB, -- {programs: 80000, admin: 20000, ...}
    program_allocation JSONB, -- {womens_welfare: 40000, ...}
    
    -- Documents
    report_url TEXT, -- PDF link
    audit_report_url TEXT,
    
    -- Audit Info
    auditor_name VARCHAR(200),
    audit_firm VARCHAR(200),
    audit_date DATE,
    audit_status VARCHAR(50),
    
    -- Compliance
    fcra_compliance BOOLEAN DEFAULT false,
    section_12a_number VARCHAR(100),
    section_80g_number VARCHAR(100),
    
    -- Publishing
    is_published BOOLEAN DEFAULT false,
    published_date DATE,
    
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------
-- 8. NEWSLETTER SUBSCRIBERS
-- --------------------------------------------
CREATE TABLE newsletter_subscribers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) NOT NULL UNIQUE,
    full_name VARCHAR(200),
    subscription_source VARCHAR(100), -- 'website', 'event', 'manual'
    interests objective_type[],
    is_subscribed BOOLEAN DEFAULT true,
    subscription_date TIMESTAMPTZ DEFAULT NOW(),
    unsubscription_date TIMESTAMPTZ,
    email_verified BOOLEAN DEFAULT false,
    verification_token UUID,
    verification_sent_at TIMESTAMPTZ,
    double_opt_in BOOLEAN DEFAULT false,
    ip_address INET,
    
    -- Preferences
    frequency_preference VARCHAR(20) DEFAULT 'monthly', -- 'weekly', 'monthly', 'quarterly'
    
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------
-- 9. TESTIMONIALS
-- --------------------------------------------
CREATE TABLE testimonials (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    author_name VARCHAR(200) NOT NULL,
    author_role VARCHAR(200), -- 'Beneficiary', 'Volunteer', 'Donor', 'Partner'
    author_photo_url TEXT,
    author_location VARCHAR(200),
    
    testimonial_text TEXT NOT NULL,
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    
    program_id UUID REFERENCES programs(id),
    category_id UUID REFERENCES program_categories(id),
    
    -- Approval Workflow
    is_approved BOOLEAN DEFAULT false,
    approved_by UUID REFERENCES trustees(id),
    approved_at TIMESTAMPTZ,
    
    -- Display
    is_featured BOOLEAN DEFAULT false,
    display_order INTEGER DEFAULT 0,
    is_public BOOLEAN DEFAULT false,
    
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------
-- 10. SITE SETTINGS
-- --------------------------------------------
CREATE TABLE site_settings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    setting_key VARCHAR(100) NOT NULL UNIQUE,
    setting_value TEXT,
    setting_type VARCHAR(50) DEFAULT 'text', -- 'text', 'number', 'boolean', 'json'
    category VARCHAR(100), -- 'contact', 'social', 'features', 'payment'
    description TEXT,
    is_public BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------
-- 11. BLOG POSTS (Optional - Future)
-- --------------------------------------------
CREATE TABLE blog_posts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(300) NOT NULL,
    slug VARCHAR(300) UNIQUE NOT NULL,
    excerpt TEXT,
    content TEXT NOT NULL,
    featured_image_url TEXT,
    author_id UUID REFERENCES trustees(id),
    category_id UUID REFERENCES program_categories(id),
    tags TEXT[],
    
    -- SEO
    meta_title VARCHAR(200),
    meta_description TEXT,
    
    -- Publishing
    is_published BOOLEAN DEFAULT false,
    published_date TIMESTAMPTZ,
    scheduled_publish_date TIMESTAMPTZ,
    
    -- Engagement
    view_count INTEGER DEFAULT 0,
    
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- INDEXES
-- ============================================

-- Contact Inquiries
CREATE INDEX idx_contact_inquiries_status ON contact_inquiries(status);
CREATE INDEX idx_contact_inquiries_category ON contact_inquiries(category);
CREATE INDEX idx_contact_inquiries_created_at ON contact_inquiries(created_at DESC);
CREATE INDEX idx_contact_inquiries_email ON contact_inquiries(email);

-- Volunteers
CREATE INDEX idx_volunteers_status ON volunteers(status);
CREATE INDEX idx_volunteers_email ON volunteers(email);
CREATE INDEX idx_volunteers_application_date ON volunteers(application_date DESC);

-- Donations
CREATE INDEX idx_donations_status ON donations(status);
CREATE INDEX idx_donations_donor_email ON donations(donor_email);
CREATE INDEX idx_donations_created_at ON donations(created_at DESC);
CREATE INDEX idx_donations_transaction_id ON donations(transaction_id);
CREATE INDEX idx_donations_program_id ON donations(program_id);

-- Programs
CREATE INDEX idx_programs_category_id ON programs(category_id);
CREATE INDEX idx_programs_status ON programs(status);
CREATE INDEX idx_programs_slug ON programs(slug);
CREATE INDEX idx_programs_is_featured ON programs(is_featured);

-- Newsletter
CREATE INDEX idx_newsletter_email ON newsletter_subscribers(email);
CREATE INDEX idx_newsletter_subscribed ON newsletter_subscribers(is_subscribed);

-- Blog Posts
CREATE INDEX idx_blog_posts_slug ON blog_posts(slug);
CREATE INDEX idx_blog_posts_published ON blog_posts(is_published, published_date DESC);
CREATE INDEX idx_blog_posts_author_id ON blog_posts(author_id);

-- Financial Reports
CREATE INDEX idx_financial_reports_fiscal_year ON financial_reports(fiscal_year);
CREATE INDEX idx_financial_reports_published ON financial_reports(is_published);

-- ============================================
-- TRIGGERS FOR UPDATED_AT
-- ============================================

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply to all tables
CREATE TRIGGER update_program_categories_updated_at BEFORE UPDATE ON program_categories FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_trustees_updated_at BEFORE UPDATE ON trustees FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_programs_updated_at BEFORE UPDATE ON programs FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_contact_inquiries_updated_at BEFORE UPDATE ON contact_inquiries FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_volunteers_updated_at BEFORE UPDATE ON volunteers FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_donations_updated_at BEFORE UPDATE ON donations FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_financial_reports_updated_at BEFORE UPDATE ON financial_reports FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_newsletter_subscribers_updated_at BEFORE UPDATE ON newsletter_subscribers FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_testimonials_updated_at BEFORE UPDATE ON testimonials FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_site_settings_updated_at BEFORE UPDATE ON site_settings FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_blog_posts_updated_at BEFORE UPDATE ON blog_posts FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- COMMENTS
-- ============================================

COMMENT ON TABLE program_categories IS 'Four main objective categories of the trust';
COMMENT ON TABLE trustees IS 'Trust board members and their information';
COMMENT ON TABLE programs IS 'All programs run by the trust';
COMMENT ON TABLE contact_inquiries IS 'Contact form submissions from website';
COMMENT ON TABLE volunteers IS 'Volunteer applications and profiles';
COMMENT ON TABLE donations IS 'Donation transactions and receipts';
COMMENT ON TABLE financial_reports IS 'Annual financial reports and audit information';
COMMENT ON TABLE newsletter_subscribers IS 'Email newsletter subscription list';
COMMENT ON TABLE testimonials IS 'Testimonials from beneficiaries and supporters';
COMMENT ON TABLE site_settings IS 'Dynamic site configuration and settings';
COMMENT ON TABLE blog_posts IS 'Blog posts and news articles';
