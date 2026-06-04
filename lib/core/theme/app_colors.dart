import 'package:flutter/material.dart';

// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Light Mode Colors
  static const Color lightPrimary = Color(0xFF2563EB);
  static const Color lightSecondary = Color(0xFF3B82F6);
  static const Color lightTertiary = Color(0xFF60A5FA);
  static const Color lightBackground = Color(0xFFF3F4F6);
  static const Color lightSurface = Colors.white;
  static const Color lightText = Color(0xFF1F2937);
  static const Color lightTextSecondary = Color(0xFF6B7280);

  // Dark Mode Colors
  static const Color darkPrimary = Color(0xFF3B82F6);
  static const Color darkSecondary = Color(0xFF60A5FA);
  static const Color darkTertiary = Color(0xFF93C5FD);
  static const Color darkBackground = Color(0xFF111827);
  static const Color darkSurface = Color(0xFF1F2937);
  static const Color darkText = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);

  // Splash Screen Gradients
  static const List<Color> lightSplashGradient = [
    Color(0xFF2563EB),
    Color(0xFF3B82F6),
    Color(0xFF60A5FA),
  ];

  static const List<Color> darkSplashGradient = [
    Color(0xFF1F2937),
    Color(0xFF111827),
    Color(0xFF000000),
  ];

  static get primary => null;

  static get secondary => null;

  // Circle Colors for Splash Screen
  static Color getCircle1Color(bool isDarkMode) {
    return isDarkMode ? Colors.blue[800]! : Colors.white;
  }

  static Color getCircle2Color(bool isDarkMode) {
    return isDarkMode ? Colors.cyan[800]! : AppColors.lightSecondary;
  }

  static Color getCircle3Color(bool isDarkMode) {
    return isDarkMode ? Colors.purple[800]! : AppColors.lightTertiary;
  }
}
extension AppThemeExtension on BuildContext {
  bool get isDark =>
      Theme.of(this).brightness ==
          Brightness.dark;

  Color get cardColor =>
      isDark
          ? const Color(0xFF1E293B)
          : Colors.white;

  Color get bgColor =>
      isDark
          ? const Color(0xFF0F172A)
          : const Color(0xFFF8F9FD);
}
