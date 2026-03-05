import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

/// Image placeholder with gradient background
class ImagePlaceholder extends StatelessWidget {
  final double? width;
  final double? height;
  final String? text;
  final IconData? icon;
  final double borderRadius;
  final int? colorIndex;
  final BoxFit fit;

  const ImagePlaceholder({
    super.key,
    this.width,
    this.height,
    this.text,
    this.icon,
    this.borderRadius = AppSpacing.radiusMd,
    this.colorIndex,
    this.fit = BoxFit.cover,
  });

  /// List of gradient colors based on primary color palette
  static const List<List<Color>> _gradients = [
    [AppColors.primary, AppColors.primaryLight],
    [AppColors.primaryDark, AppColors.primary],
    [AppColors.primary, AppColors.primaryDark],
    [AppColors.primaryLight, AppColors.primary],
  ];

  @override
  Widget build(BuildContext context) {
    final index = colorIndex ?? text?.hashCode.abs() ?? 0;
    final colors = _gradients[index % _gradients.length];

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: icon != null
            ? Icon(
                icon,
                size: (height ?? 48) * 0.4,
                color: Colors.white.withValues(alpha: 0.8),
              )
            : text != null
                ? Text(
                    _getInitials(text!),
                    style: TextStyle(
                      fontSize: (height ?? 48) * 0.3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                : Icon(
                    Icons.image_outlined,
                    size: (height ?? 48) * 0.4,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
      ),
    );
  }

  String _getInitials(String text) {
    final words = text.trim().split(' ');
    if (words.isEmpty) return '';
    if (words.length == 1) {
      return words[0].substring(0, words[0].length.clamp(0, 2)).toUpperCase();
    }
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }
}
