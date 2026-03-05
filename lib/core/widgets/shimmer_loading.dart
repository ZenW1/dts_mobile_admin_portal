import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

/// Shimmer loading placeholder widget
class ShimmerLoading extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final bool isCircle;

  const ShimmerLoading({
    super.key,
    this.width,
    this.height,
    this.borderRadius = AppSpacing.radiusSm,
    this.isCircle = false,
  });

  /// Creates a text line shimmer
  factory ShimmerLoading.text({
    double width = 100,
    double height = 16,
  }) {
    return ShimmerLoading(
      width: width,
      height: height,
      borderRadius: 4,
    );
  }

  /// Creates a card shimmer
  factory ShimmerLoading.card({
    double? width,
    double height = 120,
  }) {
    return ShimmerLoading(
      width: width,
      height: height,
      borderRadius: AppSpacing.radiusMd,
    );
  }

  /// Creates an avatar shimmer
  factory ShimmerLoading.avatar({
    double size = 48,
  }) {
    return ShimmerLoading(
      width: size,
      height: size,
      isCircle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.darkSurface : AppColors.lightDivider,
      highlightColor: isDark ? AppColors.darkCard : Colors.white,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightDivider,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle ? null : BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// A shimmer list item for loading states
class ShimmerListItem extends StatelessWidget {
  final bool hasImage;
  final bool hasSubtitle;

  const ShimmerListItem({
    super.key,
    this.hasImage = true,
    this.hasSubtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          if (hasImage) ...[
            ShimmerLoading.avatar(size: 48),
            const SizedBox(width: AppSpacing.md),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoading.text(width: 150, height: 16),
                if (hasSubtitle) ...[
                  const SizedBox(height: AppSpacing.sm),
                  ShimmerLoading.text(width: 100, height: 12),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A shimmer grid for loading cards
class ShimmerGrid extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final double aspectRatio;

  const ShimmerGrid({
    super.key,
    this.itemCount = 6,
    this.crossAxisCount = 3,
    this.aspectRatio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: aspectRatio,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => ShimmerLoading.card(),
    );
  }
}
