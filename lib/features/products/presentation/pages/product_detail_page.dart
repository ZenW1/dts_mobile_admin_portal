import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/image_placeholder.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../../core/utils/extensions.dart';
import '../providers/product_provider.dart';

/// Product detail page
class ProductDetailPage extends ConsumerWidget {
  final String id;

  const ProductDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final productAsync = ref.watch(productByIdProvider(id));
    final categoriesAsync = ref.watch(productCategoriesNotifierProvider);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: productAsync.when(
        data: (product) {
          if (product == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.box_1,
                    size: 64,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Text('Product not found'),
                  const SizedBox(height: AppSpacing.md),
                  GradientButton(
                    text: 'Back to Products',
                    onPressed: () => context.go('/products'),
                  ),
                ],
              ),
            );
          }

          final category = categoriesAsync.value?.firstWhere(
            (c) => c.id == product.categoryId,
            orElse: () => throw Exception('Category not found'),
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button and actions
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.go('/products'),
                      icon: const Icon(Iconsax.arrow_left),
                      tooltip: 'Back',
                    ),
                    const Spacer(),
                    OutlinedButton.icon(
                      onPressed: () => context.go('/products/$id/edit'),
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

                // Content
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusLg),
                        border: Border.all(
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusLg),
                        child: ImagePlaceholder(
                          text: product.name,
                          width: 400,
                          height: 400,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xl),

                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: product.isActive
                                  ? AppColors.success.withValues(alpha: 0.1)
                                  : AppColors.error.withValues(alpha: 0.1),
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusSm),
                            ),
                            child: Text(
                              product.isActive ? 'Active' : 'Inactive',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: product.isActive
                                    ? AppColors.success
                                    : AppColors.error,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),

                          // Name
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: AppSpacing.sm),

                          // Category
                          if (category != null)
                            Row(
                              children: [
                                Icon(
                                  Iconsax.folder,
                                  size: 16,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Text(
                                  category.name,
                                  style: TextStyle(
                                    color: isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary,
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: AppSpacing.lg),

                          // Price
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? AppColors.primaryLight
                                  : AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),

                          // Description
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            product.description ?? 'No description available.',
                            style: TextStyle(
                              height: 1.6,
                              color: isDark
                                  ? AppColors.darkText
                                  : AppColors.lightText,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xl),

                          // Metadata
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkCard
                                  : AppColors.lightCard,
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusMd),
                              border: Border.all(
                                color: isDark
                                    ? AppColors.darkBorder
                                    : AppColors.lightBorder,
                              ),
                            ),
                            child: Column(
                              children: [
                                _buildMetaRow(
                                  context,
                                  'Created',
                                  product.createdAt.formattedDateTime,
                                  isDark,
                                ),
                                const Divider(),
                                _buildMetaRow(
                                  context,
                                  'Last Updated',
                                  product.updatedAt.formattedDateTime,
                                  isDark,
                                ),
                                const Divider(),
                                _buildMetaRow(
                                  context,
                                  'Product ID',
                                  product.id,
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
        loading: () => Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoading.card(width: 400, height: 400),
              const SizedBox(width: AppSpacing.xl),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading.text(width: 80, height: 24),
                    const SizedBox(height: AppSpacing.md),
                    ShimmerLoading.text(width: 300, height: 32),
                    const SizedBox(height: AppSpacing.lg),
                    ShimmerLoading.text(width: 150, height: 40),
                    const SizedBox(height: AppSpacing.lg),
                    ShimmerLoading.text(width: double.infinity, height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildMetaRow(
      BuildContext context, String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await ref
                  .read(productsNotifierProvider.notifier)
                  .deleteProduct(id);
              if (context.mounted) {
                Navigator.pop(dialogContext);
                context.go('/products');
              }
            },
            child: Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
