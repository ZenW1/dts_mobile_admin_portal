import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../../core/widgets/responsive_layout.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/category_chip.dart';

/// Products list page
class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({super.key});

  @override
  ConsumerState<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  final _searchController = TextEditingController();
  bool _isGridView = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredProducts = ref.watch(filteredProductsProvider);
    final categories = ref.watch(productCategoriesNotifierProvider);
    final filter = ref.watch(productFilterProvider);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and actions
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Products',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'Manage your product catalog',
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
                        text: 'Add Product',
                        icon: Iconsax.add,
                        onPressed: () => context.go('/products/new'),
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
                          hint: 'Search products...',
                          prefixIcon:
                              const Icon(Iconsax.search_normal, size: 20),
                          onChanged: (value) {
                            ref.read(productFilterProvider.notifier).state =
                                filter.copyWith(searchQuery: value);
                          },
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      // View toggle
                      Container(
                        decoration: BoxDecoration(
                          color:
                              isDark ? AppColors.darkCard : AppColors.lightCard,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusSm),
                          border: Border.all(
                            color: isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder,
                          ),
                        ),
                        child: Row(
                          children: [
                            _buildViewToggle(
                              icon: Iconsax.grid_1,
                              isActive: _isGridView,
                              onTap: () => setState(() => _isGridView = true),
                              isDark: isDark,
                            ),
                            _buildViewToggle(
                              icon: Iconsax.menu_1,
                              isActive: !_isGridView,
                              onTap: () => setState(() => _isGridView = false),
                              isDark: isDark,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Category chips
                  categories.when(
                    data: (cats) => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildAllChip(filter.categoryId == null, isDark),
                          const SizedBox(width: AppSpacing.sm),
                          ...cats.map((cat) => Padding(
                                padding:
                                    const EdgeInsets.only(right: AppSpacing.sm),
                                child: CategoryChip(
                                  category: cat,
                                  isSelected: filter.categoryId == cat.id,
                                  onTap: () {
                                    ref
                                        .read(productFilterProvider.notifier)
                                        .state = filter.copyWith(
                                      categoryId: filter.categoryId == cat.id
                                          ? null
                                          : cat.id,
                                    );
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),

          // Products grid/list
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            sliver: filteredProducts.when(
              data: (products) {
                if (products.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.xxl),
                        child: Column(
                          children: [
                            Icon(
                              Iconsax.box_1,
                              size: 64,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              'No products found',
                              style: TextStyle(
                                fontSize: 16,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                final categoriesData =
                    ref.read(productCategoriesNotifierProvider).value ?? [];

                if (_isGridView) {
                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveLayout.gridColumns(context),
                      mainAxisSpacing: AppSpacing.md,
                      crossAxisSpacing: AppSpacing.md,
                      childAspectRatio: 0.65, // Taller cards for premium feel
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = products[index];
                        final category = categoriesData
                            .where((c) => c.id == product.category?.id)
                            .firstOrNull;
                        return ProductCard(
                          product: product,
                          categoryName: category?.name,
                          isGridView: true,
                          onTap: () => context.go('/products/${product.id}'),
                        );
                      },
                      childCount: products.length,
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = products[index];
                      final category = categoriesData
                          .where((c) => c.id == product.category?.id)
                          .firstOrNull;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: ProductCard(
                          product: product,
                          categoryName: category?.name,
                          onTap: () => context.go('/products/${product.id}'),
                          onEdit: () =>
                              context.go('/products/${product.id}/edit'),
                          onDelete: () =>
                              _showDeleteDialog(context, product.id),
                        ),
                      );
                    },
                    childCount: products.length,
                  ),
                );
              },
              loading: () => SliverToBoxAdapter(
                child: ShimmerGrid(
                  itemCount: 6,
                  crossAxisCount: ResponsiveLayout.gridColumns(context),
                ),
              ),
              error: (error, _) => SliverToBoxAdapter(
                child: Center(
                  child: Text('Error: $error'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewToggle({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: isActive
                ? (isDark
                    ? AppColors.primaryLight.withValues(alpha: 0.15)
                    : AppColors.primary.withValues(alpha: 0.1))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isActive
                ? (isDark ? AppColors.primaryLight : AppColors.primary)
                : (isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary),
          ),
        ),
      ),
    );
  }

  Widget _buildAllChip(bool isSelected, bool isDark) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          ref.read(productFilterProvider.notifier).state =
              const ProductFilterState();
        },
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: AppSpacing.animFast),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? AppColors.primaryLight : AppColors.primary)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            border: Border.all(
              color: isSelected
                  ? (isDark ? AppColors.primaryLight : AppColors.primary)
                  : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
          ),
          child: Text(
            'All',
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected
                  ? Colors.white
                  : (isDark ? AppColors.darkText : AppColors.lightText),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String productId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(productsNotifierProvider.notifier)
                  .deleteProduct(productId);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
