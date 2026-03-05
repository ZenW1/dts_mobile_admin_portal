import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/entities/customer_feedback.dart';

/// Status badge widget for feedback status display
class StatusBadge extends StatelessWidget {
  final FeedbackStatus status;
  final bool isSmall;

  const StatusBadge({
    super.key,
    required this.status,
    this.isSmall = false,
  });

  Color get _backgroundColor {
    switch (status) {
      case FeedbackStatus.pending:
        return AppColors.warning.withValues(alpha: 0.15);
      case FeedbackStatus.reviewed:
        return AppColors.info.withValues(alpha: 0.15);
      case FeedbackStatus.resolved:
        return AppColors.success.withValues(alpha: 0.15);
    }
  }

  Color get _textColor {
    switch (status) {
      case FeedbackStatus.pending:
        return AppColors.warning;
      case FeedbackStatus.reviewed:
        return AppColors.info;
      case FeedbackStatus.resolved:
        return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? AppSpacing.sm : AppSpacing.md,
        vertical: isSmall ? 2 : AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          fontSize: isSmall ? 11 : 12,
          fontWeight: FontWeight.w600,
          color: _textColor,
        ),
      ),
    );
  }
}
