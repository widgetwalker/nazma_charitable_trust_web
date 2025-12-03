/**
 * TypeScript types for database tables
 * Generated from Supabase schema
 */

// ============================================
// ENUMS
// ============================================

export type InquiryStatus = 'new' | 'in_progress' | 'resolved' | 'spam';
export type InquiryCategory = 'general' | 'volunteer' | 'beneficiary' | 'donation' | 'partnership' | 'media';
export type DonationType = 'one_time' | 'recurring';
export type DonationStatus = 'pending' | 'completed' | 'failed' | 'refunded';
export type PaymentMethod = 'credit_card' | 'debit_card' | 'upi' | 'net_banking' | 'wallet';
export type VolunteerStatus = 'applied' | 'approved' | 'active' | 'inactive' | 'rejected';
export type ProgramStatus = 'planned' | 'active' | 'completed' | 'suspended';
export type ObjectiveType = 'womens_welfare' | 'elderly_support' | 'science_innovation' | 'general_welfare';

// ============================================
// DATABASE TABLES
// ============================================

export interface ProgramCategory {
  id: string;
  objective_type: ObjectiveType;
  title: string;
  description: string;
  icon?: string;
  color_scheme?: string;
  image_url?: string;
  display_order: number;
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

export interface Trustee {
  id: string;
  full_name: string;
  role: string;
  bio?: string;
  photo_url?: string;
  email?: string;
  phone?: string;
  tenure_start_date?: string;
  tenure_end_date?: string;
  display_order: number;
  is_public: boolean;
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

export interface Program {
  id: string;
  category_id: string;
  title: string;
  slug: string;
  description: string;
  short_description?: string;
  target_beneficiaries?: string;
  status: ProgramStatus;
  start_date?: string;
  end_date?: string;
  image_url?: string;
  gallery_urls?: string[];
  location?: string;
  budget_allocated?: number;
  budget_spent?: number;
  beneficiaries_count?: number;
  volunteers_needed?: number;
  volunteers_enrolled?: number;
  impact_metrics?: Record<string, any>;
  display_order: number;
  is_featured: boolean;
  is_public: boolean;
  created_at: string;
  updated_at: string;
  // Relations
  category?: ProgramCategory;
}

export interface ContactInquiry {
  id: string;
  full_name: string;
  email: string;
  phone?: string;
  category: InquiryCategory;
  subject?: string;
  message: string;
  status: InquiryStatus;
  ip_address?: string;
  user_agent?: string;
  referrer?: string;
  assigned_to?: string;
  response?: string;
  responded_at?: string;
  is_spam: boolean;
  spam_score?: number;
  created_at: string;
  updated_at: string;
}

export interface Volunteer {
  id: string;
  full_name: string;
  email: string;
  phone?: string;
  date_of_birth?: string;
  address?: string;
  city?: string;
  state?: string;
  pincode?: string;
  occupation?: string;
  organization?: string;
  skills?: string[];
  interests?: ObjectiveType[];
  availability?: string;
  hours_per_week?: number;
  previous_volunteering_experience?: string;
  motivation?: string;
  status: VolunteerStatus;
  application_date: string;
  approval_date?: string;
  approved_by?: string;
  total_hours_contributed?: number;
  programs_participated?: string[];
  emergency_contact_name?: string;
  emergency_contact_phone?: string;
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

export interface Donation {
  id: string;
  donor_name?: string;
  donor_email?: string;
  donor_phone?: string;
  donor_pan?: string;
  amount: number;
  currency: string;
  donation_type: DonationType;
  payment_method?: PaymentMethod;
  status: DonationStatus;
  transaction_id?: string;
  payment_gateway?: string;
  gateway_order_id?: string;
  gateway_payment_id?: string;
  gateway_signature?: string;
  program_id?: string;
  allocated_to?: ObjectiveType;
  is_recurring: boolean;
  recurring_frequency?: string;
  recurring_start_date?: string;
  recurring_end_date?: string;
  parent_donation_id?: string;
  receipt_number?: string;
  receipt_issued_date?: string;
  receipt_url?: string;
  is_80g_eligible: boolean;
  donation_message?: string;
  is_anonymous: boolean;
  ip_address?: string;
  created_at: string;
  updated_at: string;
  // Relations
  program?: Program;
}

export interface FinancialReport {
  id: string;
  fiscal_year: string;
  report_type: string;
  title: string;
  total_income?: number;
  total_expenses?: number;
  opening_balance?: number;
  closing_balance?: number;
  income_breakdown?: Record<string, number>;
  expense_breakdown?: Record<string, number>;
  program_allocation?: Record<string, number>;
  report_url?: string;
  audit_report_url?: string;
  auditor_name?: string;
  audit_firm?: string;
  audit_date?: string;
  audit_status?: string;
  fcra_compliance: boolean;
  section_12a_number?: string;
  section_80g_number?: string;
  is_published: boolean;
  published_date?: string;
  created_at: string;
  updated_at: string;
}

export interface NewsletterSubscriber {
  id: string;
  email: string;
  full_name?: string;
  subscription_source?: string;
  interests?: ObjectiveType[];
  is_subscribed: boolean;
  subscription_date: string;
  unsubscription_date?: string;
  email_verified: boolean;
  verification_token?: string;
  verification_sent_at?: string;
  double_opt_in: boolean;
  ip_address?: string;
  frequency_preference: string;
  created_at: string;
  updated_at: string;
}

export interface Testimonial {
  id: string;
  author_name: string;
  author_role?: string;
  author_photo_url?: string;
  author_location?: string;
  testimonial_text: string;
  rating?: number;
  program_id?: string;
  category_id?: string;
  is_approved: boolean;
  approved_by?: string;
  approved_at?: string;
  is_featured: boolean;
  display_order: number;
  is_public: boolean;
  created_at: string;
  updated_at: string;
  // Relations
  program?: Program;
  category?: ProgramCategory;
}

export interface SiteSetting {
  id: string;
  setting_key: string;
  setting_value?: string;
  setting_type: string;
  category?: string;
  description?: string;
  is_public: boolean;
  created_at: string;
  updated_at: string;
}

export interface BlogPost {
  id: string;
  title: string;
  slug: string;
  excerpt?: string;
  content: string;
  featured_image_url?: string;
  author_id?: string;
  category_id?: string;
  tags?: string[];
  meta_title?: string;
  meta_description?: string;
  is_published: boolean;
  published_date?: string;
  scheduled_publish_date?: string;
  view_count: number;
  created_at: string;
  updated_at: string;
  // Relations
  author?: Trustee;
  category?: ProgramCategory;
}

// ============================================
// FORM INPUT TYPES
// ============================================

export interface ContactFormInput {
  full_name: string;
  email: string;
  phone?: string;
  category: InquiryCategory;
  subject?: string;
  message: string;
}

export interface VolunteerFormInput {
  full_name: string;
  email: string;
  phone?: string;
  date_of_birth?: string;
  address?: string;
  city?: string;
  state?: string;
  pincode?: string;
  occupation?: string;
  organization?: string;
  skills?: string[];
  interests?: ObjectiveType[];
  availability?: string;
  hours_per_week?: number;
  previous_volunteering_experience?: string;
  motivation?: string;
  emergency_contact_name?: string;
  emergency_contact_phone?: string;
}

export interface NewsletterFormInput {
  email: string;
  full_name?: string;
  interests?: ObjectiveType[];
}

export interface DonationFormInput {
  donor_name?: string;
  donor_email?: string;
  donor_phone?: string;
  donor_pan?: string;
  amount: number;
  donation_type: DonationType;
  allocated_to?: ObjectiveType;
  program_id?: string;
  donation_message?: string;
  is_anonymous: boolean;
  recurring_frequency?: string;
}

// ============================================
// API RESPONSE TYPES
// ============================================

export interface ApiResponse<T> {
  data?: T;
  error?: string;
  message?: string;
}

export interface PaginatedResponse<T> {
  data: T[];
  count: number;
  page: number;
  pageSize: number;
  totalPages: number;
}

// ============================================
// STATISTICS TYPES
// ============================================

export interface DonationStats {
  total_donations: number;
  total_amount: number;
  average_donation: number;
  by_objective: Record<ObjectiveType, number>;
  by_month: Record<string, number>;
}

export interface ProgramImpact {
  total_programs: number;
  active_programs: number;
  total_beneficiaries: number;
  total_volunteers: number;
  total_budget: number;
  by_category: Record<string, {
    programs: number;
    beneficiaries: number;
    budget: number;
  }>;
}

export interface FinancialSummary {
  fiscal_year: string;
  total_income: number;
  total_expenses: number;
  net_surplus: number;
  income_sources: Record<string, number>;
  expense_categories: Record<string, number>;
}
