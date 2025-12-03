/**
 * React Query Hooks for API Operations
 */

import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { supabase, handleSupabaseError } from '@/lib/supabase';
import type {
    ContactFormInput,
    VolunteerFormInput,
    NewsletterFormInput,
    DonationFormInput,
    Program,
    ProgramCategory,
    Trustee,
    FinancialReport,
    Testimonial,
    BlogPost,
    SiteSetting,
    DonationStats,
    ProgramImpact,
} from '@/lib/types';

// ============================================
// PROGRAM CATEGORIES
// ============================================

export function useProgramCategories() {
    return useQuery({
        queryKey: ['programCategories'],
        queryFn: async () => {
            const { data, error } = await supabase
                .from('program_categories')
                .select('*')
                .eq('is_active', true)
                .order('display_order');

            if (error) throw new Error(handleSupabaseError(error));
            return data as ProgramCategory[];
        },
    });
}

// ============================================
// PROGRAMS
// ============================================

export function usePrograms(categoryId?: string) {
    return useQuery({
        queryKey: ['programs', categoryId],
        queryFn: async () => {
            let query = supabase
                .from('programs')
                .select(`
          *,
          category:program_categories(*)
        `)
                .eq('is_public', true)
                .order('display_order');

            if (categoryId) {
                query = query.eq('category_id', categoryId);
            }

            const { data, error } = await query;

            if (error) throw new Error(handleSupabaseError(error));
            return data as Program[];
        },
    });
}

export function useProgram(slug: string) {
    return useQuery({
        queryKey: ['program', slug],
        queryFn: async () => {
            const { data, error } = await supabase
                .from('programs')
                .select(`
          *,
          category:program_categories(*)
        `)
                .eq('slug', slug)
                .eq('is_public', true)
                .single();

            if (error) throw new Error(handleSupabaseError(error));
            return data as Program;
        },
        enabled: !!slug,
    });
}

export function useFeaturedPrograms() {
    return useQuery({
        queryKey: ['featuredPrograms'],
        queryFn: async () => {
            const { data, error } = await supabase
                .from('programs')
                .select(`
          *,
          category:program_categories(*)
        `)
                .eq('is_featured', true)
                .eq('is_public', true)
                .order('display_order')
                .limit(3);

            if (error) throw new Error(handleSupabaseError(error));
            return data as Program[];
        },
    });
}

// ============================================
// TRUSTEES
// ============================================

export function useTrustees() {
    return useQuery({
        queryKey: ['trustees'],
        queryFn: async () => {
            const { data, error } = await supabase
                .from('trustees')
                .select('*')
                .eq('is_public', true)
                .eq('is_active', true)
                .order('display_order');

            if (error) throw new Error(handleSupabaseError(error));
            return data as Trustee[];
        },
    });
}

// ============================================
// FINANCIAL REPORTS
// ============================================

export function useFinancialReports() {
    return useQuery({
        queryKey: ['financialReports'],
        queryFn: async () => {
            const { data, error } = await supabase
                .from('financial_reports')
                .select('*')
                .eq('is_published', true)
                .order('fiscal_year', { ascending: false });

            if (error) throw new Error(handleSupabaseError(error));
            return data as FinancialReport[];
        },
    });
}

export function useLatestFinancialReport() {
    return useQuery({
        queryKey: ['latestFinancialReport'],
        queryFn: async () => {
            const { data, error } = await supabase
                .from('financial_reports')
                .select('*')
                .eq('is_published', true)
                .order('fiscal_year', { ascending: false })
                .limit(1)
                .single();

            if (error) {
                // If no data, return null instead of throwing
                if (error.code === 'PGRST116') return null;
                throw new Error(handleSupabaseError(error));
            }
            return data as FinancialReport;
        },
    });
}

// ============================================
// TESTIMONIALS
// ============================================

export function useTestimonials() {
    return useQuery({
        queryKey: ['testimonials'],
        queryFn: async () => {
            const { data, error } = await supabase
                .from('testimonials')
                .select(`
          *,
          program:programs(*),
          category:program_categories(*)
        `)
                .eq('is_approved', true)
                .eq('is_public', true)
                .order('display_order');

            if (error) throw new Error(handleSupabaseError(error));
            return data as Testimonial[];
        },
    });
}

// ============================================
// BLOG POSTS
// ============================================

export function useBlogPosts() {
    return useQuery({
        queryKey: ['blogPosts'],
        queryFn: async () => {
            const { data, error } = await supabase
                .from('blog_posts')
                .select(`
          *,
          author:trustees(*),
          category:program_categories(*)
        `)
                .eq('is_published', true)
                .lte('published_date', new Date().toISOString())
                .order('published_date', { ascending: false });

            if (error) throw new Error(handleSupabaseError(error));
            return data as BlogPost[];
        },
    });
}

export function useBlogPost(slug: string) {
    return useQuery({
        queryKey: ['blogPost', slug],
        queryFn: async () => {
            const { data, error } = await supabase
                .from('blog_posts')
                .select(`
          *,
          author:trustees(*),
          category:program_categories(*)
        `)
                .eq('slug', slug)
                .eq('is_published', true)
                .single();

            if (error) throw new Error(handleSupabaseError(error));

            // Increment view count
            await supabase.rpc('increment_blog_view_count', { post_id: data.id });

            return data as BlogPost;
        },
        enabled: !!slug,
    });
}

// ============================================
// SITE SETTINGS
// ============================================

export function useSiteSettings() {
    return useQuery({
        queryKey: ['siteSettings'],
        queryFn: async () => {
            const { data, error } = await supabase
                .from('site_settings')
                .select('*')
                .eq('is_public', true);

            if (error) throw new Error(handleSupabaseError(error));

            // Convert array to key-value object for easier access
            const settings: Record<string, string> = {};
            data.forEach((setting: SiteSetting) => {
                settings[setting.setting_key] = setting.setting_value || '';
            });

            return settings;
        },
    });
}

// ============================================
// CONTACT FORM SUBMISSION
// ============================================

export function useSubmitContactForm() {
    const queryClient = useQueryClient();

    return useMutation({
        mutationFn: async (formData: ContactFormInput) => {
            const { data, error } = await supabase
                .from('contact_inquiries')
                .insert([formData])
                .select()
                .single();

            if (error) throw new Error(handleSupabaseError(error));
            return data;
        },
        onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ['contactInquiries'] });
        },
    });
}

// ============================================
// VOLUNTEER APPLICATION
// ============================================

export function useSubmitVolunteerApplication() {
    const queryClient = useQueryClient();

    return useMutation({
        mutationFn: async (formData: VolunteerFormInput) => {
            const { data, error } = await supabase
                .from('volunteers')
                .insert([formData])
                .select()
                .single();

            if (error) throw new Error(handleSupabaseError(error));
            return data;
        },
        onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ['volunteers'] });
        },
    });
}

// ============================================
// NEWSLETTER SUBSCRIPTION
// ============================================

export function useSubscribeNewsletter() {
    const queryClient = useQueryClient();

    return useMutation({
        mutationFn: async (formData: NewsletterFormInput) => {
            const { data, error } = await supabase
                .from('newsletter_subscribers')
                .insert([formData])
                .select()
                .single();

            if (error) {
                // Handle duplicate email gracefully
                if (error.code === '23505') {
                    throw new Error('This email is already subscribed to our newsletter.');
                }
                throw new Error(handleSupabaseError(error));
            }
            return data;
        },
        onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ['newsletterSubscribers'] });
        },
    });
}

export function useUnsubscribeNewsletter() {
    const queryClient = useQueryClient();

    return useMutation({
        mutationFn: async (email: string) => {
            const { data, error } = await supabase
                .from('newsletter_subscribers')
                .update({ is_subscribed: false, unsubscription_date: new Date().toISOString() })
                .eq('email', email)
                .select()
                .single();

            if (error) throw new Error(handleSupabaseError(error));
            return data;
        },
        onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ['newsletterSubscribers'] });
        },
    });
}

// ============================================
// DONATION (Future - requires payment gateway integration)
// ============================================

export function useCreateDonation() {
    const queryClient = useQueryClient();

    return useMutation({
        mutationFn: async (formData: DonationFormInput) => {
            // Note: This should be called AFTER successful payment
            const { data, error } = await supabase
                .from('donations')
                .insert([formData])
                .select()
                .single();

            if (error) throw new Error(handleSupabaseError(error));
            return data;
        },
        onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ['donations'] });
        },
    });
}

// ============================================
// STATISTICS
// ============================================

export function useDonationStats(startDate?: string, endDate?: string) {
    return useQuery({
        queryKey: ['donationStats', startDate, endDate],
        queryFn: async () => {
            const { data, error } = await supabase
                .rpc('get_donation_stats', {
                    start_date: startDate || null,
                    end_date: endDate || null,
                });

            if (error) throw new Error(handleSupabaseError(error));
            return data as DonationStats;
        },
    });
}

export function useProgramImpact() {
    return useQuery({
        queryKey: ['programImpact'],
        queryFn: async () => {
            const { data, error } = await supabase.rpc('get_program_impact');

            if (error) throw new Error(handleSupabaseError(error));
            return data as ProgramImpact;
        },
    });
}

// ============================================
// SEARCH
// ============================================

export function useSearchPrograms(searchTerm: string) {
    return useQuery({
        queryKey: ['searchPrograms', searchTerm],
        queryFn: async () => {
            const { data, error } = await supabase
                .rpc('search_programs', { search_term: searchTerm });

            if (error) throw new Error(handleSupabaseError(error));
            return data;
        },
        enabled: searchTerm.length > 2, // Only search if term is longer than 2 characters
    });
}
