import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Rating widget for displaying and inputting star ratings
class RatingWidget extends StatelessWidget {
  final int rating;
  final int maxRating;
  final double size;
  final bool isInteractive;
  final ValueChanged<int>? onRatingChanged;
  final Color? activeColor;
  final Color? inactiveColor;

  const RatingWidget({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 24,
    this.isInteractive = false,
    this.onRatingChanged,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final active = activeColor ?? AppColors.warning;
    final inactive = inactiveColor ??
        (isDark ? AppColors.darkBorder : AppColors.lightBorder);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        final starValue = index + 1;
        final isFilled = starValue <= rating;

        return GestureDetector(
          onTap: isInteractive && onRatingChanged != null
              ? () => onRatingChanged!(starValue)
              : null,
          child: Padding(
            padding: const EdgeInsets.only(right: 2),
            child: Icon(
              isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
              size: size,
              color: isFilled ? active : inactive,
            ),
          ),
        );
      }),
    );
  }
}
