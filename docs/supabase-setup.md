# Supabase Setup Guide
## Nazma Charitable Trust Backend

This guide will walk you through setting up the complete Supabase backend for the Nazma Charitable Trust web application.

---

## Prerequisites

- Supabase account (free tier is sufficient to start)
- Node.js and npm installed
- Git installed

---

## Step 1: Create Supabase Project

1. Go to [https://app.supabase.com](https://app.supabase.com)
2. Click "New Project"
3. Fill in the details:
   - **Name**: `nazma-trust` (or your preferred name)
   - **Database Password**: `Dheeraj576@dj` (or use a stronger password)
   - **Region**: Choose closest to your users (India: `ap-south-1`)
   - **Pricing Plan**: Free (can upgrade later)
4. Click "Create new project"
5. Wait for the project to be provisioned (~2 minutes)

---

## Step 2: Get API Credentials

1. In your Supabase project dashboard, go to **Settings** → **API**
2. Copy the following:
   - **Project URL**: `https://your-project-ref.supabase.co`
   - **Anon/Public Key**: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`
   - **Service Role Key**: (Keep this secret! Only use server-side)

---

## Step 3: Configure Environment Variables

1. In your project root, create `.env.local`:

```bash
cp .env.local.example .env.local
```

2. Edit `.env.local` and add your Supabase credentials:

```env
VITE_SUPABASE_URL=https://your-project-ref.supabase.co
VITE_SUPABASE_ANON_KEY=your_anon_key_here
```

---

## Step 4: Run Database Migrations

You have two options to run migrations:

### Option A: Using Supabase Dashboard (Recommended for beginners)

1. Go to **SQL Editor** in your Supabase dashboard
2. Create a new query
3. Copy and paste the contents of each migration file in order:
   - `supabase/migrations/01_schema.sql`
   - `supabase/migrations/02_rls_policies.sql`
   - `supabase/migrations/03_functions.sql`
   - `supabase/migrations/04_seed_data.sql`
4. Run each query (click "Run" button)
5. Verify no errors appear

### Option B: Using Supabase CLI

1. Install Supabase CLI:

```bash
npm install -g supabase
```

2. Login to Supabase:

```bash
supabase login
```

3. Link your project:

```bash
supabase link --project-ref your-project-ref
```

4. Push migrations:

```bash
supabase db push
```

---

## Step 5: Create Storage Buckets

1. Go to **Storage** in Supabase dashboard
2. Create the following buckets:

### Bucket 1: `program-images`
- **Public**: Yes
- **Allowed MIME types**: `image/*`
- **Max file size**: 5 MB

### Bucket 2: `trustee-photos`
- **Public**: Yes
- **Allowed MIME types**: `image/*`
- **Max file size**: 2 MB

### Bucket 3: `financial-reports`
- **Public**: Yes (for published reports)
- **Allowed MIME types**: `application/pdf`
- **Max file size**: 10 MB

### Bucket 4: `blog-images`
- **Public**: Yes
- **Allowed MIME types**: `image/*`
- **Max file size**: 3 MB

### Bucket 5: `testimonial-photos`
- **Public**: Yes
- **Allowed MIME types**: `image/*`
- **Max file size**: 2 MB

---

## Step 6: Configure Storage Policies

For each bucket, add these policies in **Storage** → **Policies**:

```sql
-- Allow public read access
CREATE POLICY "Public can view files"
ON storage.objects FOR SELECT
USING (bucket_id = 'bucket-name');

-- Allow authenticated users to upload
CREATE POLICY "Authenticated can upload files"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'bucket-name' AND auth.role() = 'authenticated');

-- Allow authenticated users to delete
CREATE POLICY "Authenticated can delete files"
ON storage.objects FOR DELETE
USING (bucket_id = 'bucket-name' AND auth.role() = 'authenticated');
```

Replace `'bucket-name'` with each bucket name.

---

## Step 7: Install Required NPM Packages

```bash
npm install @supabase/supabase-js
```

The project already has React Query installed, so no additional packages needed.

---

## Step 8: Verify Database Setup

Run these queries in SQL Editor to verify:

```sql
-- Check all tables created
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
ORDER BY table_name;

-- Check program categories seeded
SELECT * FROM program_categories ORDER BY display_order;

-- Check trustees seeded
SELECT * FROM trustees ORDER BY display_order;

-- Check site settings
SELECT setting_key, category FROM site_settings ORDER BY category, setting_key;
```

Expected results:
- 11 tables created
- 4 program categories
- 3 trustees
- 20+ site settings

---

## Step 9: Test the Integration

1. Start your development server:

```bash
npm run dev
```

2. Open browser console and check for any Supabase errors
3. Try submitting a test contact form
4. Verify in Supabase dashboard → **Table Editor** → `contact_inquiries`

---

## Step 10: Setup Authentication (Optional - for Admin)

If you want to create an admin panel:

1. Go to **Authentication** → **Providers**
2. Enable "Email" provider
3. Configure email templates
4. Create admin user:

```sql
-- In SQL Editor
INSERT INTO auth.users (
  email,
  encrypted_password,
  email_confirmed_at,
  raw_user_meta_data
) VALUES (
  'admin@nazmatrust.org',
  crypt('your-password-here', gen_salt('bf')),
  NOW(),
  '{"role": "admin"}'::jsonb
);
```

---

## Database Schema Overview

### Core Tables:

1. **program_categories** - Four main objective types
2. **trustees** - Board members and their information
3. **programs** - All trust programs and initiatives
4. **contact_inquiries** - Contact form submissions
5. **volunteers** - Volunteer applications
6. **donations** - Donation transactions
7. **financial_reports** - Annual financial data
8. **newsletter_subscribers** - Email list
9. **testimonials** - User testimonials
10. **site_settings** - Dynamic configuration
11. **blog_posts** - Blog/news articles

### Key Features:

- ✅ Row Level Security (RLS) enabled
- ✅ Automated triggers (receipt generation, statistics)
- ✅ Spam detection for contact forms
- ✅ Soft deletes and audit trails
- ✅ Search functions
- ✅ Statistics calculation functions

---

## Security Best Practices

### 1. Environment Variables
- Never commit `.env.local` to Git
- Use different credentials for development and production
- Rotate secrets regularly

### 2. Row Level Security
- All tables have RLS enabled
- Public can only read published data
- Forms can be submitted anonymously
- Admin actions require authentication

### 3. API Keys
- Anon key is safe to use in frontend (read-only public data)
- Service role key should ONLY be used server-side
- Never expose service role key in client code

### 4. Rate Limiting
Consider adding rate limiting for:
- Contact form submissions (3 per hour per IP)
- Newsletter signups (1 per day per IP)
- API requests (100 per minute)

---

## Troubleshooting

### Error: "relation does not exist"
- Migrations didn't run successfully
- Re-run the migration files in order

### Error: "permission denied for table"
- RLS policies not set correctly
- Check RLS is enabled: `ALTER TABLE table_name ENABLE ROW LEVEL SECURITY;`

### Error: "duplicate key value violates unique constraint"
- Trying to insert duplicate data (email, slug, etc.)
- Check your input data

### Connection Issues
- Verify SUPABASE_URL and SUPABASE_ANON_KEY are correct
- Check network connectivity
- Verify project is not paused (free tier pauses after 1 week inactivity)

---

## Next Steps

1. **Email Integration**: Setup email service for contact form notifications
   - Use Supabase Edge Functions with Resend/SendGrid
   - See `supabase/functions/send-contact-email/` (to be created)

2. **Payment Gateway**: Integrate Razorpay for donations
   - Get Razorpay API credentials
   - Implement payment flow
   - Setup webhooks for payment confirmation

3. **Admin Dashboard**: Create admin panel for content management
   - Use Supabase Auth
   - Build admin UI with React
   - Implement CRUD operations

4. **Analytics**: Setup tracking
   - Google Analytics 4
   - Custom event tracking
   - Conversion funnels

---

## Support & Resources

- **Supabase Documentation**: https://supabase.com/docs
- **React Query Documentation**: https://tanstack.com/query/latest
- **Project Repository**: [Your GitHub URL]
- **Technical Support**: [Your email]

---

## Backup & Maintenance

### Regular Backups
Supabase provides:
- Automatic daily backups (retained for 7 days on Free tier)
- Point-in-time recovery (paid plans)
- Manual backup via CLI: `supabase db dump`

### Database Maintenance
- Monitor query performance in Dashboard → **Reports**
- Check table sizes: **Database** → **Tables**
- Optimize indexes if needed
- Clean up old data periodically

---

**Last Updated**: December 3, 2025  
**Version**: 1.0
