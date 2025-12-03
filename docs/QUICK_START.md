# Quick Start: Setup Your Backend

## Copy this content to `.env.local` file

```env
# ============================================
# Supabase Configuration
# ============================================
VITE_SUPABASE_URL=https://rohswjpjcgddrhkkdhnz.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJvaHN3anBqY2dkZHJoa2tkaG56Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ3NDE3NTMsImV4cCI6MjA4MDMxNzc1M30.bOpRl3kJlEQwrVxQkJ2kiZEy9_5ZI1p7hzfcSl7gLXg

# ============================================
# Site Configuration
# ============================================
VITE_SITE_URL=http://localhost:5173
VITE_CONTACT_EMAIL=widgetwalker000@gmail.com

# ============================================
# Feature Flags
# ============================================
VITE_ENABLE_DONATIONS=false
VITE_ENABLE_BLOG=false
VITE_ENABLE_NEWSLETTER=true
```

---

## Run Database Migrations

### Your Supabase Project:
- **URL**: https://rohswjpjcgddrhkkdhnz.supabase.co
- **Email**: widgetwalker000@gmail.com
- **Password**: Dheeraj576@dj

### Steps:

1. **Go to SQL Editor**:
   https://supabase.com/dashboard/project/rohswjpjcgddrhkkdhnz/sql/new

2. **Run these files in order** (copy entire file, paste, click Run):
   
   #### File 1: `01_schema.sql`
   - Creates 11 tables
   - Creates 8 ENUM types
   - Creates indexes
   - Sets up triggers
   
   #### File 2: `02_rls_policies.sql`
   - Enables Row Level Security
   - Sets up public/private access
   - Creates helper functions
   
   #### File 3: `03_functions.sql`
   - Receipt generation
   - Spam detection
   - Statistics functions
   - Search functions
   
   #### File 4: `04_seed_data.sql`
   - 4 Program Categories
   - 3 Trustees
   - 20+ Site Settings
   - 2 Sample Programs

3. **Verify**:
   ```sql
   -- Run this in SQL Editor to check
   SELECT table_name FROM information_schema.tables 
   WHERE table_schema = 'public' ORDER BY table_name;
   ```
   
   You should see 11 tables.

---

## Quick Commands

### Create .env.local MANUALLY:
1. Create a new file: `.env.local` in project root
2. Copy the configuration from top of this doc
3. Save the file

### OR Run PowerShell Script:
```powershell
.\setup-backend.ps1
```

This will:
- Create `.env.local` automatically
- Open Supabase SQL Editor
- Show you step-by-step instructions

---

## After Setup

Start your dev server:
```bash
npm run dev
```

Your backend will be connected and ready! 🚀

---

## Migration Files Location

All SQL files are in: `supabase/migrations/`

1. [01_schema.sql](../supabase/migrations/01_schema.sql) - 426 lines
2. [02_rls_policies.sql](../supabase/migrations/02_rls_policies.sql) - ~200 lines
3. [03_functions.sql](../supabase/migrations/03_functions.sql) - ~450 lines
4. [04_seed_data.sql](../supabase/migrations/04_seed_data.sql) - ~200 lines

**Total**: ~1,300 lines of SQL

---

## Troubleshooting

### If migrations fail:
1. Make sure you're logged into the correct project
2. Run files one at a time
3. Check for error messages in SQL Editor
4. Clear previous failed migrations if retrying

### If .env.local not working:
1. Make sure file is named exactly `.env.local` (with the dot at start)
2. Restart your dev server after creating it
3. Check file is in project root (same folder as package.json)

---

## Need Help?

See full documentation:
- [Setup Guide](./supabase-setup.md)
- [Backend README](../BACKEND_README.md)
- [API Documentation](./api-documentation.md)
