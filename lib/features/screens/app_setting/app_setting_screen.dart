// lib/features/settings/screens/app_settings_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widget/help_widget.dart';
import 'app_setting_provider.dart';

class AppSettingScreen extends StatefulWidget {
  const AppSettingScreen({super.key});

  @override
  State<AppSettingScreen> createState() => _AppSettingScreenState();
}

class _AppSettingScreenState extends State<AppSettingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppSettingsProvider>().loadSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Consumer<AppSettingsProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: buildProfileAppBar(isLeading: true, context: context, title: 'Settings'),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildProfileSection(themeManager, provider),
                _buildAppearanceSection(themeManager, provider),
                _buildLanguageSection(themeManager, provider),
                _buildNotificationsSection(themeManager, provider),
                _buildSecuritySection(themeManager, provider),
                _buildDataSection(themeManager, provider),
                _buildPrivacySection(themeManager, provider),
                _buildAboutSection(themeManager),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileSection(ThemeManager themeManager, AppSettingsProvider provider) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeManager.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: themeManager.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.person, color: themeManager.primary, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "John Doe",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeManager.text,
                  ),
                ),
                Text(
                  "john.doe@company.com",
                  style: TextStyle(color: themeManager.textSecondary),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chevron_right, color: themeManager.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildAppearanceSection(ThemeManager themeManager, AppSettingsProvider provider) {
    return _buildSection(
      title: "Appearance",
      icon: Icons.palette,
      children: [
        _buildRadioOption(
          title: "Light Mode",
          value: "light",
          groupValue: themeManager.getCurrentThemeMode(),
          onChanged: (v) {
            if (v != null) {
              themeManager.setThemeMode(v);
            }
          },
          themeManager: themeManager,
        ),

        _buildRadioOption(
          title: "Dark Mode",
          value: "dark",
          groupValue: themeManager.getCurrentThemeMode(),
          onChanged: (v) {
            if (v != null) {
              themeManager.setThemeMode(v);
            }
          },
          themeManager: themeManager,
        ),
      ],
      themeManager: themeManager,
    );
  }

  Widget _buildLanguageSection(ThemeManager themeManager, AppSettingsProvider provider) {
    return _buildSection(
      title: "Language",
      icon: Icons.language,
      children: [
        _buildRadioOption(
          title: "English",
          value: "en",
          groupValue: provider.language,
          onChanged: (v) => provider.setLanguage(v!),
          themeManager: themeManager,
        ),
        _buildRadioOption(
          title: "हिंदी (Hindi)",
          value: "hi",
          groupValue: provider.language,
          onChanged: (v) => provider.setLanguage(v!),
          themeManager: themeManager,
        ),
        _buildRadioOption(
          title: "ગુજરાતી (Gujarati)",
          value: "gu",
          groupValue: provider.language,
          onChanged: (v) => provider.setLanguage(v!),
          themeManager: themeManager,
        ),
      ],
      themeManager: themeManager,
    );
  }

  Widget _buildNotificationsSection(ThemeManager themeManager, AppSettingsProvider provider) {
    return _buildSection(
      title: "Notifications",
      icon: Icons.notifications,
      children: [
        _buildSwitchTile(
          title: "Push Notifications",
          value: provider.pushNotifications,
          onChanged: (v) => provider.setPushNotifications(v),
          themeManager: themeManager,
        ),
        _buildSwitchTile(
          title: "Email Notifications",
          value: provider.emailNotifications,
          onChanged: (v) => provider.setEmailNotifications(v),
          themeManager: themeManager,
        ),
        _buildSwitchTile(
          title: "Meeting Reminders",
          value: provider.meetingReminders,
          onChanged: (v) => provider.setMeetingReminders(v),
          themeManager: themeManager,
        ),
        _buildSwitchTile(
          title: "Task Reminders",
          value: provider.taskReminders,
          onChanged: (v) => provider.setTaskReminders(v),
          themeManager: themeManager,
        ),
        _buildSwitchTile(
          title: "Attendance Reminders",
          value: provider.attendanceReminders,
          onChanged: (v) => provider.setAttendanceReminders(v),
          themeManager: themeManager,
        ),
      ],
      themeManager: themeManager,
    );
  }

  Widget _buildSecuritySection(ThemeManager themeManager, AppSettingsProvider provider) {
    return _buildSection(
      title: "Security",
      icon: Icons.security,
      children: [
        _buildSwitchTile(
          title: "Biometric Login",
          subtitle: "Use fingerprint/face to login",
          value: provider.biometricLogin,
          onChanged: (v) => provider.setBiometricLogin(v),
          themeManager: themeManager,
        ),
        _buildSwitchTile(
          title: "Two-Factor Authentication",
          subtitle: "Add extra security layer",
          value: provider.twoFactorAuth,
          onChanged: (v) => provider.setTwoFactorAuth(v),
          themeManager: themeManager,
        ),
        _buildListTile(
          title: "Change Password",
          icon: Icons.lock_outline,
          onTap: () {},
          themeManager: themeManager,
        ),
      ],
      themeManager: themeManager,
    );
  }

  Widget _buildDataSection(ThemeManager themeManager, AppSettingsProvider provider) {
    return _buildSection(
      title: "Data & Storage",
      icon: Icons.storage,
      children: [
        _buildDropdownOption(
          title: "Image Quality",
          value: provider.imageQuality,
          items: [
            {"value": "high", "label": "High"},
            {"value": "medium", "label": "Medium"},
            {"value": "low", "label": "Low"},
          ],
          onChanged: (v) => provider.setImageQuality(v),
          themeManager: themeManager,
        ),
        _buildSwitchTile(
          title: "Auto-download Media",
          value: provider.autoDownloadMedia,
          onChanged: (v) => provider.setAutoDownloadMedia(v),
          themeManager: themeManager,
        ),
        _buildListTile(
          title: "Clear Cache",
          subtitle: "${provider.cacheSize.toStringAsFixed(1)} MB",
          icon: Icons.cleaning_services,
          onTap: () => _showClearCacheDialog(context, provider),
          themeManager: themeManager,
        ),
      ],
      themeManager: themeManager,
    );
  }

  Widget _buildPrivacySection(ThemeManager themeManager, AppSettingsProvider provider) {
    return _buildSection(
      title: "Privacy",
      icon: Icons.privacy_tip,
      children: [
        _buildSwitchTile(
          title: "Share Analytics",
          subtitle: "Help improve the app",
          value: provider.shareAnalytics,
          onChanged: (v) => provider.setShareAnalytics(v),
          themeManager: themeManager,
        ),
        _buildListTile(
          title: "Privacy Policy",
          icon: Icons.description,
          onTap: () {},
          themeManager: themeManager,
        ),
        _buildListTile(
          title: "Terms of Service",
          icon: Icons.gavel,
          onTap: () {},
          themeManager: themeManager,
        ),
      ],
      themeManager: themeManager,
    );
  }

  Widget _buildAboutSection(ThemeManager themeManager) {
    return _buildSection(
      title: "About",
      icon: Icons.info,
      children: [
        _buildListTile(
          title: "Version",
          trailing: "1.0.0",
          icon: Icons.code,
          themeManager: themeManager,
        ),
        _buildListTile(
          title: "Rate the App",
          icon: Icons.star,
          onTap: () {},
          themeManager: themeManager,
        ),
        _buildListTile(
          title: "Share App",
          icon: Icons.share,
          onTap: () {},
          themeManager: themeManager,
        ),
      ],
      themeManager: themeManager,
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
    required ThemeManager themeManager,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: themeManager.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: themeManager.primary),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeManager.text,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
    String? subtitle,
    required ThemeManager themeManager,
  }) {
    return SwitchListTile(
      title: Text(title, style: TextStyle(color: themeManager.text)),
      subtitle: subtitle != null ? Text(subtitle, style: TextStyle(color: themeManager.textSecondary)) : null,
      value: value,
      onChanged: onChanged,
      activeColor: themeManager.primary,
    );
  }

  Widget _buildRadioOption({
    required String title,
    required String value,
    required String groupValue,
    required Function(String?) onChanged,
    required ThemeManager themeManager,
  }) {
    return RadioListTile<String>(
      title: Text(title, style: TextStyle(color: themeManager.text)),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: themeManager.primary,
    );
  }

  Widget _buildListTile({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
    String? subtitle,
    String? trailing,
    required ThemeManager themeManager,
  }) {
    return ListTile(
      leading: Icon(icon, color: themeManager.primary),
      title: Text(title, style: TextStyle(color: themeManager.text)),
      subtitle: subtitle != null ? Text(subtitle, style: TextStyle(color: themeManager.textSecondary)) : null,
      trailing: trailing != null
          ? Text(trailing, style: TextStyle(color: themeManager.textSecondary))
          : onTap != null
          ? Icon(Icons.chevron_right, color: themeManager.textSecondary)
          : null,
      onTap: onTap,
    );
  }

  Widget _buildDropdownOption({
    required String title,
    required String value,
    required List<Map<String, String>> items,
    required Function(String) onChanged,
    required ThemeManager themeManager,
  }) {
    return ListTile(
      leading: Icon(Icons.image, color: themeManager.primary),
      title: Text(title, style: TextStyle(color: themeManager.text)),
      trailing: DropdownButton<String>(
        value: value,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item['value'],
            child: Text(item['label']!),
          );
        }).toList(),
        onChanged: (v) => onChanged(v!),
        dropdownColor: themeManager.surface,
        underline: const SizedBox(),
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context, AppSettingsProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Clear Cache"),
        content: const Text("This will clear all cached data. Are you sure?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              provider.clearCache();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text("Clear"),
          ),
        ],
      ),
    );
  }
}