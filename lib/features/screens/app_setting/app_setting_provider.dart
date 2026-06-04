// lib/features/settings/providers/settings_provider.dart

import 'package:base_module/providers/base_providers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsProvider extends BaseProvider {
  // Theme Settings
  String _themeMode = "system"; // light, dark, system
  String get themeMode => _themeMode;

  // Language Settings
  String _language = "en"; // en, hi, gu
  String get language => _language;

  // Notification Settings
  bool _pushNotifications = true;
  bool get pushNotifications => _pushNotifications;

  bool _emailNotifications = true;
  bool get emailNotifications => _emailNotifications;

  bool _meetingReminders = true;
  bool get meetingReminders => _meetingReminders;

  bool _taskReminders = true;
  bool get taskReminders => _taskReminders;

  bool _attendanceReminders = true;
  bool get attendanceReminders => _attendanceReminders;

  // Security Settings
  bool _biometricLogin = false;
  bool get biometricLogin => _biometricLogin;

  bool _twoFactorAuth = false;
  bool get twoFactorAuth => _twoFactorAuth;

  // Privacy Settings
  bool _shareAnalytics = true;
  bool get shareAnalytics => _shareAnalytics;

  // Data Settings
  String _imageQuality = "high"; // high, medium, low
  String get imageQuality => _imageQuality;

  bool _autoDownloadMedia = false;
  bool get autoDownloadMedia => _autoDownloadMedia;

  // Cache
  double _cacheSize = 125.5; // MB
  double get cacheSize => _cacheSize;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _language = prefs.getString('language') ?? "en";
    _pushNotifications = prefs.getBool('push_notifications') ?? true;
    _emailNotifications = prefs.getBool('email_notifications') ?? true;
    _meetingReminders = prefs.getBool('meeting_reminders') ?? true;
    _taskReminders = prefs.getBool('task_reminders') ?? true;
    _attendanceReminders = prefs.getBool('attendance_reminders') ?? true;
    _biometricLogin = prefs.getBool('biometric_login') ?? false;
    _twoFactorAuth = prefs.getBool('two_factor_auth') ?? false;
    _shareAnalytics = prefs.getBool('share_analytics') ?? true;
    _imageQuality = prefs.getString('image_quality') ?? "high";
    _autoDownloadMedia = prefs.getBool('auto_download_media') ?? false;

    notifyListeners();
  }


  Future<void> setLanguage(String langCode) async {
    _language = langCode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', langCode);
    notifyListeners();
  }

  Future<void> setPushNotifications(bool value) async {
    _pushNotifications = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('push_notifications', value);
    notifyListeners();
  }

  Future<void> setEmailNotifications(bool value) async {
    _emailNotifications = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('email_notifications', value);
    notifyListeners();
  }

  Future<void> setMeetingReminders(bool value) async {
    _meetingReminders = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('meeting_reminders', value);
    notifyListeners();
  }

  Future<void> setTaskReminders(bool value) async {
    _taskReminders = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('task_reminders', value);
    notifyListeners();
  }

  Future<void> setAttendanceReminders(bool value) async {
    _attendanceReminders = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('attendance_reminders', value);
    notifyListeners();
  }

  Future<void> setBiometricLogin(bool value) async {
    _biometricLogin = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometric_login', value);
    notifyListeners();
  }

  Future<void> setTwoFactorAuth(bool value) async {
    _twoFactorAuth = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('two_factor_auth', value);
    notifyListeners();
  }

  Future<void> setShareAnalytics(bool value) async {
    _shareAnalytics = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('share_analytics', value);
    notifyListeners();
  }

  Future<void> setImageQuality(String quality) async {
    _imageQuality = quality;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('image_quality', quality);
    notifyListeners();
  }

  Future<void> setAutoDownloadMedia(bool value) async {
    _autoDownloadMedia = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('auto_download_media', value);
    notifyListeners();
  }

  Future<void> clearCache() async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    _cacheSize = 0;
    setLoading(false);
    notifyListeners();
  }
}