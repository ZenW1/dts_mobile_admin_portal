import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Theme mode enum with custom option
enum AppThemeMode { light, dark, system, custom }

/// Theme state class
class ThemeState {
  final AppThemeMode mode;
  final Color? customPrimaryColor;
  final Color? customAccentColor;

  const ThemeState({
    this.mode = AppThemeMode.system,
    this.customPrimaryColor,
    this.customAccentColor,
  });

  ThemeState copyWith({
    AppThemeMode? mode,
    Color? customPrimaryColor,
    Color? customAccentColor,
  }) {
    return ThemeState(
      mode: mode ?? this.mode,
      customPrimaryColor: customPrimaryColor ?? this.customPrimaryColor,
      customAccentColor: customAccentColor ?? this.customAccentColor,
    );
  }

  /// Get the Flutter ThemeMode based on current AppThemeMode
  ThemeMode get themeMode {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
      case AppThemeMode.custom:
        return ThemeMode.system;
    }
  }
}

/// Theme notifier for managing theme state
class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(const ThemeState());

  /// Set theme mode
  void setThemeMode(AppThemeMode mode) {
    state = state.copyWith(mode: mode);
  }

  /// Toggle between light and dark mode
  void toggleTheme() {
    if (state.mode == AppThemeMode.light) {
      state = state.copyWith(mode: AppThemeMode.dark);
    } else {
      state = state.copyWith(mode: AppThemeMode.light);
    }
  }

  /// Set custom colors
  void setCustomColors({Color? primary, Color? accent}) {
    state = state.copyWith(
      mode: AppThemeMode.custom,
      customPrimaryColor: primary,
      customAccentColor: accent,
    );
  }
}

/// Theme provider
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

/// Convenience provider for getting ThemeMode
final themeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(themeProvider).themeMode;
});

/// Provider to check if dark mode is active
final isDarkModeProvider = Provider<bool>((ref) {
  final mode = ref.watch(themeProvider).mode;
  return mode == AppThemeMode.dark;
});
