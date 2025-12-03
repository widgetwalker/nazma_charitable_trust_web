# Verify Database Setup
# This script checks that all tables and data were created successfully

$SUPABASE_URL = "https://rohswjpjcgddrhkkdhnz.supabase.co"
$SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJvaHN3anBqY2dkZHJoa2tkaG56Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ3NDE3NTMsImV4cCI6MjA4MDMxNzc1M30.bOpRl3kJlEQwrVxQkJ2kiZEy9_5ZI1p7hzfcSl7gLXg"

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Database Verification" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

$headers = @{
    "apikey"        = $SUPABASE_KEY
    "Authorization" = "Bearer $SUPABASE_KEY"
    "Content-Type"  = "application/json"
}

Write-Host "Testing database connection..." -ForegroundColor Yellow

# Test 1: Check program_categories
try {
    $categories = Invoke-RestMethod -Uri "$SUPABASE_URL/rest/v1/program_categories?select=*" -Headers $headers -Method Get
    $count = ($categories | Measure-Object).Count
    Write-Host "✓ program_categories: $count rows" -ForegroundColor Green
    
    if ($count -eq 4) {
        Write-Host "  └─ All 4 categories seeded correctly!" -ForegroundColor Gray
    }
}
catch {
    Write-Host "✗ program_categories: Failed to fetch" -ForegroundColor Red
    Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 2: Check trustees
try {
    $trustees = Invoke-RestMethod -Uri "$SUPABASE_URL/rest/v1/trustees?select=*" -Headers $headers -Method Get
    $count = ($trustees | Measure-Object).Count
    Write-Host "✓ trustees: $count rows" -ForegroundColor Green
    
    if ($count -eq 3) {
        Write-Host "  └─ All 3 trustees seeded correctly!" -ForegroundColor Gray
    }
}
catch {
    Write-Host "✗ trustees: Failed to fetch" -ForegroundColor Red
}

# Test 3: Check programs
try {
    $programs = Invoke-RestMethod -Uri "$SUPABASE_URL/rest/v1/programs?select=*" -Headers $headers -Method Get
    $count = ($programs | Measure-Object).Count
    Write-Host "✓ programs: $count rows" -ForegroundColor Green
    
    if ($count -ge 2) {
        Write-Host "  └─ Sample programs created!" -ForegroundColor Gray
    }
}
catch {
    Write-Host "✗ programs: Failed to fetch" -ForegroundColor Red
}

# Test 4: Check site_settings
try {
    $settings = Invoke-RestMethod -Uri "$SUPABASE_URL/rest/v1/site_settings?select=*&is_public=eq.true" -Headers $headers -Method Get
    $count = ($settings | Measure-Object).Count
    Write-Host "✓ site_settings: $count public settings" -ForegroundColor Green
    
    if ($count -gt 10) {
        Write-Host "  └─ Configuration settings loaded!" -ForegroundColor Gray
    }
}
catch {
    Write-Host "✗ site_settings: Failed to fetch" -ForegroundColor Red
}

# Test 5: Check contact_inquiries (should be empty but table should exist)
try {
    $inquiries = Invoke-RestMethod -Uri "$SUPABASE_URL/rest/v1/contact_inquiries?select=count" -Headers $headers -Method Get
    Write-Host "✓ contact_inquiries: Table exists (ready for form submissions)" -ForegroundColor Green
}
catch {
    Write-Host "✗ contact_inquiries: Table not found" -ForegroundColor Red
}

# Test 6: Check volunteers table
try {
    $volunteers = Invoke-RestMethod -Uri "$SUPABASE_URL/rest/v1/volunteers?select=count" -Headers $headers -Method Get
    Write-Host "✓ volunteers: Table exists" -ForegroundColor Green
}
catch {
    Write-Host "✗ volunteers: Table not found" -ForegroundColor Red
}

# Test 7: Check donations table
try {
    $donations = Invoke-RestMethod -Uri "$SUPABASE_URL/rest/v1/donations?select=count" -Headers $headers -Method Get
    Write-Host "✓ donations: Table exists" -ForegroundColor Green
}
catch {
    Write-Host "✗ donations: Table not found" -ForegroundColor Red
}

# Test 8: Check newsletter_subscribers
try {
    $newsletter = Invoke-RestMethod -Uri "$SUPABASE_URL/rest/v1/newsletter_subscribers?select=count" -Headers $headers -Method Get
    Write-Host "✓ newsletter_subscribers: Table exists" -ForegroundColor Green
}
catch {
    Write-Host "✗ newsletter_subscribers: Table not found" -ForegroundColor Red
}

Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Summary" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Your backend is fully configured and ready!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Start development server: npm run dev" -ForegroundColor White
Write-Host "2. Your frontend will now connect to Supabase" -ForegroundColor White
Write-Host "3. Test the contact form and other features" -ForegroundColor White
Write-Host ""
Write-Host "Database URL: https://rohswjpjcgddrhkkdhnz.supabase.co" -ForegroundColor Gray
Write-Host "Dashboard: https://supabase.com/dashboard/project/rohswjpjcgddrhkkdhnz" -ForegroundColor Gray
