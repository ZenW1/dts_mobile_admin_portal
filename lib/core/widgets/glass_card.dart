import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';
import '../theme/glassmorphism.dart';

/// A frosted glass card widget with blur effect
class GlassCard extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final Color? borderColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final bool isDark;

  const GlassCard({
    super.key,
    required this.child,
    this.blur = 10.0,
    this.opacity = 0.1,
    this.borderColor,
    this.borderRadius = AppSpacing.radiusMd,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.onTap,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = isDark
        ? Glassmorphism.darkGlassDecoration(
            blur: blur,
            opacity: opacity,
            borderColor: borderColor,
            borderRadius: borderRadius,
          )
        : Glassmorphism.glassDecoration(
            blur: blur,
            opacity: opacity,
            borderColor: borderColor,
            borderRadius: borderRadius,
          );

    Widget card = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          padding: padding ?? const EdgeInsets.all(AppSpacing.md),
          decoration: decoration,
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      card = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: card,
        ),
      );
    }

    if (margin != null) {
      card = Padding(padding: margin!, child: card);
    }

    return card;
  }
}
