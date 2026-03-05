import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';

import '../../domain/entities/customer_feedback.dart';
import '../providers/feedback_provider.dart';
import '../widgets/rating_widget.dart';
import '../widgets/status_badge.dart';

/// Feedback detail page
class FeedbackDetailPage extends ConsumerWidget {
  final String id;

  const FeedbackDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final feedbackAsync = ref.watch(feedbackByIdProvider(id));

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: feedbackAsync.when(
          data: (feedback) {
            if (feedback == null) {
              return _buildNotFound(context, isDark);
            }
            return _buildContent(context, ref, feedback, isDark);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Text(
              'Error: $error',
              style: TextStyle(
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotFound(BuildContext context, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.message_question,
            size: 64,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Feedback not found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          GradientButton(
            onPressed: () => context.go('/feedbacks'),
            text: 'Back to Feedbacks',
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    CustomerFeedback feedback,
    bool isDark,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? AppSpacing.md : AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button
              if (isMobile)
                _buildMobileHeader(context, feedback, isDark)
              else
                _buildDesktopHeader(context, feedback, isDark),

              SizedBox(height: isMobile ? AppSpacing.md : AppSpacing.xl),

              // Main content — stacked on mobile, side-by-side on desktop
              if (isMobile) ...[
                // Status card first on mobile for quick access
                _buildCard(
                  isDark: isDark,
                  title: 'Status',
                  icon: Iconsax.status,
                  child: _buildStatusContent(ref, feedback, isDark),
                ),
                const SizedBox(height: AppSpacing.md),
                // Rating card
                _buildCard(
                  isDark: isDark,
                  title: 'Rating',
                  icon: Iconsax.star,
                  child: _buildRatingContent(feedback, isDark),
                ),
                const SizedBox(height: AppSpacing.md),
                // Customer info card
                _buildCard(
                  isDark: isDark,
                  title: 'Customer Information',
                  icon: Iconsax.user,
                  child: _buildCustomerInfoContent(feedback, isDark),
                ),
                const SizedBox(height: AppSpacing.md),
                // Feedback content card
                _buildCard(
                  isDark: isDark,
                  title: 'Feedback Content',
                  icon: Iconsax.message_text,
                  child: _buildFeedbackContent(feedback, isDark),
                ),
                const SizedBox(height: AppSpacing.md),
                // Metadata card
                _buildCard(
                  isDark: isDark,
                  title: 'Metadata',
                  icon: Iconsax.info_circle,
                  child: _buildMetadataContent(feedback, isDark),
                ),
              ] else ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left column - Customer info and feedback
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          _buildCard(
                            isDark: isDark,
                            title: 'Customer Information',
                            icon: Iconsax.user,
                            child: _buildCustomerInfoContent(feedback, isDark),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          _buildCard(
                            isDark: isDark,
                            title: 'Feedback Content',
                            icon: Iconsax.message_text,
                            child: _buildFeedbackContent(feedback, isDark),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    // Right column - Status, rating, metadata
                    Expanded(
                      child: Column(
                        children: [
                          _buildCard(
                            isDark: isDark,
                            title: 'Status',
                            icon: Iconsax.status,
                            child: _buildStatusContent(ref, feedback, isDark),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          _buildCard(
                            isDark: isDark,
                            title: 'Rating',
                            icon: Iconsax.star,
                            child: _buildRatingContent(feedback, isDark),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          _buildCard(
                            isDark: isDark,
                            title: 'Metadata',
                            icon: Iconsax.info_circle,
                            child: _buildMetadataContent(feedback, isDark),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  // ---- Header builders ----

  Widget _buildMobileHeader(
      BuildContext context, CustomerFeedback feedback, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => context.go('/feedbacks'),
              icon: const Icon(Iconsax.arrow_left),
              tooltip: 'Back',
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                'Feedback Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
            ),
            GradientButton(
              onPressed: () => context.go(
                '/feedbacks/${feedback.id}/edit',
                extra: feedback,
              ),
              icon: Iconsax.edit_2,
              text: 'Edit',
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 48),
          child: Text(
            'ID: ${feedback.id}',
            style: TextStyle(
              fontSize: 12,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopHeader(
      BuildContext context, CustomerFeedback feedback, bool isDark) {
    return Row(
      children: [
        IconButton(
          onPressed: () => context.go('/feedbacks'),
          icon: const Icon(Iconsax.arrow_left),
          tooltip: 'Back',
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Feedback Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'ID: ${feedback.id}',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
        GradientButton(
          onPressed: () => context.go(
            '/feedbacks/${feedback.id}/edit',
            extra: feedback,
          ),
          icon: Iconsax.edit_2,
          text: 'Edit',
        ),
      ],
    );
  }

  // ---- Content builders (extracted for reuse) ----

  Widget _buildCustomerInfoContent(CustomerFeedback feedback, bool isDark) {
    return Column(
      children: [
        _buildInfoRow(
          label: 'Name',
          value: feedback.customerName ?? '---',
          icon: Iconsax.user,
          isDark: isDark,
        ),
        const Divider(),
        _buildInfoRow(
          label: 'Email',
          value: feedback.email ?? 'No email provided',
          icon: Iconsax.sms,
          isDark: isDark,
        ),
        if (feedback.phone != null) ...[
          const Divider(),
          _buildInfoRow(
            label: 'Phone',
            value: feedback.phone!,
            icon: Iconsax.call,
            isDark: isDark,
          ),
        ],
      ],
    );
  }

  Widget _buildFeedbackContent(CustomerFeedback feedback, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          feedback.subject ?? '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          feedback.message ?? 'No message provided',
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusContent(
      WidgetRef ref, CustomerFeedback feedback, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            StatusBadge(status: feedback.status),
            const Spacer(),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Update Status',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: FeedbackStatus.values.map((status) {
            final isSelected = feedback.status == status;
            return _buildStatusChip(
              status: status,
              isSelected: isSelected,
              isDark: isDark,
              onTap: isSelected
                  ? null
                  : () {
                      ref
                          .read(feedbackNotifierProvider.notifier)
                          .updateStatus(feedback.id, status);
                      ref
                          .read(feedbackStatsNotifierProvider.notifier)
                          .loadStats();
                    },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRatingContent(CustomerFeedback feedback, bool isDark) {
    return Column(
      children: [
        RatingWidget(
          rating: feedback.rating ?? 0,
          size: 32,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          '${feedback.rating} out of 5',
          style: TextStyle(
            fontSize: 14,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMetadataContent(CustomerFeedback feedback, bool isDark) {
    return Column(
      children: [
        _buildInfoRow(
          label: 'Created',
          value: _formatDateTime(feedback.createdAt),
          icon: Iconsax.calendar_add,
          isDark: isDark,
        ),
        const Divider(),
        _buildInfoRow(
          label: 'Updated',
          value: _formatDateTime(feedback.updatedAt),
          icon: Iconsax.calendar_edit,
          isDark: isDark,
        ),
        const Divider(),
        _buildInfoRow(
          label: 'Active',
          value: feedback.isActive ? 'Yes' : 'No',
          icon: feedback.isActive ? Iconsax.tick_circle : Iconsax.close_circle,
          isDark: isDark,
        ),
      ],
    );
  }

  // ---- Shared widgets ----

  Widget _buildCard({
    required bool isDark,
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: isDark ? AppColors.primaryLight : AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    required IconData icon,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip({
    required FeedbackStatus status,
    required bool isSelected,
    required bool isDark,
    VoidCallback? onTap,
  }) {
    Color color;
    switch (status) {
      case FeedbackStatus.pending:
        color = AppColors.warning;
        break;
      case FeedbackStatus.reviewed:
        color = AppColors.info;
        break;
      case FeedbackStatus.resolved:
        color = AppColors.success;
        break;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color:
                isSelected ? color.withValues(alpha: 0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            border: Border.all(
              color: isSelected
                  ? color
                  : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
          ),
          child: Text(
            status.displayName,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected
                  ? color
                  : (isDark ? AppColors.darkText : AppColors.lightText),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
