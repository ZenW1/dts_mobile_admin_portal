import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../domain/entities/customer_feedback.dart';
import '../providers/feedback_provider.dart';
import '../widgets/feedback_card.dart';

/// Customer feedback list page
class FeedbacksPage extends ConsumerStatefulWidget {
  const FeedbacksPage({super.key});

  @override
  ConsumerState<FeedbacksPage> createState() => _FeedbacksPageState();
}

class _FeedbacksPageState extends ConsumerState<FeedbacksPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final feedbacksAsync = ref.watch(filteredFeedbackProvider);
    final statsAsync = ref.watch(feedbackStatsNotifierProvider);
    final filter = ref.watch(feedbackFilterProvider);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(feedbackNotifierProvider.notifier).loadFeedbacks();
            await ref.read(feedbackStatsNotifierProvider.notifier).loadStats();
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;
              final isTablet =
                  constraints.maxWidth >= 600 && constraints.maxWidth < 900;

              return Padding(
                padding: EdgeInsets.all(isMobile ? AppSpacing.md : AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    if (isMobile)
                      _buildMobileHeader(isDark)
                    else
                      _buildDesktopHeader(isDark),

                    SizedBox(height: isMobile ? AppSpacing.md : AppSpacing.xl),

                    // Stats cards
                    statsAsync.when(
                      data: (stats) =>
                          _buildStatsCards(stats, isDark, isMobile, isTablet),
                      loading: () => const ShimmerLoading(height: 145),
                      error: (_, __) => const SizedBox.shrink(),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Search and filter row
                    if (isMobile)
                      _buildMobileSearchAndFilter(filter, isDark)
                    else
                      _buildDesktopSearchAndFilter(filter, isDark),

                    const SizedBox(height: AppSpacing.lg),

                    // Feedback list
                    Expanded(
                      child: feedbacksAsync.when(
                        data: (feedbacks) {
                          if (feedbacks.isEmpty) {
                            return _buildEmptyState(isDark);
                          }
                          return ListView.separated(
                            itemCount: feedbacks.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: AppSpacing.md),
                            itemBuilder: (context, index) {
                              final feedback = feedbacks[index];
                              return FeedbackCard(
                                feedback: feedback,
                                onTap: (){},
                                // onTap: () =>
                                //     context.go('/feedbacks/${feedback.id}'),
                                onEdit: () => context.go(
                                  '/feedbacks/${feedback.id}/edit',
                                  extra: feedback,
                                ),
                                onDelete: () =>
                                    _showDeleteDialog(context, feedback.id),
                              );
                            },
                          );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (error, _) => Center(
                          child: Text(
                            'Error: $error',
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.darkText
                                  : AppColors.lightText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // ---- Header builders ----

  Widget _buildMobileHeader(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Customer Feedback',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
            ),
            GradientButton(
              onPressed: () => context.go('/feedbacks/new'),
              icon: Iconsax.add,
              text: 'Add',
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Manage and respond to customer feedback',
          style: TextStyle(
            fontSize: 13,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopHeader(bool isDark) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer Feedback',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage and respond to customer feedback',
              style: TextStyle(
                fontSize: 14,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
        const Spacer(),
        GradientButton(
          onPressed: () => context.go('/feedbacks/new'),
          icon: Iconsax.add,
          text: 'Add Feedback',
        ),
      ],
    );
  }

  // ---- Stats cards ----

  Widget _buildStatsCards(
      dynamic stats, bool isDark, bool isMobile, bool isTablet) {
    final cards = [
      _buildStatCard(
        icon: Iconsax.message_text,
        label: 'Total',
        value: stats.totalCount.toString(),
        color: AppColors.primary,
        isDark: isDark,
      ),
      _buildStatCard(
        icon: Iconsax.clock,
        label: 'Pending',
        value: stats.pendingCount.toString(),
        color: AppColors.warning,
        isDark: isDark,
      ),
      _buildStatCard(
        icon: Iconsax.eye,
        label: 'Reviewed',
        value: stats.reviewedCount.toString(),
        color: AppColors.info,
        isDark: isDark,
      ),
      _buildStatCard(
        icon: Iconsax.tick_circle,
        label: 'Resolved',
        value: stats.resolvedCount.toString(),
        color: AppColors.success,
        isDark: isDark,
      ),
      _buildStatCard(
        icon: Iconsax.star,
        label: 'Avg Rating',
        value: stats.averageRating.toStringAsFixed(1),
        color: AppColors.warning,
        isDark: isDark,
      ),
    ];

    if (isMobile) {
      // 2-column grid on mobile, scrollable
      return SizedBox(
        height: 145,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: cards.length,
          separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
          itemBuilder: (context, index) => SizedBox(
            width: 140,
            child: cards[index],
          ),
        ),
      );
    }

    if (isTablet) {
      return Wrap(
        spacing: AppSpacing.md,
        runSpacing: AppSpacing.md,
        children: cards
            .map((card) => SizedBox(
                  width: 150,
                  child: card,
                ))
            .toList(),
      );
    }

    // Desktop: row
    return Row(
      children: cards
          .expand((card) => [
                Expanded(child: card),
                const SizedBox(width: AppSpacing.md),
              ])
          .toList()
        ..removeLast(),
    );
  }

  // ---- Search / filter ----

  Widget _buildMobileSearchAndFilter(dynamic filter, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search field full width
        CustomTextField(
          controller: _searchController,
          hint: 'Search feedback...',
          prefixIcon: const Icon(Iconsax.search_normal, size: 20),
          onChanged: (value) {
            ref.read(feedbackFilterProvider.notifier).state =
                filter.copyWith(searchQuery: value);
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        // Filter chips in a scrollable row
        Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip(
                      label: 'All',
                      isSelected: filter.status == null,
                      onTap: () {
                        ref.read(feedbackFilterProvider.notifier).state =
                            filter.copyWith(clearStatus: true);
                      },
                      isDark: isDark,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _buildFilterChip(
                      label: 'Pending',
                      isSelected: filter.status == FeedbackStatus.pending,
                      onTap: () {
                        ref.read(feedbackFilterProvider.notifier).state =
                            filter.copyWith(status: FeedbackStatus.pending);
                      },
                      isDark: isDark,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _buildFilterChip(
                      label: 'Reviewed',
                      isSelected: filter.status == FeedbackStatus.reviewed,
                      onTap: () {
                        ref.read(feedbackFilterProvider.notifier).state =
                            filter.copyWith(status: FeedbackStatus.reviewed);
                      },
                      isDark: isDark,
                      color: AppColors.info,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _buildFilterChip(
                      label: 'Resolved',
                      isSelected: filter.status == FeedbackStatus.resolved,
                      onTap: () {
                        ref.read(feedbackFilterProvider.notifier).state =
                            filter.copyWith(status: FeedbackStatus.resolved);
                      },
                      isDark: isDark,
                      color: AppColors.success,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                ref.read(feedbackNotifierProvider.notifier).loadFeedbacks();
                ref.read(feedbackStatsNotifierProvider.notifier).loadStats();
              },
              icon: const Icon(Iconsax.refresh),
              tooltip: 'Refresh',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopSearchAndFilter(dynamic filter, bool isDark) {
    return Row(
      children: [
        // Search field
        Expanded(
          flex: 2,
          child: CustomTextField(
            controller: _searchController,
            hint: 'Search feedback...',
            prefixIcon: const Icon(Iconsax.search_normal, size: 20),
            onChanged: (value) {
              ref.read(feedbackFilterProvider.notifier).state =
                  filter.copyWith(searchQuery: value);
            },
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        // Filter chips
        _buildFilterChip(
          label: 'All',
          isSelected: filter.status == null,
          onTap: () {
            ref.read(feedbackFilterProvider.notifier).state =
                filter.copyWith(clearStatus: true);
          },
          isDark: isDark,
        ),
        const SizedBox(width: AppSpacing.sm),
        _buildFilterChip(
          label: 'Pending',
          isSelected: filter.status == FeedbackStatus.pending,
          onTap: () {
            ref.read(feedbackFilterProvider.notifier).state =
                filter.copyWith(status: FeedbackStatus.pending);
          },
          isDark: isDark,
          color: AppColors.warning,
        ),
        const SizedBox(width: AppSpacing.sm),
        _buildFilterChip(
          label: 'Reviewed',
          isSelected: filter.status == FeedbackStatus.reviewed,
          onTap: () {
            ref.read(feedbackFilterProvider.notifier).state =
                filter.copyWith(status: FeedbackStatus.reviewed);
          },
          isDark: isDark,
          color: AppColors.info,
        ),
        const SizedBox(width: AppSpacing.sm),
        _buildFilterChip(
          label: 'Resolved',
          isSelected: filter.status == FeedbackStatus.resolved,
          onTap: () {
            ref.read(feedbackFilterProvider.notifier).state =
                filter.copyWith(status: FeedbackStatus.resolved);
          },
          isDark: isDark,
          color: AppColors.success,
        ),
        const Spacer(),
        // Refresh button
        IconButton(
          onPressed: () {
            ref.read(feedbackNotifierProvider.notifier).loadFeedbacks();
            ref.read(feedbackStatsNotifierProvider.notifier).loadStats();
          },
          icon: const Icon(Iconsax.refresh),
          tooltip: 'Refresh',
        ),
      ],
    );
  }

  // ---- Shared widgets ----

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Icon(icon, size: 20, color: color),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
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

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
    Color? color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? (color ?? AppColors.primary).withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            border: Border.all(
              color: isSelected
                  ? (color ?? AppColors.primary)
                  : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected
                  ? (color ?? AppColors.primary)
                  : (isDark ? AppColors.darkText : AppColors.lightText),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.message_notif,
            size: 64,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No feedback found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String feedbackId) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:
            isDark ? AppColors.darkSurface : AppColors.lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        title: Text(
          'Delete Feedback',
          style: TextStyle(
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this feedback? This action cannot be undone.',
          style: TextStyle(
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(feedbackNotifierProvider.notifier)
                  .deleteFeedback(feedbackId);
              ref.read(feedbackStatsNotifierProvider.notifier).loadStats();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
