import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

/// Glassmorphism utility class for creating frosted glass effects
class Glassmorphism {
  Glassmorphism._();

  /// Creates a glass decoration with customizable blur and opacity
  static BoxDecoration glassDecoration({
    double blur = 10.0,
    double opacity = 0.1,
    Color? borderColor,
    double borderWidth = 1.0,
    double borderRadius = AppSpacing.radiusMd,
    Gradient? gradient,
  }) {
    return BoxDecoration(
      gradient: gradient ??
          LinearGradient(
            colors: [
              Colors.white.withValues(alpha: opacity),
              Colors.white.withValues(alpha: opacity * 0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? AppColors.glassBorder,
        width: borderWidth,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 20,
          spreadRadius: -5,
        ),
      ],
    );
  }

  /// Creates a dark glass decoration for dark theme
  static BoxDecoration darkGlassDecoration({
    double blur = 10.0,
    double opacity = 0.2,
    Color? borderColor,
    double borderWidth = 1.0,
    double borderRadius = AppSpacing.radiusMd,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: opacity * 0.15),
          Colors.white.withValues(alpha: opacity * 0.05),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? Colors.white.withValues(alpha: 0.1),
        width: borderWidth,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 20,
          spreadRadius: -5,
        ),
      ],
    );
  }

  /// Widget wrapper for clipping and adding blur effect
  static Widget blurContainer({
    required Widget child,
    double blur = 10.0,
    double borderRadius = AppSpacing.radiusMd,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: child,
      ),
    );
  }
}
