import 'package:dts_admin_portal/features/jobs/domain/entities/job.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/responsive_layout.dart';
import '../../../products/presentation/providers/product_provider.dart';
import '../../../portfolio/presentation/providers/portfolio_provider.dart';
import '../../../jobs/presentation/providers/job_provider.dart';

/// Dashboard page with stats and overview
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SingleChildScrollView(
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
                        'Dashboard',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Welcome back! Here\'s an overview of your admin portal.',
                        style: TextStyle(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Stats cards
            ResponsiveLayout(
              mobile: Column(
                children: [
                  _buildStatsRow(context, ref, isDark, 2),
                ],
              ),
              desktop: _buildStatsRow(context, ref, isDark, 4),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Quick actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: _buildQuickActionCard(
                    context,
                    icon: Iconsax.add_circle,
                    title: 'Add Product',
                    color: AppColors.primary,
                    onTap: () {},
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _buildQuickActionCard(
                    context,
                    icon: Iconsax.gallery_add,
                    title: 'New Portfolio',
                    color: AppColors.secondary,
                    onTap: () {},
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _buildQuickActionCard(
                    context,
                    icon: Iconsax.briefcase,
                    title: 'Post Job',
                    color: const Color(0xFF6366F1),
                    onTap: () {},
                    isDark: isDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Recent activity section
            if (!ResponsiveLayout.isMobile(context))
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recent products
                  Expanded(
                    child: _buildRecentSection(
                      context,
                      ref,
                      'Recent Products',
                      Iconsax.box,
                      isDark,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  // Active jobs
                  Expanded(
                    child: _buildJobsSection(context, ref, isDark),
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recent products
                  _buildRecentSection(
                    context,
                    ref,
                    'Recent Products',
                    Iconsax.box,
                    isDark,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  // Active jobs
                  _buildJobsSection(context, ref, isDark),
                ],
              )
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(
    BuildContext context,
    WidgetRef ref,
    bool isDark,
    int crossAxisCount,
  ) {
    final products = ref.watch(productsNotifierProvider);
    final portfolios = ref.watch(portfoliosNotifierProvider);
    final jobs = ref.watch(jobsNotifierProvider);

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: AppSpacing.md,
      crossAxisSpacing: AppSpacing.md,
      childAspectRatio: ResponsiveLayout.isMobile(context) ? 1.1 : 1.5,
      children: [
        _buildStatCard(
          context,
          title: 'Total Products',
          value: products.maybeWhen(
            data: (data) => data.length.toString(),
            orElse: () => '-',
          ),
          icon: Iconsax.box5 ,
          color: AppColors.primary,
          isDark: isDark,
        ),
        _buildStatCard(
          context,
          title: 'Portfolio Items',
          value: portfolios.maybeWhen(
            data: (data) => data.data.length.toString(),
            orElse: () => '-',
          ),
          icon: Iconsax.gallery5,
          color: AppColors.secondary,
          isDark: isDark,
        ),
        _buildStatCard(
          context,
          title: 'Active Jobs',
          value: jobs.maybeWhen(
            data: (data) =>
                data.data.where((j) => j.isActive ?? false).length.toString(),
            orElse: () => '-',
          ),
          icon: Iconsax.briefcase5,
          color: const Color(0xFF6366F1),
          isDark: isDark,
        ),
        _buildStatCard(
          context,
          title: 'Total Jobs',
          value: jobs.maybeWhen(
            data: (data) => data.data.length.toString(),
            orElse: () => '-',
          ),
          icon: Iconsax.people5,
          color: const Color(0xFFF59E0B),
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Center(child: Icon(icon, color: color, size: 24)),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          height: 160,
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withValues(alpha: 0.7)],
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(height: AppSpacing.md),
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentSection(
    BuildContext context,
    WidgetRef ref,
    String title,
    IconData icon,
    bool isDark,
  ) {
    final products = ref.watch(productsNotifierProvider);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: AppColors.primary),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          products.when(
            data: (data) {
              final recent = data.take(5).toList();
              return Column(
                children: recent.map((product) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusSm),
                          ),
                          child: Center(
                            child: Text(
                              product.name.substring(0, 1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Text('Error loading products'),
          ),
        ],
      ),
    );
  }

  Widget _buildJobsSection(BuildContext context, WidgetRef ref, bool isDark) {
    final jobs = ref.watch(jobsNotifierProvider);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.briefcase, size: 20, color: const Color(0xFF6366F1)),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Active Jobs',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          jobs.when(
            data: (data) {
              final activeJobs =
                  data.data.where((j) => j.isActive ?? false).take(5).toList();
              if (activeJobs.isEmpty) {
                return Center(
                  child: Text(
                    'No active jobs',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                );
              }
              return Column(
                children: activeJobs.map((job) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                job.title ?? 'Untitled Job',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                job.location ?? 'Remote',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusSm),
                          ),
                          child: Text(
                            JobType.fromString(job.type.toString()).label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Text('Error loading jobs'),
          ),
        ],
      ),
    );
  }
}
