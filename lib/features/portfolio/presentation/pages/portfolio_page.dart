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
import '../providers/portfolio_provider.dart';
import '../widgets/portfolio_grid_item.dart';

/// Portfolio grid page
class PortfolioPage extends ConsumerStatefulWidget {
  const PortfolioPage({super.key});

  @override
  ConsumerState<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends ConsumerState<PortfolioPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredPortfolios = ref.watch(filteredPortfoliosProvider);
    final categories = ref.watch(portfolioCategoriesNotifierProvider);
    final filter = ref.watch(portfolioFilterProvider);

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
                              'Portfolio',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'Showcase your best work',
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
                        text: 'Add Project',
                        icon: Iconsax.add,
                        onPressed: () => context.go('/portfolio/new'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Search
                  CustomTextField(
                    controller: _searchController,
                    hint: 'Search portfolio...',
                    prefixIcon: const Icon(Iconsax.search_normal, size: 20),
                    onChanged: (value) {
                      ref.read(portfolioFilterProvider.notifier).state =
                          filter.copyWith(searchQuery: value);
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Category chips
                  categories.when(
                    data: (cats) => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip(
                              'All', filter.categoryId == null, isDark, () {
                            ref.read(portfolioFilterProvider.notifier).state =
                                const PortfolioFilterState();
                          }),
                          const SizedBox(width: AppSpacing.sm),
                          ...cats.map((cat) => Padding(
                                padding:
                                    const EdgeInsets.only(right: AppSpacing.sm),
                                child: _buildFilterChip(
                                  cat.name,
                                  filter.categoryId == cat.id,
                                  isDark,
                                  () {
                                    ref
                                        .read(portfolioFilterProvider.notifier)
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

          // Portfolio grid
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            sliver: filteredPortfolios.when(
              data: (portfolios) {
                if (portfolios.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.xxl),
                        child: Column(
                          children: [
                            Icon(
                              Iconsax.gallery,
                              size: 64,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              'No portfolio items found',
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

                return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveLayout.value(
                      context,
                      mobile: 1,
                      tablet: 2,
                      desktop: 3,
                    ),
                    mainAxisSpacing: AppSpacing.lg,
                    crossAxisSpacing: AppSpacing.lg,
                    childAspectRatio: 1.2,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final portfolio = portfolios[index];
                      return PortfolioGridItem(
                        portfolio: portfolio,
                        categoryName: portfolio.category?.name,
                        onTap: () => context.go('/portfolio/${portfolio.id}'),
                      );
                    },
                    childCount: portfolios.length,
                  ),
                );
              },
              loading: () => SliverToBoxAdapter(
                child: ShimmerGrid(
                  itemCount: 6,
                  crossAxisCount: ResponsiveLayout.value(
                    context,
                    mobile: 1,
                    tablet: 2,
                    desktop: 3,
                  ),
                  aspectRatio: 1.2,
                ),
              ),
              error: (error, _) => SliverToBoxAdapter(
                child: Center(child: Text('Error: $error')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
      String label, bool isSelected, bool isDark, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
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
            label,
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
}
