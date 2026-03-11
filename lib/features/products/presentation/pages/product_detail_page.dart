import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/image_placeholder.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../generated_code/swagger.swagger.dart';
import '../../../../shared/widgets/color_selector.dart';
import '../../domain/entities/product_category.dart';
import '../../domain/entities/product_color.dart';
import '../../domain/entities/product_material.dart';
import '../providers/product_provider.dart';
import '../providers/product_color_provider.dart';
import '../providers/product_material_provider.dart';
import '../widgets/material_selector.dart';
import '../../../../core/services/dummy_service.dart';

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
            return _buildNotFound(context, isDark);
          }

          final category = categoriesAsync.value
              ?.where((c) => c.id == product.category?.id)
              .firstOrNull;

          if (category == null && !categoriesAsync.isLoading) {
            return _buildCategoryNotFound(context, isDark);
          }

          return _buildContent(
            context,
            ref,
            product,
            category ?? ProductCategory(name: 'Loading Category...'),
            isDark,
            colorsAsync.value ?? [],
            materialsAsync.value ?? [],
          );
        },
        loading: () {
          final mockProduct = DummyService.mockProductForSkeleton;
          final mockCategory = DummyService.mockCategoryForSkeleton;

          return Skeletonizer(
            enabled: true,
            child: _buildContent(
              context,
              ref,
              mockProduct,
              mockCategory,
              isDark,
              const [], // empty List<ProductColor>
              const [], // empty List<ProductMaterial>
            ),
          );
        },
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildNotFound(BuildContext context, bool isDark) {
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

  Widget _buildCategoryNotFound(BuildContext context, bool isDark) {
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

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    ProductResponseDTO product,
    ProductCategory category,
    bool isDark,
    List<ProductColor> allColors,
    List<ProductMaterial> allMaterials,
  ) {
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
              Skeleton.ignore(
                child: Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () =>
                          context.go('/products/${product.id}/edit'),
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
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Content
          LayoutBuilder(builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;

            final imageWidget = _ProductImageCarousel(
              productName: product.name,
              primaryImage: product.image != null && product.image!.isNotEmpty
                  ? product.image!.first
                  : null,
              variantImages: product.image
                  ?.map((item) => item)
                  .whereType<String>()
                  .toList(),
              isMobile: isMobile,
              isDark: isDark,
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
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
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
                        color:
                            isDark ? AppColors.primaryLight : AppColors.primary,
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
                ColorSelector(
                  availableColors: allColors,
                  selectedColorIds: product.colors ?? [],
                  onSelectionChanged: (selectedColors) {},
                  enabled: false,
                  title: 'Available Colors',
                ),
                const SizedBox(height: AppSpacing.lg),

                // Materials
                MaterialSelector(
                  availableMaterials: allMaterials,
                  selectedMaterialIds: product.materials ?? [],
                  onSelectionChanged: (selectedMaterials) {},
                  enabled: false,
                  title: 'Materials',
                ),

                const SizedBox(height: AppSpacing.lg),

                // Metadata
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : AppColors.lightCard,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    border: Border.all(
                      color:
                          isDark ? AppColors.darkBorder : AppColors.lightBorder,
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

class _ProductImageCarousel extends StatefulWidget {
  final String productName;
  final String? primaryImage;
  final List<String>? variantImages;
  final bool isMobile;
  final bool isDark;

  const _ProductImageCarousel({
    required this.productName,
    this.primaryImage,
    this.variantImages,
    required this.isMobile,
    required this.isDark,
  });

  @override
  State<_ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<_ProductImageCarousel> {
  late final PageController _controller;
  int _currentIndex = 0;
  List<String> _allImages = [];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _allImages = [
      if (widget.primaryImage != null && widget.primaryImage!.isNotEmpty)
        widget.primaryImage!,
      if (widget.variantImages != null)
        ...widget.variantImages!.where((url) =>
            url.isNotEmpty &&
            url != widget.primaryImage), // Avoid duplicate primary
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_allImages.isEmpty) {
      return ImagePlaceholder(
        text: widget.productName,
        width: widget.isMobile ? double.infinity : 400,
        height: widget.isMobile ? 300 : 400,
      );
    }

    return Container(
      width: widget.isMobile ? double.infinity : 400,
      height: widget.isMobile ? 300 : 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Carousel
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            child: Skeleton.ignore(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemCount: _allImages.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    _allImages[index],
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => ImagePlaceholder(
                      text: widget.productName,
                      width: widget.isMobile ? double.infinity : 400,
                      height: widget.isMobile ? 300 : 400,
                    ),
                  );
                },
              ),
            ),
          ),

          // Indicators
          if (_allImages.length > 1)
            Positioned(
              bottom: AppSpacing.md,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _allImages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentIndex == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _currentIndex == index
                          ? AppColors.primary
                          : Colors.white.withOpacity(0.5),
                      boxShadow: [
                        if (_currentIndex == index)
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Left/Right buttons for desktop
          if (!widget.isMobile && _allImages.length > 1) ...[
            Positioned(
              left: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: _buildArrowButton(
                  icon: Iconsax.arrow_left_2,
                  onPressed: () {
                    _controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: _buildArrowButton(
                  icon: Iconsax.arrow_right_3,
                  onPressed: () {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildArrowButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}
