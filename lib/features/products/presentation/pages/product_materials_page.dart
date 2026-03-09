import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../providers/product_material_provider.dart';

/// Product Materials list page
class ProductMaterialsPage extends ConsumerWidget {
  const ProductMaterialsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final materialsAsync = ref.watch(productMaterialsNotifierProvider);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/product-materials/new'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Iconsax.add),
        label: const Text('Add Material'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Materials',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Manage material types for your products',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
            sliver: materialsAsync.when(
              data: (materials) {
                if (materials.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.xxl),
                        child: Column(
                          children: [
                            Icon(
                              Iconsax.category,
                              size: 64,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              'No materials yet',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppColors.darkText
                                    : AppColors.lightText,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'Tap the button to add your first material',
                              style: TextStyle(
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

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final material = materials[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: GestureDetector(
                          // onTap: () =>
                          //     context.go('/product-materials/${material.id}'),
                          onTap: (){},
                          child: Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
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
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Icon
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.primaryGradient,
                                    borderRadius: BorderRadius.circular(
                                        AppSpacing.radiusMd),
                                  ),
                                  child: const Icon(
                                    Iconsax.category,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        material.name,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? AppColors.darkText
                                              : AppColors.lightText,
                                        ),
                                      ),
                                      if (material.description != null &&
                                          material.description!.isNotEmpty)
                                        Text(
                                          material.description!,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: isDark
                                                ? AppColors.darkTextSecondary
                                                : AppColors.lightTextSecondary,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Iconsax.arrow_right_3,
                                  size: 16,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: materials.length,
                  ),
                );
              },
              loading: () => SliverToBoxAdapter(
                child: Column(
                  children: List.generate(
                    5,
                    (i) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: ShimmerLoading.card(
                          width: double.infinity, height: 72),
                    ),
                  ),
                ),
              ),
              error: (error, _) => SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xxl),
                    child: Column(
                      children: [
                        Icon(Iconsax.warning_2,
                            size: 48, color: AppColors.error),
                        const SizedBox(height: AppSpacing.md),
                        Text('Failed to load materials: $error'),
                        const SizedBox(height: AppSpacing.md),
                        GradientButton(
                          text: 'Retry',
                          icon: Iconsax.refresh,
                          onPressed: () => ref
                              .read(productMaterialsNotifierProvider.notifier)
                              .loadMaterials(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
