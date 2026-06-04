import 'package:flutter/material.dart';
import 'app_colors.dart';

// lib/core/theme/theme_manager.dart
import 'package:flutter/material.dart';

// lib/core/theme/theme_manager.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  // Colors for both themes
  Color get primary => isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary;
  Color get secondary => isDarkMode ? AppColors.darkSecondary : AppColors.lightSecondary;
  Color get tertiary => isDarkMode ? AppColors.darkTertiary : AppColors.lightTertiary;
  Color get background => isDarkMode ? AppColors.darkBackground : AppColors.lightBackground;
  Color get surface => isDarkMode ? AppColors.darkSurface : AppColors.lightSurface;
  Color get text => isDarkMode ? AppColors.darkText : AppColors.lightText;
  Color get textSecondary => isDarkMode ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

  List<Color> get splashGradient => isDarkMode
      ? AppColors.darkSplashGradient
      : AppColors.lightSplashGradient;

  List<Color> get textGradient => isDarkMode
      ? [AppColors.darkSecondary, AppColors.darkTertiary]
      : [Colors.white, Colors.white70];

  ThemeManager() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('theme_mode') ?? 'system';
    setThemeMode(themeModeString);
  }

  Future<void> setThemeMode(String mode) async {
    switch(mode) {
      case 'light':
        _themeMode = ThemeMode.light;
        _isDarkMode = false;
        break;
      case 'dark':
        _themeMode = ThemeMode.dark;
        _isDarkMode = true;
        break;
      case 'system':
        _themeMode = ThemeMode.system;
        // Check system brightness
        final brightness = WidgetsBinding.instance.window.platformBrightness;
        _isDarkMode = brightness == Brightness.dark;
        break;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode);
    notifyListeners();
  }

  void updateSystemTheme(Brightness brightness) {
    if (_themeMode == ThemeMode.system) {
      final newIsDarkMode = brightness == Brightness.dark;
      if (_isDarkMode != newIsDarkMode) {
        _isDarkMode = newIsDarkMode;
        notifyListeners();
      }
    }
  }

  String getCurrentThemeMode() {
    switch(_themeMode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}