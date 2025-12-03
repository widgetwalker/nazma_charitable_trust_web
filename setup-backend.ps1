# Supabase Setup Script
# Run this in PowerShell to set up your backend

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Nazma Charitable Trust Backend Setup" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Create .env.local file
Write-Host "Step 1: Creating .env.local file..." -ForegroundColor Yellow

$envContent = @"
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

# ============================================
# Payment Gateway (Future - Razorpay)
# ============================================
# VITE_RAZORPAY_KEY_ID=your_razorpay_key_id
# RAZORPAY_KEY_SECRET=your_razorpay_secret

# ============================================
# Analytics (Optional)
# ============================================
# VITE_GA_MEASUREMENT_ID=G-XXXXXXXXXX
# VITE_FB_PIXEL_ID=your_facebook_pixel_id
"@

Set-Content -Path ".env.local" -Value $envContent
Write-Host "✓ Created .env.local with your Supabase credentials" -ForegroundColor Green
Write-Host ""

# Instructions for running migrations
Write-Host "Step 2: Run Database Migrations" -ForegroundColor Yellow
Write-Host "You need to run the SQL migration files in Supabase Dashboard:" -ForegroundColor White
Write-Host ""
Write-Host "1. Open: https://supabase.com/dashboard/project/rohswjpjcgddrhkkdhnz/sql/new" -ForegroundColor Cyan
Write-Host "2. Login with:" -ForegroundColor White
Write-Host "   Email: widgetwalker000@gmail.com" -ForegroundColor Gray
Write-Host "   Password: Dheeraj576@dj" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Run these files in order (copy the entire file content):" -ForegroundColor White
Write-Host "   a) supabase/migrations/01_schema.sql" -ForegroundColor Gray
Write-Host "   b) supabase/migrations/02_rls_policies.sql" -ForegroundColor Gray
Write-Host "   c) supabase/migrations/03_functions.sql" -ForegroundColor Gray
Write-Host "   d) supabase/migrations/04_seed_data.sql" -ForegroundColor Gray
Write-Host ""

# Create a quick migration runner script
Write-Host "Step 3: Verify Setup" -ForegroundColor Yellow
Write-Host "After running migrations, start your dev server:" -ForegroundColor White
Write-Host "   npm run dev" -ForegroundColor Cyan
Write-Host ""

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Setup Instructions Complete!" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Opening Supabase SQL Editor..." -ForegroundColor Yellow
Start-Process "https://supabase.com/dashboard/project/rohswjpjcgddrhkkdhnz/sql/new"

Write-Host ""
Write-Host "TIP: Press Ctrl+A in each .sql file to copy all content easily!" -ForegroundColor Yellow
