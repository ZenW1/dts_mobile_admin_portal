import 'package:dts_admin_portal/core/network/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../../generated_code/swagger.swagger.dart';
import '../providers/job_provider.dart';

/// Jobs list page
class JobsPage extends ConsumerStatefulWidget {
  const JobsPage({super.key});

  @override
  ConsumerState<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends ConsumerState<JobsPage> {
  final _searchController = TextEditingController();


  @override
  void initState() {
    Future.microtask(() => _refreshJobs());
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
     super.dispose();
  }

  Future<void> _refreshJobs() async {
   final kk =  await ApiServiceProvider().restApi.GetAllCareers();

   // get and print data
    final jobs = kk.body;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredJobs = ref.watch(filteredJobsProvider);
    final filter = ref.watch(jobFilterProvider);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jobs',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Manage job postings',
                        style: TextStyle(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                GradientButton(
                  text: 'Post Job',
                  icon: Iconsax.add,
                  onPressed: () => context.go('/jobs/new'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Search and filters
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _searchController,
                    hint: 'Search jobs...',
                    prefixIcon: const Icon(Iconsax.search_normal, size: 20),
                    onChanged: (value) {
                      ref.read(jobFilterProvider.notifier).state =
                          filter.copyWith(searchQuery: value);
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                // Status filter dropdown
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : AppColors.lightCard,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    border: Border.all(
                      color:
                          isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<bool?>(
                      value: filter.isActive,
                      hint: const Text('All Status'),
                      items: const [
                        DropdownMenuItem(
                            value: null, child: Text('All Status')),
                        DropdownMenuItem(value: true, child: Text('Active')),
                        DropdownMenuItem(value: false, child: Text('Inactive')),
                      ],
                      onChanged: (value) {
                        ref.read(jobFilterProvider.notifier).state =
                            JobFilterState(
                          searchQuery: filter.searchQuery,
                          isActive: value,
                          type: filter.type,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Jobs list
            Expanded(
              child: filteredJobs.when(
                data: (jobs) {
                  if (jobs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.briefcase,
                            size: 64,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'No jobs found',
                            style: TextStyle(
                              fontSize: 16,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: jobs.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final job = jobs[index];
                      return _buildJobCard(job, isDark);
                    },
                  );
                },
                loading: () => ListView.builder(
                  itemCount: 4,
                  itemBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: ShimmerLoading.card(height: 140),
                  ),
                ),
                error: (error, _) => Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(CareerResponseDTO job, bool isDark) {
    // ID is missing in CreateCareerDTO
    // final jobId = '';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Navigation disabled due to missing ID in DTO
          // context.go('/jobs/$jobId');
        },
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                job.title ?? 'Untitled Job',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                                ),
                              ),
                            ),
                            _buildStatusBadge(job.isActive ?? true, isDark),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        if (job.location != null)
                          Row(
                            children: [
                              Icon(
                                Iconsax.location,
                                size: 16,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                job.location ?? '',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  _buildInfoChip(
                      Iconsax.briefcase, job.type ?? 'Full Time', isDark),
                  if (job.salary != null) ...[
                    const SizedBox(width: AppSpacing.md),
                    _buildInfoChip(Iconsax.money, job.salary!, isDark),
                  ],
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      context.go('/jobs/${job.id ?? ''}');
                    },
                    icon: const Text('View Details'),
                    label: const Icon(Iconsax.arrow_right_3, size: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool isActive, bool isDark) {
    final color = isActive ? AppColors.success : AppColors.error;
    final label = isActive ? 'Active' : 'Inactive';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightDivider,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 14,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
