import 'package:flutter/material.dart';

class AppColors {
  // Brand
  static const Color primary = Color(0xFF2563EB);
  static const Color secondary = Color(0xFF4F46E5);

  // Status
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // Light Theme
  static const lightBackground = Color(0xFFF8F9FD);
  static const lightCard = Colors.white;
  static const Color lightSurface = Colors.white;

  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);

  // Dark Theme
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);

  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
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
