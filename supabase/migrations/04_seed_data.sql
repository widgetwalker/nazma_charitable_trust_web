-- ============================================
-- Seed Data for Nazma Charitable Trust
-- ============================================

-- ============================================
-- 1. PROGRAM CATEGORIES
-- ============================================
INSERT INTO program_categories (objective_type, title, description, icon, color_scheme, display_order) VALUES
(
  'womens_welfare',
  'Women''s Welfare & Empowerment',
  'Skill development programs, vocational training, and entrepreneurship support to empower women economically and socially.',
  '👩',
  'primary',
  1
),
(
  'elderly_support',
  'Support for the Elderly',
  'Community support groups healthcare assistance, and social engagement programs ensuring dignity and care for senior citizens.',
  '🤝',
  'secondary',
  2
),
(
  'science_innovation',
  'Promotion of Science & Innovation',
  'STEM workshops, innovation labs, and educational programs fostering scientific thinking and technological advancement.',
  '🔬',
  'accent',
  3
),
(
  'general_welfare',
  'General Social Welfare',
  'Comprehensive initiatives in education, healthcare, environmental conservation, and disaster relief for community wellbeing.',
  '🌍',
  'muted',
  4
);

-- ============================================
-- 2. TRUSTEES
-- ============================================
INSERT INTO trustees (full_name, role, bio, tenure_start_date, display_order, is_public) VALUES
(
  'Kaosar Ahmed',
  'Founder & Trustee',
  'Visionary founder of Nazma Social Development Trust, dedicated to empowering communities through sustainable development initiatives.',
  '2024-01-01',
  1,
  true
),
(
  'Imrana Begum',
  'Trustee',
  'Committed to women''s welfare and empowerment, bringing years of experience in social development.',
  '2024-01-01',
  2,
  true
),
(
  'Farhana Begum',
  'Trustee',
  'Passionate about elderly care and community support programs, ensuring dignity for all beneficiaries.',
  '2024-01-01',
  3,
  true
);

-- ============================================
-- 3. SITE SETTINGS
-- ============================================
INSERT INTO site_settings (setting_key, setting_value, setting_type, category, description, is_public) VALUES
-- Contact Information
('contact_email', 'info@nazmatrust.org', 'text', 'contact', 'Primary contact email', true),
('contact_phone', '+91-XXXXXXXXXX', 'text', 'contact', 'Primary contact phone', true),
('contact_address', 'Nagaland, India', 'text', 'contact', 'Office address', true),
('office_hours', 'Monday - Friday: 9:00 AM - 5:00 PM', 'text', 'contact', 'Office working hours', true),

-- Social Media
('social_facebook', '', 'text', 'social', 'Facebook page URL', true),
('social_twitter', '', 'text', 'social', 'Twitter profile URL', true),
('social_instagram', '', 'text', 'social', 'Instagram profile URL', true),
('social_linkedin', '', 'text', 'social', 'LinkedIn profile URL', true),
('social_youtube', '', 'text', 'social', 'YouTube channel URL', true),

-- Organization Info
('trust_registration_number', 'REG/XXXX/YYYY', 'text', 'organization', 'Trust registration number', true),
('trust_registration_date', '2024-01-01', 'text', 'organization', 'Trust registration date', true),
('trust_registered_under', 'Indian Trusts Act, 1882', 'text', 'organization', 'Registration act', true),
('section_12a_number', '', 'text', 'organization', '12A registration number', true),
('section_80g_number', '', 'text', 'organization', '80G registration number', true),
('pan_number', '', 'text', 'organization', 'PAN number', false),

-- Feature Toggles
('donations_enabled', 'false', 'boolean', 'features', 'Enable donation feature', false),
('volunteer_signup_enabled', 'true', 'boolean', 'features', 'Enable volunteer signup', false),
('newsletter_enabled', 'true', 'boolean', 'features', 'Enable newsletter', false),
('blog_enabled', 'false', 'boolean', 'features', 'Enable blog section', false),
('testimonials_enabled', 'false', 'boolean', 'features', 'Show testimonials section', false),

-- Payment Gateway
('payment_gateway', 'razorpay', 'text', 'payment', 'Payment gateway provider', false),
('payment_gateway_key', '', 'text', 'payment', 'Payment gateway API key', false),
('minimum_donation_amount', '100', 'number', 'payment', 'Minimum donation amount in INR', false),

-- SEO & Meta
('site_title', 'Nazma Charitable Trust', 'text', 'seo', 'Site title', true),
('site_tagline', 'Empowering Communities, Transforming Lives', 'text', 'seo', 'Site tagline', true),
('site_description', 'Nazma Social Development Trust works towards women''s empowerment, elderly support, science innovation, and general social welfare.', 'text', 'seo', 'Site meta description', true),

-- Analytics
('google_analytics_id', '', 'text', 'analytics', 'Google Analytics tracking ID', false),
('facebook_pixel_id', '', 'text', 'analytics', 'Facebook Pixel ID', false);

-- ============================================
-- 4. SAMPLE PROGRAM (Optional)
-- ============================================
INSERT INTO programs (
  category_id,
  title,
  slug,
  description,
  short_description,
  target_beneficiaries,
  status,
  display_order,
  is_public
)
SELECT
  pc.id,
  'Skill Development for Women',
  'skill-development-women',
  'A comprehensive program providing vocational training and skill development opportunities for women in rural areas. Includes tailoring, handicrafts, digital literacy, and entrepreneurship training.',
  'Vocational training and entrepreneurship for rural women',
  'Women aged 18-45 in rural Nagaland',
  'planned',
  1,
  true
FROM program_categories pc
WHERE pc.objective_type = 'womens_welfare';

INSERT INTO programs (
  category_id,
  title,
  slug,
  description,
  short_description,
  target_beneficiaries,
  status,
  display_order,
  is_public
)
SELECT
  pc.id,
  'STEM Workshop for Youth',
  'stem-workshop-youth',
  'Hands-on STEM workshops and innovation labs for school and college students, fostering scientific thinking and technological skills.',
  'Science and technology workshops for students',
  'Students aged 14-22',
  'planned',
  2,
  true
FROM program_categories pc
WHERE pc.objective_type = 'science_innovation';

-- ============================================
-- 5. SAMPLE TESTIMONIAL (Optional)
-- ============================================
-- Uncomment when you have actual testimonials
/*
INSERT INTO testimonials (
  author_name,
  author_role,
  author_location,
  testimonial_text,
  rating,
  is_approved,
  is_public,
  display_order
) VALUES (
  'Sample Beneficiary',
  'Program Participant',
  'Nagaland',
  'This is a sample testimonial. The trust has made a significant impact on our community.',
  5,
  false,
  false,
  1
);
*/

-- ============================================
-- VERIFICATION QUERIES
-- ============================================
-- Run these to verify seed data

-- SELECT * FROM program_categories ORDER BY display_order;
-- SELECT * FROM trustees ORDER BY display_order;
-- SELECT setting_key, setting_value, category FROM site_settings ORDER BY category, setting_key;
-- SELECT p.title, pc.title as category FROM programs p JOIN program_categories pc ON p.category_id = pc.id;
