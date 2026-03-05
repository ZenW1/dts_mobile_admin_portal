import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';

/// Responsive layout helper widget
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  /// Check if current screen is mobile
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;

  /// Check if current screen is tablet
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppSpacing.mobileBreakpoint &&
      MediaQuery.of(context).size.width < AppSpacing.desktopBreakpoint;

  /// Check if current screen is desktop
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppSpacing.desktopBreakpoint;

  /// Get responsive value based on screen size
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) return desktop ?? tablet ?? mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return mobile;
  }

  /// Get responsive grid columns
  static int gridColumns(BuildContext context) {
    if (isDesktop(context)) return 4;
    if (isTablet(context)) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= AppSpacing.desktopBreakpoint) {
      return desktop ?? tablet ?? mobile;
    }

    if (width >= AppSpacing.mobileBreakpoint) {
      return tablet ?? mobile;
    }

    return mobile;
  }
}

/// Responsive builder for more granular control
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return builder(
          context,
          constraints,
          ResponsiveLayout.isMobile(context),
          ResponsiveLayout.isTablet(context),
          ResponsiveLayout.isDesktop(context),
        );
      },
    );
  }
}
