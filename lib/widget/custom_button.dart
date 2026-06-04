import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import 'help_widget.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;

  const AppButton({
    super.key,
    required this.title,
    this.icon,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: isOutlined
          ? ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: themeManager.primary,
        elevation: 0,
        side: BorderSide(color: themeManager.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      )
          : ElevatedButton.styleFrom(
        backgroundColor: themeManager.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: isLoading
            ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: isOutlined ? themeManager.primary : Colors.white,
              ),
            )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(icon, size: 18),
            ],
          ],
        ),
      ),
    );
  }
}