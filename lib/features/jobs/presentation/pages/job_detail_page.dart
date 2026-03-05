import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';

import '../providers/job_provider.dart';

/// Job detail page
class JobDetailPage extends ConsumerWidget {
  final String id;

  const JobDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final jobAsync = ref.watch(jobByIdProvider(id));

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: jobAsync.when(
        data: (job) {
          if (job == null) {
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
                  const Text('Job not found'),
                  const SizedBox(height: AppSpacing.md),
                  GradientButton(
                    text: 'Back to Jobs',
                    onPressed: () => context.go('/jobs'),
                  ),
                ],
              ),
            );
          }
          final isActive = job.isActive ?? true;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.go('/jobs'),
                      icon: const Icon(Iconsax.arrow_left),
                      tooltip: 'Back',
                    ),
                    const Spacer(),
                    OutlinedButton.icon(
                      onPressed: () => context.go('/jobs/$id/edit'),
                      icon: const Icon(Iconsax.edit, size: 18),
                      label: const Text('Edit'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    OutlinedButton.icon(
                      onPressed: () => _showDeleteDialog(context, ref),
                      icon:
                          Icon(Iconsax.trash, size: 18, color: AppColors.error),
                      label: Text('Delete',
                          style: TextStyle(color: AppColors.error)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                // Job info section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main content
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status and type badges
                          // Row(
                          //   children: [
                          //     _buildStatusBadge(isActive),
                          //     const SizedBox(width: AppSpacing.sm),
                          //     _buildTypeBadge(job.type ?? 'Full Time', isDark),
                          //   ],
                          // ),
                          const SizedBox(height: AppSpacing.md),

                          // Title
                          // Text(
                          //   job.title ?? 'Untitled Job',
                          //   style: Theme.of(context).textTheme.displaySmall,
                          // ),
                          const SizedBox(height: AppSpacing.sm),

                          // Location
                          // if (job.location != null)
                          //   Row(
                          //     children: [
                          //       Icon(
                          //         Iconsax.location,
                          //         size: 18,
                          //         color: isDark
                          //             ? AppColors.darkTextSecondary
                          //             : AppColors.lightTextSecondary,
                          //       ),
                          //       const SizedBox(width: AppSpacing.xs),
                          //       // Text(
                          //       //   job.location!,
                          //       //   style: TextStyle(
                          //       //     color: isDark
                          //       //         ? AppColors.darkTextSecondary
                          //       //         : AppColors.lightTextSecondary,
                          //       //   ),
                          //       // ),
                          //     ],
                          //   ),
                          const SizedBox(height: AppSpacing.xl),

                          // Description
                          Text(
                            'Job Description',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            job.description ?? '--',
                            style: TextStyle(
                              height: 1.7,
                              color: isDark
                                  ? AppColors.darkText
                                  : AppColors.lightText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xl),

                    // Sidebar
                    Expanded(
                      child: Column(
                        children: [
                          // Job details card
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkCard
                                  : AppColors.lightCard,
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusLg),
                              border: Border.all(
                                color: isDark
                                    ? AppColors.darkBorder
                                    : AppColors.lightBorder,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Job Details',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: AppSpacing.lg),
                                // _buildDetailRow(
                                //   context,
                                //   Iconsax.briefcase,
                                //   'Job Type',
                                //   job.type ?? 'Full Time',
                                //   isDark,
                                // ),
                                // if (job.salary != null) ...[
                                //   const SizedBox(height: AppSpacing.md),
                                //   _buildDetailRow(
                                //     context,
                                //     Iconsax.money,
                                //     'Salary',
                                //     job.salary!,
                                //     isDark,
                                //   ),
                                // ],
                                const SizedBox(height: AppSpacing.md),
                                _buildDetailRow(
                                  context,
                                  Iconsax.status,
                                  'Status',
                                  isActive ? 'Active' : 'Inactive',
                                  isDark,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildStatusBadge(bool isActive) {
    final color = isActive ? AppColors.success : AppColors.error;
    final label = isActive ? 'ACTIVE' : 'INACTIVE';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildTypeBadge(String typeLabel, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightDivider,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        typeLabel,
        style: TextStyle(
          fontSize: 12,
          color: isDark
              ? AppColors.darkTextSecondary
              : AppColors.lightTextSecondary,
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    bool isDark,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.primaryLight.withValues(alpha: 0.1)
                : AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Icon(
            icon,
            size: 18,
            color: isDark ? AppColors.primaryLight : AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Job'),
        content:
            const Text('Are you sure you want to delete this job posting?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(jobsNotifierProvider.notifier).deleteJob(id);
              if (context.mounted) {
                Navigator.pop(dialogContext);
                context.go('/jobs');
              }
            },
            child: Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
