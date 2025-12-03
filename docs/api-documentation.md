# Backend API Documentation
## Nazma Charitable Trust

## Overview

This document provides a complete reference for the backend API powered by Supabase.

---

## Base URL

```
https://your-project-ref.supabase.co/rest/v1/
```

All API requests use the Supabase REST API which is automatically generated from the database schema.

---

## Authentication

### Public Access (No Auth Required)

The following endpoints are publicly accessible with just the `anon` key:

- GET `/program_categories` - List all active program categories
- GET `/trustees` - List all public trustees
- GET `/programs` - List all public programs
- GET `/financial_reports` - List published financial reports
- GET `/testimonials` - List approved testimonials
- GET `/blog_posts` - List published blog posts
- GET `/site_settings` - List public settings
- POST `/contact_inquiries` - Submit contact form
- POST `/volunteers` - Submit volunteer application
- POST `/newsletter_subscribers` - Subscribe to newsletter

### Admin Access (Auth Required)

Protected endpoints require authentication with a valid JWT token:

- All POST, PUT, PATCH, DELETE operations on content tables
- Access to non-published data
- User management operations

---

## API Endpoints

### Program Categories

#### List All Categories
```http
GET /program_categories?is_active=eq.true&order=display_order.asc
```

**Response:**
```json
[
  {
    "id": "uuid",
    "objective_type": "womens_welfare",
    "title": "Women's Welfare & Empowerment",
    "description": "...",
    "icon": "👩",
    "color_scheme": "primary",
    "image_url": "https://...",
    "display_order": 1,
    "is_active": true,
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  }
]
```

---

### Programs

#### List All Programs
```http
GET /programs?is_public=eq.true&order=display_order.asc&select=*,category:program_categories(*)
```

#### Get Single Program by Slug
```http
GET /programs?slug=eq.program-slug&is_public=eq.true&select=*,category:program_categories(*)
```

#### Get Featured Programs
```http
GET /programs?is_featured=eq.true&is_public=eq.true&limit=3&select=*,category:program_categories(*)
```

**Response:**
```json
{
  "id": "uuid",
  "category_id": "uuid",
  "title": "Skill Development for Women",
  "slug": "skill-development-women",
  "description": "Full description...",
  "short_description": "Brief description",
  "target_beneficiaries": "Women aged 18-45",
  "status": "active",
  "start_date": "2024-01-01",
  "image_url": "https://...",
  "beneficiaries_count": 100,
  "is_featured": true,
  "category": {
    "id": "uuid",
    "title": "Women's Welfare & Empowerment",
    "objective_type": "womens_welfare"
  }
}
```

---

### Trustees

#### List All Trustees
```http
GET /trustees?is_public=eq.true&is_active=eq.true&order=display_order.asc
```

**Response:**
```json
[
  {
    "id": "uuid",
    "full_name": "Kaosar Ahmed",
    "role": "Founder & Trustee",
    "bio": "Visionary founder...",
    "photo_url": "https://...",
    "tenure_start_date": "2024-01-01",
    "display_order": 1
  }
]
```

---

### Financial Reports

#### List Published Reports
```http
GET /financial_reports?is_published=eq.true&order=fiscal_year.desc
```

#### Get Latest Report
```http
GET /financial_reports?is_published=eq.true&order=fiscal_year.desc&limit=1
```

**Response:**
```json
{
  "id": "uuid",
  "fiscal_year": "2024-2025",
  "report_type": "annual",
  "title": "Annual Financial Report 2024-25",
  "total_income": 1000000.00,
  "total_expenses": 800000.00,
  "income_breakdown": {
    "donations": 700000,
    "grants": 300000
  },
  "expense_breakdown": {
    "programs": 600000,
    "administration": 200000
  },
  "report_url": "https://.../report.pdf",
  "is_published": true,
  "published_date": "2024-04-01"
}
```

---

### Contact Form

#### Submit Inquiry
```http
POST /contact_inquiries
Content-Type: application/json
```

**Request Body:**
```json
{
  "full_name": "John Doe",
  "email": "john@example.com",
  "phone": "+91-9876543210",
  "category": "general",
  "subject": "Inquiry about programs",
  "message": "I would like to know more about..."
}
```

**Response:**
```json
{
  "id": "uuid",
  "full_name": "John Doe",
  "email": "john@example.com",
  "status": "new",
  "is_spam": false,
  "created_at": "2024-01-01T12:00:00Z"
}
```

---

### Volunteer Application

#### Submit Application
```http
POST /volunteers
Content-Type: application/json
```

**Request Body:**
```json
{
  "full_name": "Jane Smith",
  "email": "jane@example.com",
  "phone": "+91-9876543210",
  "city": "Kolkata",
  "state": "West Bengal",
  "skills": ["Teaching", "Social Work"],
  "interests": ["womens_welfare", "elderly_support"],
  "availability": "Weekends",
  "hours_per_week": 10,
  "motivation": "I want to contribute to society..."
}
```

**Response:**
```json
{
  "id": "uuid",
  "full_name": "Jane Smith",
  "email": "jane@example.com",
  "status": "applied",
  "application_date": "2024-01-01T12:00:00Z"
}
```

---

### Newsletter Subscription

#### Subscribe
```http
POST /newsletter_subscribers
Content-Type: application/json
```

**Request Body:**
```json
{
  "email": "subscriber@example.com",
  "full_name": "Subscriber Name",
  "interests": ["womens_welfare", "science_innovation"]
}
```

#### Unsubscribe
```http
PATCH /newsletter_subscribers?email=eq.subscriber@example.com
Content-Type: application/json
```

**Request Body:**
```json
{
  "is_subscribed": false,
  "unsubscription_date": "2024-01-01T12:00:00Z"
}
```

---

### Blog Posts

#### List Published Posts
```http
GET /blog_posts?is_published=eq.true&published_date=lte.now&order=published_date.desc&select=*,author:trustees(*),category:program_categories(*)
```

#### Get Single Post by Slug
```http
GET /blog_posts?slug=eq.post-slug&is_published=eq.true&select=*,author:trustees(*),category:program_categories(*)
```

**Response:**
```json
{
  "id": "uuid",
  "title": "Our Impact in 2024",
  "slug": "our-impact-2024",
  "excerpt": "Brief summary...",
  "content": "Full content in markdown...",
  "featured_image_url": "https://...",
  "published_date": "2024-01-01T00:00:00Z",
  "view_count": 150,
  "author": {
    "full_name": "Kaosar Ahmed",
    "role": "Founder & Trustee"
  },
  "category": {
    "title": "General Social Welfare"
  }
}
```

---

### Site Settings

#### Get Public Settings
```http
GET /site_settings?is_public=eq.true
```

**Response:**
```json
[
  {
    "setting_key": "contact_email",
    "setting_value": "info@nazmatrust.org",
    "category": "contact"
  },
  {
    "setting_key": "contact_phone",
    "setting_value": "+91-XXXXXXXXXX",
    "category": "contact"
  }
]
```

---

## Database Functions (RPC)

### Get Donation Statistics
```http
POST /rpc/get_donation_stats
Content-Type: application/json
```

**Request Body:**
```json
{
  "start_date": "2024-01-01",
  "end_date": "2024-12-31"
}
```

**Response:**
```json
{
  "total_donations": 150,
  "total_amount": 1500000.00,
  "average_donation": 10000.00,
  "by_objective": {
    "womens_welfare": 600000,
    "elderly_support": 400000,
    "science_innovation": 300000,
    "general_welfare": 200000
  },
  "by_month": {
    "2024-01": 100000,
    "2024-02": 150000
  }
}
```

### Get Program Impact
```http
POST /rpc/get_program_impact
```

**Response:**
```json
{
  "total_programs": 10,
  "active_programs": 6,
  "total_beneficiaries": 1000,
  "total_volunteers": 50,
  "total_budget": 2000000.00,
  "by_category": {
    "Women's Welfare & Empowerment": {
      "programs": 3,
      "beneficiaries": 400,
      "budget": 800000
    }
  }
}
```

### Search Programs
```http
POST /rpc/search_programs
Content-Type: application/json
```

**Request Body:**
```json
{
  "search_term": "women empowerment"
}
```

**Response:**
```json
[
  {
    "id": "uuid",
    "title": "Skill Development for Women",
    "description": "...",
    "status": "active",
    "category_title": "Women's Welfare & Empowerment",
    "similarity": 1.0
  }
]
```

---

## Error Responses

### 400 Bad Request
```json
{
  "code": "PGRST204",
  "message": "Invalid input",
  "details": "Column 'email' violates not-null constraint",
  "hint": null
}
```

### 401 Unauthorized
```json
{
  "message": "JWT expired"
}
```

### 404 Not Found
```json
{
  "code": "PGRST116",
  "message": "The result contains 0 rows"
}
```

### 409 Conflict
```json
{
  "code": "23505",
  "message": "duplicate key value violates unique constraint",
  "details": "Key (email)=(test@example.com) already exists."
}
```

---

## Rate Limiting

Supabase free tier limits:
- 500 MB database size
- 2 GB bandwidth
- 50,000 monthly active users
- API requests: fair use policy

For production, consider upgrading to Pro tier for:
- Higher limits
- Point-in-time recovery
- Better performance

---

## Using with React Query

Example hook usage:

```typescript
import { useProgramCategories, useSubmitContactForm } from '@/hooks/api-hooks';

// Fetching data
function MyComponent() {
  const { data, isLoading, error } = useProgramCategories();
  
  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;
  
  return <div>{/* render data */}</div>;
}

// Submitting data
function ContactForm() {
  const mutation = useSubmitContactForm();
  
  const handleSubmit = (formData) => {
    mutation.mutate(formData, {
      onSuccess: () => {
        toast.success('Form submitted successfully!');
      },
      onError: (error) => {
        toast.error(error.message);
      }
    });
  };
  
  return <form onSubmit={handleSubmit}>{/* form fields */}</form>;
}
```

---

## Best Practices

1. **Always validate input** on the frontend before submitting
2. **Handle errors gracefully** with user-friendly messages
3. **Use React Query** for caching and automatic refetching
4. **Implement loading states** for better UX
5. **Debounce search requests** to reduce API calls
6. **Use pagination** for large datasets
7. **Cache static data** like categories and settings
8. **Implement optimistic updates** for better perceived performance

---

## Security Considerations

1. **Never expose service role key** in client-side code
2. **Validate all user input** to prevent injection attacks
3. **Use RLS policies** to restrict data access
4. **Rate limit** form submissions to prevent spam
5. **Sanitize** file uploads and user-generated content
6. **Use HTTPS** for all connections
7. **Implement CORS** properly for production

---

**Last Updated**: December 3, 2025  
**API Version**: 1.0
