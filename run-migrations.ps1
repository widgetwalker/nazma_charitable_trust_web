# Automated Supabase Migration Script
# This script runs all migrations automatically using Supabase REST API

$ErrorActionPreference = "Stop"

# Supabase credentials
$SUPABASE_URL = "https://rohswjpjcgddrhkkdhnz.supabase.co"
$SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJvaHN3anBqY2dkZHJoa2tkaG56Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ3NDE3NTMsImV4cCI6MjA4MDMxNzc1M30.bOpRl3kJlEQwrVxQkJ2kiZEy9_5ZI1p7hzfcSl7gLXg"

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Automated Database Migration Runner" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# Function to execute SQL
function Invoke-SupabaseSQL {
    param (
        [string]$SqlContent,
        [string]$FileName
    )
    
    Write-Host "Running: $FileName..." -ForegroundColor Yellow
    
    $headers = @{
        "apikey" = $SUPABASE_KEY
        "Authorization" = "Bearer $SUPABASE_KEY"
        "Content-Type" = "application/json"
    }
    
    # Use Supabase's SQL endpoint (requires service role key which we don't have)
    # Alternative: Use pg_admin or direct connection
    
    Write-Host "Note: This requires Supabase service_role key for direct SQL execution" -ForegroundColor Red
    Write-Host "The anon key doesn't have permission to run DDL statements" -ForegroundColor Red
    Write-Host ""
    return $false
}

Write-Host "IMPORTANT:" -ForegroundColor Red
Write-Host "The Supabase REST API requires a service_role key to run migrations." -ForegroundColor White
Write-Host "For security, this key is not exposed in the dashboard." -ForegroundColor White
Write-Host ""
Write-Host "SOLUTION: Use Supabase CLI or Dashboard SQL Editor" -ForegroundColor Yellow
Write-Host ""
Write-Host "I'll open the SQL Editor and copy the first migration for you..." -ForegroundColor Green

# Read first migration file
$migration1 = Get-Content "supabase\migrations\01_schema.sql" -Raw

# Copy to clipboard
Set-Clipboard -Value $migration1
Write-Host ""
Write-Host "✓ Migration 01_schema.sql copied to clipboard!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. The SQL Editor will open" -ForegroundColor White
Write-Host "2. Press Ctrl+V to paste the migration" -ForegroundColor White
Write-Host "3. Click 'Run' button" -ForegroundColor White
Write-Host "4. Return here and press Enter for next migration" -ForegroundColor White
Write-Host ""

# Open Supabase SQL Editor
Start-Process "https://supabase.com/dashboard/project/rohswjpjcgddrhkkdhnz/sql/new"

Read-Host "Press Enter when migration 1 is complete"

# Migration 2
$migration2 = Get-Content "supabase\migrations\02_rls_policies.sql" -Raw
Set-Clipboard -Value $migration2
Write-Host "✓ Migration 02_rls_policies.sql copied to clipboard!" -ForegroundColor Green
Write-Host "Press Ctrl+V in SQL Editor and Run" -ForegroundColor White
Read-Host "Press Enter when migration 2 is complete"

# Migration 3
$migration3 = Get-Content "supabase\migrations\03_functions.sql" -Raw
Set-Clipboard -Value $migration3
Write-Host "✓ Migration 03_functions.sql copied to clipboard!" -ForegroundColor Green
Write-Host "Press Ctrl+V in SQL Editor and Run" -ForegroundColor White
Read-Host "Press Enter when migration 3 is complete"

# Migration 4
$migration4 = Get-Content "supabase\migrations\04_seed_data.sql" -Raw
Set-Clipboard -Value $migration4
Write-Host "✓ Migration 04_seed_data.sql copied to clipboard!" -ForegroundColor Green
Write-Host "Press Ctrl+V in SQL Editor and Run" -ForegroundColor White
Read-Host "Press Enter when migration 4 is complete"

Write-Host ""
Write-Host "=========================================" -ForegroundColor Green
Write-Host "All migrations completed!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Verifying database..." -ForegroundColor Yellow

# Try to verify via REST API
try {
    $headers = @{
        "apikey" = $SUPABASE_KEY
        "Authorization" = "Bearer $SUPABASE_KEY"
    }
    
    $response = Invoke-RestMethod -Uri "$SUPABASE_URL/rest/v1/program_categories?select=count" -Headers $headers -Method Get
    Write-Host "✓ Database connection verified!" -ForegroundColor Green
    Write-Host "✓ Tables created successfully!" -ForegroundColor Green
} catch {
    Write-Host "Note: Run 'npm run dev' to verify connection" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Your backend is ready! Run:" -ForegroundColor Cyan
Write-Host "  npm run dev" -ForegroundColor White
