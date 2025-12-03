# Nazma Charitable Trust - Backend Overview

## 🎯 What's Been Created

Your complete backend infrastructure is now ready! Here's what you have:

### ✅ Database Schema (11 Tables)
1. **program_categories** - Four main objective types
2. **trustees** - Board members and leadership
3. **programs** - Trust programs and initiatives
4. **contact_inquiries** - Contact form submissions
5. **volunteers** - Volunteer applications and management
6. **donations** - Donation tracking and receipts
7. **financial_reports** - Annual financial transparency
8. **newsletter_subscribers** - Email list management
9. **testimonials** - Success stories
10. **site_settings** - Dynamic configuration
11. **blog_posts** - News and updates

### 🔒 Security Features
- ✅ Row Level Security (RLS) on all tables
- ✅ Public read access for published content
- ✅ Protected write access for authenticated users
- ✅ Spam detection for contact forms
- ✅ Input validation and sanitization

### ⚡ Automated Features
- ✅ Auto-generated donation receipt numbers
- ✅ Automatic program statistics updates
- ✅ Spam detection with scoring
- ✅ Newsletter verification tokens
- ✅ Updated timestamp triggers

### 🛠️ Developer Tools
- ✅ TypeScript type definitions
- ✅ React Query hooks for all operations
- ✅ Supabase client configuration
- ✅ Error handling utilities

---

## 📁 File Structure

```
nazma_charitable_trust_web-main/
├── supabase/
│   └── migrations/
│       ├── 01_schema.sql          # Database tables and structure
│       ├── 02_rls_policies.sql    # Security policies
│       ├── 03_functions.sql       # Database functions and triggers
│       └── 04_seed_data.sql       # Initial data
├── src/
│   ├── lib/
│   │   ├── supabase.ts            # Supabase client config
│   │   └── types.ts               # TypeScript types
│   └── hooks/
│       └── api-hooks.ts           # React Query hooks
├── docs/
│   ├── supabase-setup.md          # Setup instructions
│   ├── api-documentation.md       # API reference
│   └── database-erd.md            # Database diagram
└── .env.local.example             # Environment variables template
```

---

## 🚀 Quick Start

### 1. Install Dependencies
```bash
npm install
```

Already installed: `@supabase/supabase-js`

### 2. Setup Supabase Project

1. Go to [https://app.supabase.com](https://app.supabase.com)
2. Create a new project
3. Copy your credentials

### 3. Configure Environment

Create `.env.local`:
```bash
cp .env.local.example .env.local
```

Edit `.env.local`:
```env
VITE_SUPABASE_URL=https://your-project-ref.supabase.co
VITE_SUPABASE_ANON_KEY=your_anon_key_here
```

### 4. Run Migrations

Go to Supabase Dashboard → SQL Editor

Run each file in order:
1. `01_schema.sql`
2. `02_rls_policies.sql`
3. `03_functions.sql`
4. `04_seed_data.sql`

### 5. Verify Setup

```bash
npm run dev
```

Open your app and check the console for any Supabase errors.

---

## 📚 Documentation

### Detailed Guides
- **[Setup Instructions](./docs/supabase-setup.md)** - Complete setup walkthrough
- **[API Documentation](./docs/api-documentation.md)** - API reference and examples
- **[Database ERD](./docs/database-erd.md)** - Database structure diagram

---

## 🎨 Usage Examples

### Fetching Data
```typescript
import { useProgramCategories } from '@/hooks/api-hooks';

function MyComponent() {
  const { data, isLoading, error } = useProgramCategories();
  
  return (
    <div>
      {data?.map(category => (
        <div key={category.id}>{category.title}</div>
      ))}
    </div>
  );
}
```

### Submitting Forms
```typescript
import { useSubmitContactForm } from '@/hooks/api-hooks';
import { toast } from 'sonner';

function ContactForm() {
  const mutation = useSubmitContactForm();
  
  const handleSubmit = (formData) => {
    mutation.mutate(formData, {
      onSuccess: () => toast.success('Sent successfully!'),
      onError: (error) => toast.error(error.message),
    });
  };
  
  return <form onSubmit={handleSubmit}>{/* ... */}</form>;
}
```

---

## 🔑 Available Hooks

### Data Fetching
- `useProgramCategories()` - Get all program categories
- `usePrograms(categoryId?)` - Get programs (optionally filtered)
- `useProgram(slug)` - Get single program by slug
- `useFeaturedPrograms()` - Get featured programs
- `useTrustees()` - Get all trustees
- `useFinancialReports()` - Get financial reports
- `useLatestFinancialReport()` - Get latest report
- `useTestimonials()` - Get testimonials
- `useBlogPosts()` - Get blog posts
- `useBlogPost(slug)` - Get single blog post
- `useSiteSettings()` - Get site configuration

### Form Submissions
- `useSubmitContactForm()` - Submit contact inquiry
- `useSubmitVolunteerApplication()` - Submit volunteer form
- `useSubscribeNewsletter()` - Subscribe to newsletter
- `useUnsubscribeNewsletter()` - Unsubscribe from newsletter
- `useCreateDonation()` - Create donation record

### Analytics
- `useDonationStats(startDate, endDate)` - Get donation statistics
- `useProgramImpact()` - Get program impact data
- `useSearchPrograms(searchTerm)` - Search programs

---

## 🔐 Security Notes

### ⚠️ Important: Your Supabase Password
- Current password: `Dheeraj576@dj`
- **Action Required**: Change this after initial setup
- Enable Two-Factor Authentication

### 🔒 API Keys
- **Anon Key**: Safe to use in frontend (read-only public data)
- **Service Role Key**: NEVER use in frontend code

### 🛡️ Row Level Security
All tables have RLS enabled:
- ✅ Public can read published content
- ✅ Public can submit forms
- ❌ Only authenticated users can modify data

---

## 📊 Database Features

### Automated Triggers
- **Receipt Generation**: Auto-generates receipt numbers for donations
- **Statistics Updates**: Updates program stats when donations are made
- **Spam Detection**: Automatically flags suspicious contact forms
- **Timestamp Updates**: Auto-updates `updated_at` on all changes

### Custom Functions
- `get_donation_stats()` - Calculate donation metrics
- `get_program_impact()` - Calculate program impact
- `search_programs()` - Full-text search for programs
- `increment_blog_view_count()` - Track blog post views

---

## 🌐 Storage Buckets (To Create)

Create these buckets in Supabase Dashboard → Storage:

1. **program-images** (Public, image/*, 5MB max)
2. **trustee-photos** (Public, image/*, 2MB max)
3. **financial-reports** (Public, PDF, 10MB max)
4. **blog-images** (Public, image/*, 3MB max)
5. **testimonial-photos** (Public, image/*, 2MB max)

---

## 🎯 Next Steps

### Immediate
1. ✅ Dependencies installed
2. ⏳ Create Supabase project
3. ⏳ Run database migrations
4. ⏳ Configure environment variables
5. ⏳ Create storage buckets

### Next Phase
1. 📧 **Email Integration** - Setup contact form notifications
2. 💳 **Payment Gateway** - Integrate Razorpay for donations
3. 👤 **Admin Panel** - Create admin dashboard
4. 📈 **Analytics** - Setup Google Analytics

---

## 🐛 Troubleshooting

### "Cannot find module '@supabase/supabase-js'"
```bash
npm install
```

### "Missing Supabase environment variables"
Create `.env.local` with your Supabase credentials.

### "relation does not exist"
Run the migration files in SQL Editor.

### "JWT expired" or "unauthorized"
Check your API keys and RLS policies.

---

## 📖 API Examples

### Get all active programs
```http
GET /programs?is_public=eq.true&select=*,category(*)
```

### Submit contact form
```http
POST /contact_inquiries
Content-Type: application/json

{
  "full_name": "John Doe",
  "email": "john@example.com",
  "message": "Hello!"
}
```

### Subscribe to newsletter
```http
POST /newsletter_subscribers
Content-Type: application/json

{
  "email": "subscriber@example.com"
}
```

---

## 💡 Tips

1. **Use React Query devtools** to debug API calls
2. **Check Supabase logs** for database errors
3. **Test RLS policies** before production
4. **Backup database** regularly
5. **Monitor API usage** in Supabase dashboard

---

## 📞 Support

- **Supabase Docs**: https://supabase.com/docs
- **React Query Docs**: https://tanstack.com/query/latest
- **Project Issues**: [Your GitHub Issues URL]

---

## 📝 Summary

You now have a **production-ready backend** with:

✅ Complete database schema (11 tables)  
✅ Row Level Security enabled  
✅ TypeScript types and React hooks  
✅ Automated features (receipts, stats, spam detection)  
✅ Comprehensive documentation  
✅ Ready for frontend integration  

**Just need to**: Create Supabase project → Run migrations → Configure `.env.local` → Start building! 🚀

---

**Created**: December 3, 2025  
**Version**: 1.0  
**Database Schema**: PostgreSQL via Supabase  
**Backend Type**: Backend-as-a-Service (BaaS)
