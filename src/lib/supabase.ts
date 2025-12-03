/**
 * Supabase Client Configuration
 */

import { createClient } from '@supabase/supabase-js';

// Get environment variables
const supabaseUrl = import.meta.env?.VITE_SUPABASE_URL || '';
const supabaseAnonKey = import.meta.env?.VITE_SUPABASE_ANON_KEY || '';

if (!supabaseUrl || !supabaseAnonKey) {
    throw new Error('Missing Supabase environment variables. Please check your .env.local file.');
}

// Create Supabase client
export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
    auth: {
        persistSession: true,
        autoRefreshToken: true,
    },
    db: {
        schema: 'public',
    },
    global: {
        headers: {
            'x-application-name': 'nazma-trust-web',
        },
    },
});

// Helper function to handle Supabase errors
export function handleSupabaseError(error: any): string {
    if (error?.message) {
        // Check for common error patterns
        if (error.message.includes('violates')) {
            return 'This information is already in our system.';
        }
        if (error.message.includes('foreign key')) {
            return 'Invalid reference. Please try again.';
        }
        if (error.message.includes('permission')) {
            return 'You don\'t have permission to perform this action.';
        }
        return error.message;
    }
    return 'An unexpected error occurred. Please try again.';
}

// Export for use in React Query
export default supabase;
