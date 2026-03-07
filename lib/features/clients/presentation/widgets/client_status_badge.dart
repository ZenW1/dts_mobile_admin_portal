import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/entities/client.dart';

class ClientStatusBadge extends StatelessWidget {
  final ClientStatus status;
  final bool isSmall;

  const ClientStatusBadge({
    super.key,
    required this.status,
    this.isSmall = false,
  });

  Color get _backgroundColor {
    switch (status) {
      case ClientStatus.active:
        return AppColors.success.withValues(alpha: 0.15);
      case ClientStatus.inactive:
        return isSmall
            ? AppColors.lightTextSecondary.withValues(alpha: 0.15)
            : AppColors.lightTextSecondary.withValues(alpha: 0.15);
      case ClientStatus.prospect:
        return AppColors.primary.withValues(alpha: 0.15);
    }
  }

  Color get _textColor {
    switch (status) {
      case ClientStatus.active:
        return AppColors.success;
      case ClientStatus.inactive:
        return isSmall
            ? AppColors.lightTextSecondary
            : AppColors.lightTextSecondary;
      case ClientStatus.prospect:
        return AppColors.primary;
    }
  }

  String get _displayName {
    switch (status) {
      case ClientStatus.active:
        return "Active";
      case ClientStatus.inactive:
        return "Inactive";
      case ClientStatus.prospect:
        return "Prospect";
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
        _displayName,
        style: TextStyle(
          fontSize: isSmall ? 11 : 12,
          fontWeight: FontWeight.w600,
          color: _textColor,
        ),
      ),
    );
  }
}
