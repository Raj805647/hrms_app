import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';

SizedBox spaceHeight(double height) {
  return SizedBox(height: height);
}

SizedBox spaceWidth(double width) {
  return SizedBox(width: width);
}


AppBar buildProfileAppBar({
  required BuildContext context,
  required String title,
  List<Widget>? action,
  bool isLeading = false,
}) {
  final themeManager = Provider.of<ThemeManager>(context, listen: false);

  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    automaticallyImplyLeading: isLeading,
    centerTitle: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [themeManager.primary, themeManager.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
    ),
    actions: action ?? null,
  );
}