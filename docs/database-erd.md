# Database Entity Relationship Diagram
## Nazma Charitable Trust

```mermaid
erDiagram
    program_categories ||--o{ programs : "has"
    program_categories ||--o{ testimonials : "categorizes"
    program_categories ||--o{ blog_posts : "categorizes"
    
    trustees ||--o{ contact_inquiries : "manages"
    trustees ||--o{ volunteers : "approves"
    trustees ||--o{ testimonials : "approves"
    trustees ||--o{ blog_posts : "authors"
    
    programs ||--o{ donations : "receives"
    programs ||--o{ testimonials : "featured in"
    
    program_categories {
        uuid id PK
        enum(objective_type) objective_type UK
        varchar title
        text description
        varchar icon
        varchar color_scheme
        text image_url
        int display_order
        bool is_active
        timestamptz created_at
        timestamptz updated_at
    }
    
    trustees {
        uuid id PK
        varchar full_name
        varchar role
        text bio
        text photo_url
        varchar email
        varchar phone
        date tenure_start_date
        date tenure_end_date
        int display_order
        bool is_public
        bool is_active
        timestamptz created_at
        timestamptz updated_at
    }
    
    programs {
        uuid id PK
        uuid category_id FK
        varchar title
        varchar slug UK
        text description
        text short_description
        text target_beneficiaries
        enum(program_status) status
        date start_date
        date end_date
        text image_url
        text[] gallery_urls
        varchar location
        decimal budget_allocated
        decimal budget_spent
        int beneficiaries_count
        int volunteers_needed
        int volunteers_enrolled
        jsonb impact_metrics
        int display_order
        bool is_featured
        bool is_public
        timestamptz created_at
        timestamptz updated_at
    }
    
    contact_inquiries {
        uuid id PK
        varchar full_name
        varchar email
        varchar phone
        enum(inquiry_category) category
        varchar subject
        text message
        enum(inquiry_status) status
        inet ip_address
        text user_agent
        text referrer
        uuid assigned_to FK
        text response
        timestamptz responded_at
        bool is_spam
        decimal spam_score
        timestamptz created_at
        timestamptz updated_at
    }
    
    volunteers {
        uuid id PK
        varchar full_name
        varchar email UK
        varchar phone
        date date_of_birth
        text address
        varchar city
        varchar state
        varchar pincode
        varchar occupation
        varchar organization
        text[] skills
        enum(objective_type)[] interests
        text availability
        int hours_per_week
        text previous_experience
        text motivation
        enum(volunteer_status) status
        timestamptz application_date
        timestamptz approval_date
        uuid approved_by FK
        int total_hours_contributed
        uuid[] programs_participated
        varchar emergency_contact_name
        varchar emergency_contact_phone
        bool is_active
        timestamptz created_at
        timestamptz updated_at
    }
    
    donations {
        uuid id PK
        varchar donor_name
        varchar donor_email
        varchar donor_phone
        varchar donor_pan
        decimal amount
        varchar currency
        enum(donation_type) donation_type
        enum(payment_method) payment_method
        enum(donation_status) status
        varchar transaction_id UK
        varchar payment_gateway
        varchar gateway_order_id
        varchar gateway_payment_id
        varchar gateway_signature
        uuid program_id FK
        enum(objective_type) allocated_to
        bool is_recurring
        varchar recurring_frequency
        date recurring_start_date
        date recurring_end_date
        uuid parent_donation_id FK
        varchar receipt_number UK
        date receipt_issued_date
        text receipt_url
        bool is_80g_eligible
        text donation_message
        bool is_anonymous
        inet ip_address
        timestamptz created_at
        timestamptz updated_at
    }
    
    financial_reports {
        uuid id PK
        varchar fiscal_year UK
        varchar report_type
        varchar title
        decimal total_income
        decimal total_expenses
        decimal opening_balance
        decimal closing_balance
        jsonb income_breakdown
        jsonb expense_breakdown
        jsonb program_allocation
        text report_url
        text audit_report_url
        varchar auditor_name
        varchar audit_firm
        date audit_date
        varchar audit_status
        bool fcra_compliance
        varchar section_12a_number
        varchar section_80g_number
        bool is_published
        date published_date
        timestamptz created_at
        timestamptz updated_at
    }
    
    newsletter_subscribers {
        uuid id PK
        varchar email UK
        varchar full_name
        varchar subscription_source
        enum(objective_type)[] interests
        bool is_subscribed
        timestamptz subscription_date
        timestamptz unsubscription_date
        bool email_verified
        uuid verification_token
        timestamptz verification_sent_at
        bool double_opt_in
        inet ip_address
        varchar frequency_preference
        timestamptz created_at
        timestamptz updated_at
    }
    
    testimonials {
        uuid id PK
        varchar author_name
        varchar author_role
        text author_photo_url
        varchar author_location
        text testimonial_text
        int rating
        uuid program_id FK
        uuid category_id FK
        bool is_approved
        uuid approved_by FK
        timestamptz approved_at
        bool is_featured
        int display_order
        bool is_public
        timestamptz created_at
        timestamptz updated_at
    }
    
    site_settings {
        uuid id PK
        varchar setting_key UK
        text setting_value
        varchar setting_type
        varchar category
        text description
        bool is_public
        timestamptz created_at
        timestamptz updated_at
    }
    
    blog_posts {
        uuid id PK
        varchar title
        varchar slug UK
        text excerpt
        text content
        text featured_image_url
        uuid author_id FK
        uuid category_id FK
        text[] tags
        varchar meta_title
        text meta_description
        bool is_published
        timestamptz published_date
        timestamptz scheduled_publish_date
        int view_count
        timestamptz created_at
        timestamptz updated_at
    }
```

## Database Statistics

### Tables: 11
- program_categories
- trustees
- programs
- contact_inquiries
- volunteers
- donations
- financial_reports
- newsletter_subscribers
- testimonials
- site_settings
- blog_posts

### Enums: 8
- inquiry_status
- inquiry_category
- donation_type
- donation_status
- payment_method
- volunteer_status
- program_status
- objective_type

### Key Relationships:

1. **Program Categories → Programs**: One-to-Many
   - Each category has multiple programs

2. **Programs → Donations**: One-to-Many
   - Programs can receive donations

3. **Trustees → Contact Inquiries**: One-to-Many
   - Trustees can be assigned to handle inquiries

4. **Trustees → Volunteers**: One-to-Many
   - Trustees approve volunteer applications

5. **Programs → Testimonials**: One-to-Many
   - Testimonials can be linked to specific programs

6. **Trustees → Blog Posts**: One-to-Many
   - Trustees can author blog posts

### Indexes:

- Primary keys on all tables (UUID)
- Unique constraints on emails, slugs, transaction IDs
- Foreign key indexes for relationships
- Performance indexes on frequently queried fields (status, created_at, etc.)

### Security Features:

- Row Level Security (RLS) enabled on all tables
- Public read access for published content only
- Authenticated access required for sensitive data
- Form submissions allowed without authentication

### Automated Features:

- `updated_at` triggers on all tables
- Receipt number generation for donations
- Spam detection for contact forms
- Newsletter verification token generation
- Program statistics updates on donations
- Blog view count tracking
