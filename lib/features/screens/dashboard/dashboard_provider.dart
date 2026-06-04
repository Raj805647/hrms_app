import 'dart:async';

import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardProvider extends BaseProvider {
  DateTime currentTime = DateTime.now();
  Timer? timer;

  // Attendance Status
  String attendanceStatus = "Not Punched In";
  DateTime? punchInTime;
  DateTime? punchOutTime;
  bool isPunchedIn = false;

  // Today's Tasks
  List<Map<String, dynamic>> todayTasks = [
    {"title": "Complete HR report", "isCompleted": false, "priority": "high"},
    {"title": "Review leave requests", "isCompleted": false, "priority": "medium"},
    {"title": "Team meeting", "isCompleted": true, "priority": "low"},
    {"title": "Update employee records", "isCompleted": false, "priority": "high"},
  ];

  // Upcoming Holidays
  List<Map<String, dynamic>> upcomingHolidays = [
    {"name": "Republic Day", "date": "Jan 26, 2025", "day": "Sunday"},
    {"name": "Holi", "date": "Mar 14, 2025", "day": "Friday"},
    {"name": "Independence Day", "date": "Aug 15, 2025", "day": "Friday"},
    {"name": "Diwali", "date": "Nov 12, 2025", "day": "Wednesday"},
  ];

  // Notices/Announcements
  List<Map<String, dynamic>> announcements = [
    {"title": "Annual Performance Review", "date": "Dec 15, 2024", "priority": "high", "description": "Submit your self-assessment by Dec 20"},
    {"title": "Office Holiday Schedule", "date": "Dec 10, 2024", "priority": "medium", "description": "Office will remain closed from Dec 25 to Jan 1"},
    {"title": "New HR Policy Update", "date": "Dec 5, 2024", "priority": "low", "description": "Updated work from home policy effective Jan 2025"},
  ];

  // Pending Leave Requests
  List<Map<String, dynamic>> pendingLeaveRequests = [
    {"employee": "Sarah Johnson", "type": "Sick Leave", "days": 2, "status": "pending", "date": "Dec 20-21"},
    {"employee": "Michael Chen", "type": "Casual Leave", "days": 1, "status": "pending", "date": "Dec 23"},
    {"employee": "Priya Sharma", "type": "Annual Leave", "days": 5, "status": "approved", "date": "Dec 27-31"},
  ];

  // Quick Actions
  final List<Map<String, dynamic>> quickActions = [
    {"title": "Attendance", "icon": Icons.fingerprint_rounded, "route": "attendance"},
    {"title": "Apply Leave", "icon": Icons.event_available_rounded, "route": "leave"},
    {"title": "My Tasks", "icon": Icons.task_alt_rounded, "route": "tasks"},
    {"title": "Team Chat", "icon": Icons.chat_rounded, "route": "chat"},
    {"title": "Join Meeting", "icon": Icons.video_call_rounded, "route": "meeting"},
    {"title": "Notice Board", "icon": Icons.campaign_rounded, "route": "notices"},
  ];

  // Statistics
  double attendancePercentage = 94.5;
  int leavesTaken = 8;
  int totalLeaves = 18;
  int completedTasks = 12;
  int totalTasks = 18;

  void init() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      currentTime = DateTime.now();
      notifyListeners();
    });
  }

  void toggleTaskCompletion(int index) {
    todayTasks[index]['isCompleted'] = !todayTasks[index]['isCompleted'];
    notifyListeners();
  }

  int get pendingLeavesCount {
    return pendingLeaveRequests.where((leave) => leave['status'] == 'pending').length;
  }

  int get upcomingHolidaysCount {
    return upcomingHolidays.length;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}