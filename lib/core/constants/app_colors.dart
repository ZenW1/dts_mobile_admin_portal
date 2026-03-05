import 'package:flutter/material.dart';

/// App color palette with support for light/dark/custom themes
class AppColors {
  AppColors._();

  // Primary colors - Deep Indigo/Violet
  // #1e3a8a, #2563eb, #3b82f6
  static const Color primary = Color(0xFF1e3a8a);
  static const Color primaryDark = Color(0xFF2563eb);
  static const Color primaryLight = Color(0xFF3b82f6);

  // Secondary colors - Cyan accent
  static const Color secondary = Color(0xFF06B6D4);
  static const Color secondaryDark = Color(0xFF0891B2);
  static const Color secondaryLight = Color(0xFF22D3EE);

  // Accent colors for gradients
  // use similar palette to primary but with more saturation and brightness
  static const Color accent1 = Color(0xFF8B5CF6);
  static const Color accent2 = Color(0xFFEC4899);
  static const Color accent3 = Color(0xFF14B8A6);

  // Neutral colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Light theme colors
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF1E293B);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightDivider = Color(0xFFF1F5F9);

  // Dark theme colors
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF334155);
  static const Color darkText = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0xFF475569);
  static const Color darkDivider = Color(0xFF334155);

  // Status colors
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Glassmorphism colors
  static Color glassWhite = Colors.white.withValues(alpha: 0.1);
  static Color glassBorder = Colors.white.withValues(alpha: 0.2);
  static Color glassOverlay = Colors.white.withValues(alpha: 0.05);

  // Gradient presets
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, accent1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, accent3],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent1, accent2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkOverlayGradient = LinearGradient(
    colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
