import 'dart:async';

import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends BaseProvider {
  DateTime currentTime = DateTime.now();

  Timer? timer;

  final List<Map<String, dynamic>> quickActions = [
    {
      "title": "Attendance",
      "icon": Icons.fingerprint_rounded,
    },
    {
      "title": "Leave",
      "icon": Icons.event_available_rounded,
    },
    {
      "title": "Tasks",
      "icon": Icons.task_alt_rounded,
    },
    {
      "title": "Chat",
      "icon": Icons.chat_rounded,
    },
    {
      "title": "Meeting",
      "icon": Icons.video_call_rounded,
    },
    {
      "title": "Notice",
      "icon": Icons.campaign_rounded,
    },
  ];

  void init() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) {
        currentTime = DateTime.now();
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
