import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../providers/product_color_provider.dart';

/// Product Colors list page
class ProductColorsPage extends ConsumerWidget {
  const ProductColorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorsAsync = ref.watch(productColorsNotifierProvider);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/product-colors/new'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Iconsax.add),
        label: const Text('Add Color'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product Colors',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Manage color swatches for your products',
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
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
            sliver: colorsAsync.when(
              data: (colors) {
                if (colors.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.xxl),
                        child: Column(
                          children: [
                            Icon(
                              Iconsax.color_swatch,
                              size: 64,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              'No colors yet',
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
                              'Tap the button to add your first color',
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

                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 160,
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    childAspectRatio: 0.85,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final color = colors[index];
                      Color swatchColor = AppColors.primary;
                      if (color.hexCode != null && color.hexCode!.isNotEmpty) {
                        try {
                          final hex = color.hexCode!
                              .replaceAll('#', '')
                              .padLeft(6, '0');
                          swatchColor = Color(int.parse('FF$hex', radix: 16));
                        } catch (_) {}
                      }

                      return GestureDetector(
                        // onTap: () => context.go('/product-colors/${color.id}'),
                        onTap: (){},
                        child: Container(
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
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: swatchColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.3),
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: swatchColor.withValues(alpha: 0.4),
                                      blurRadius: 12,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.sm),
                                child: Text(
                                  color.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? AppColors.darkText
                                        : AppColors.lightText,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (color.hexCode != null)
                                Text(
                                  color.hexCode!.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: colors.length,
                  ),
                );
              },
              loading: () => SliverToBoxAdapter(
                child: ShimmerGrid(
                  itemCount: 8,
                  crossAxisCount: 4,
                  aspectRatio: 0.85,
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
                        Text('Failed to load colors: $error'),
                        const SizedBox(height: AppSpacing.md),
                        GradientButton(
                          text: 'Retry',
                          icon: Iconsax.refresh,
                          onPressed: () => ref
                              .read(productColorsNotifierProvider.notifier)
                              .loadColors(),
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
