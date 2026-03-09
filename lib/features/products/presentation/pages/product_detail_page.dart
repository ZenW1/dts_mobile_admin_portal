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
import '../../../../shared/widgets/color_selector.dart';
import '../providers/product_provider.dart';
import '../providers/product_color_provider.dart';
import '../providers/product_material_provider.dart';
import '../widgets/material_selector.dart';

/// Product detail page
class ProductDetailPage extends ConsumerWidget {
  final String id;

  const ProductDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final productAsync = ref.watch(productByIdProvider(id));
    final categoriesAsync = ref.watch(productCategoriesNotifierProvider);
    final colorsAsync = ref.watch(productColorsNotifierProvider);
    final materialsAsync = ref.watch(productMaterialsNotifierProvider);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: productAsync.when(
        data: (products) {
          final product = products?.data;
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

          final category = categoriesAsync.value
              ?.where(
                (c) => c.id == product.category?.id,
              )
              .firstOrNull;

          if (category == null) {
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
                  const Text('Category not found'),
                  const SizedBox(height: AppSpacing.md),
                  GradientButton(
                    text: 'Back to Products',
                    onPressed: () => context.go('/products'),
                  ),
                ],
              ),
            );
          }

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
                LayoutBuilder(builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 600;

                  final imageWidget = Container(
                    width: isMobile ? double.infinity : 400,
                    height: isMobile ? 300 : 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkBorder
                            : AppColors.lightBorder,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                      child: product.image != null && product.image!.isNotEmpty
                          ? Image.network(
                              product.image!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => ImagePlaceholder(
                                text: product.name,
                                width: isMobile ? double.infinity : 400,
                                height: isMobile ? 300 : 400,
                              ),
                            )
                          : ImagePlaceholder(
                              text: product.name,
                              width: isMobile ? double.infinity : 400,
                              height: isMobile ? 300 : 400,
                            ),
                    ),
                  );

                  final detailsWidget = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status and Stock badges
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: product.isActive ?? false
                                  ? AppColors.success.withOpacity(0.1)
                                  : AppColors.error.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusSm),
                            ),
                            child: Text(
                              product.isActive ?? false ? 'Active' : 'Inactive',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: product.isActive ?? false
                                    ? AppColors.success
                                    : AppColors.error,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: product.stock > 10
                                  ? AppColors.info.withOpacity(0.1)
                                  : AppColors.warning.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusSm),
                            ),
                            child: Text(
                              'Stock: ${product.stock}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: product.stock > 10
                                    ? AppColors.info
                                    : AppColors.warning,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Name
                      Text(
                        product.name,
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      // Category
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

                      // Price and Discount
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? AppColors.primaryLight
                                  : AppColors.primary,
                            ),
                          ),
                          if (product.discount != null && product.discount! > 0)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: AppSpacing.sm, bottom: AppSpacing.xs),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '-${product.discount}%',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  )),
                            )
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // Description
                      Text(
                        'Description',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        product.description ??
                            'No description available for this premium piece.',
                        style: TextStyle(
                          height: 1.6,
                          fontSize: 16,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // Colors & Materials Section
                      Text(
                        'Product Options',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      
                      // Colors
                      colorsAsync.when(
                        data: (allColors) => ColorSelector(
                          availableColors: allColors,
                          selectedColorIds: product.colors ?? [],
                          onSelectionChanged: (selectedColors) {
                            // Update product colors (this would typically call a provider)
                            // For now, this is read-only in the detail view
                          },
                          enabled: false, // Read-only in detail view
                          title: 'Available Colors',
                        ),
                        loading: () => const LinearProgressIndicator(),
                        error: (_, __) => const Text('Error loading colors'),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Materials
                      materialsAsync.when(
                        data: (allMaterials) => MaterialSelector(
                          availableMaterials: allMaterials,
                          selectedMaterialIds: product.materials ?? [],
                          onSelectionChanged: (selectedMaterials) {
                            // Update product materials (this would typically call a provider)
                            // For now, this is read-only in the detail view
                          },
                          enabled: false, // Read-only in detail view
                          title: 'Materials',
                        ),
                        loading: () => const LinearProgressIndicator(),
                        error: (_, __) => const Text('Error loading materials'),
                      ),

                      // Metadata
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        decoration: BoxDecoration(
                          color:
                              isDark ? AppColors.darkCard : AppColors.lightCard,
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
                              product.createdAt?.formattedDateTime ?? 'N/A',
                              isDark,
                            ),
                            const Divider(height: 24),
                            _buildMetaRow(
                              context,
                              'Last Updated',
                              product.updatedAt?.formattedDateTime ?? 'N/A',
                              isDark,
                            ),
                            const Divider(height: 24),
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
                  );

                  if (isMobile) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        imageWidget,
                        const SizedBox(height: AppSpacing.xl),
                        detailsWidget,
                      ],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageWidget,
                      const SizedBox(width: AppSpacing.xl),
                      Expanded(child: detailsWidget),
                    ],
                  );
                }),
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
