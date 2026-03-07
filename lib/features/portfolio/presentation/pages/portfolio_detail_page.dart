import 'package:cached_network_image/cached_network_image.dart';
import 'package:dts_admin_portal/core/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/image_placeholder.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../providers/portfolio_provider.dart';

/// Portfolio detail page
class PortfolioDetailPage extends ConsumerWidget {
  final String id;

  const PortfolioDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final portfolioAsync = ref.watch(portfolioByIdProvider(id));
    final categoriesAsync = ref.watch(portfolioCategoriesNotifierProvider);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: portfolioAsync.when(
        data: (portfolios) {
          final portfolio = portfolios?.data;
          if (portfolio == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.gallery,
                    size: 64,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Text('Portfolio item not found'),
                  const SizedBox(height: AppSpacing.md),
                  GradientButton(
                    text: 'Back to Portfolio',
                    onPressed: () => context.go('/portfolio'),
                  ),
                ],
              ),
            );
          }

          final categoryId = portfolio.category?.id;
          final categories = categoriesAsync.value;
          final category = categories != null &&
                  categoryId != null &&
                  categories.any((c) => c.id == categoryId)
              ? categories.firstWhere((c) => c.id == categoryId)
              : null;

          if (category == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.folder,
                    size: 64,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Text('Category not found'),
                  const SizedBox(height: AppSpacing.md),
                  GradientButton(
                    text: 'Back to Portfolio',
                    onPressed: () => context.go('/portfolio'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero image
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            if (portfolio.image.isNotEmpty)
                              CachedNetworkImage(
                                imageUrl: portfolio.image.first,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => ImagePlaceholder(
                                  text: portfolio.title,
                                  borderRadius: 0,
                                ),
                                errorWidget: (context, url, error) =>
                                    ImagePlaceholder(
                                  text: portfolio.title,
                                      height: 200,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                  borderRadius: 0,
                                ),
                              )
                            else
                              ImagePlaceholder(
                                text: portfolio.title,
                                borderRadius: 0,
                                height: 200,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                          ],
                        ),
                      ),
                      // Gradient overlay
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.3),
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.5),
                            ],
                            stops: const [0.0, 0.3, 1.0],
                          ),
                        ),
                      ),
                      // Back button and actions
                      Positioned(
                        top: AppSpacing.lg,
                        left: AppSpacing.lg,
                        right: AppSpacing.lg,
                        child: Row(
                          children: [
                            IconButton.filled(
                              onPressed: () => context.go('/portfolio'),
                              icon: const Icon(Iconsax.arrow_left),
                              style: IconButton.styleFrom(
                                backgroundColor:
                                    Colors.white.withValues(alpha: 0.2),
                                foregroundColor: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            IconButton.filled(
                              onPressed: () => context.go('/portfolio/$id/edit'),
                              icon: const Icon(Iconsax.edit),
                              tooltip: 'Edit',
                              style: IconButton.styleFrom(
                                backgroundColor:
                                    Colors.white.withValues(alpha: 0.2),
                                foregroundColor: Colors.white,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            IconButton.filled(
                              onPressed: () => _showDeleteDialog(context, ref),
                              icon: const Icon(Iconsax.trash),
                              tooltip: 'Delete',
                              style: IconButton.styleFrom(
                                backgroundColor:
                                    AppColors.error.withValues(alpha: 0.8),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Active/Featured badge
                      if (portfolio.isActive == true)
                        Positioned(
                          top: AppSpacing.lg + 56,
                          left: AppSpacing.lg,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.sm,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppColors.accentGradient,
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusSm),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star, size: 16, color: Colors.white),
                                SizedBox(width: 6),
                                Text(
                                  'Featured Project',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
              
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Main content
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (true)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.md,
                                    vertical: AppSpacing.sm,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? AppColors.primaryLight
                                            .withValues(alpha: 0.15)
                                        : AppColors.primary
                                            .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(
                                        AppSpacing.radiusSm),
                                  ),
                                  child: Text(
                                    category.name,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? AppColors.primaryLight
                                          : AppColors.primary,
                                    ),
                                  ),
                                ),
                              const SizedBox(height: AppSpacing.md),
                              Text(
                                portfolio.title,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              Text(
                                'Project Description',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                portfolio.description.isNotEmpty
                                    ? portfolio.description
                                    : 'No description available.',
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
              
                        if (ResponsiveLayout.isTablet(context) ||
                            ResponsiveLayout.isDesktop(context))
                          Expanded(
                            child: Container(
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
                                    'Project Details',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: AppSpacing.lg),
                                  if (portfolio.$client != null) ...[
                                    _buildDetailRow(
                                      context,
                                      Iconsax.user,
                                      'Client',
                                      portfolio.$client!,
                                      isDark,
                                    ),
                                    const SizedBox(height: AppSpacing.md),
                                  ],
                                  if (portfolio.startDate != null) ...[
                                    _buildDetailRow(
                                      context,
                                      Iconsax.calendar,
                                      'Date',
                                      portfolio.startDate!,
                                      isDark,
                                    ),
                                    const SizedBox(height: AppSpacing.md),
                                  ],
                                  _buildDetailRow(
                                    context,
                                    Iconsax.folder,
                                    'Category',
                                    category.name,
                                    isDark,
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  const Divider(),
                                  const SizedBox(height: AppSpacing.md),
                                  _buildDetailRow(
                                    context,
                                    Iconsax.clock,
                                    'Created',
                                    portfolio.createdAt?.toIso8601String() ?? '-',
                                    isDark,
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  _buildDetailRow(
                                    context,
                                    Iconsax.refresh,
                                    'Updated',
                                    portfolio.updatedAt?.toIso8601String() ?? '-',
                                    isDark,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  // if mobile
                  if (ResponsiveLayout.isMobile(context))
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : AppColors.lightCard,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
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
                            'Project Details',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          if (portfolio.$client != null) ...[
                            _buildDetailRow(
                              context,
                              Iconsax.user,
                              'Client',
                              portfolio.$client!,
                              isDark,
                            ),
                            const SizedBox(height: AppSpacing.md),
                          ],
                          if (portfolio.startDate != null) ...[
                            _buildDetailRow(
                              context,
                              Iconsax.calendar,
                              'Date',
                              portfolio.startDate!,
                              isDark,
                            ),
                            const SizedBox(height: AppSpacing.md),
                          ],
                          _buildDetailRow(
                            context,
                            Iconsax.folder,
                            'Category',
                            category.name,
                            isDark,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          const Divider(),
                          const SizedBox(height: AppSpacing.md),
                          _buildDetailRow(
                            context,
                            Iconsax.clock,
                            'Created',
                            portfolio.createdAt?.toIso8601String() ?? '-',
                            isDark,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _buildDetailRow(
                            context,
                            Iconsax.refresh,
                            'Updated',
                            portfolio.updatedAt?.toIso8601String() ?? '-',
                            isDark,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
        loading: () => Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoading.card(height: 400),
              const SizedBox(height: AppSpacing.lg),
              ShimmerLoading.text(width: 100, height: 24),
              const SizedBox(height: AppSpacing.md),
              ShimmerLoading.text(width: 300, height: 32),
              const SizedBox(height: AppSpacing.lg),
              ShimmerLoading.text(width: double.infinity, height: 150),
            ],
          ),
        ),
        error: (error, _) => Center(child: Text('Error: $error')),
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
        title: const Text('Delete Portfolio Item'),
        content:
            const Text('Are you sure you want to delete this portfolio item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await ref
                  .read(portfoliosNotifierProvider.notifier)
                  .deletePortfolio(id);
              if (context.mounted) {
                Navigator.pop(dialogContext);
                context.go('/portfolio');
              }
            },
            child: Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
