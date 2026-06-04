import 'dart:async';
import 'package:flutter/material.dart';
import 'package:base_module/base_module.dart';

class AttendanceProvider extends BaseProvider {
  DateTime currentTime = DateTime.now();
  Timer? timer;

  bool isCheckedIn = false;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  String workingHours = "00:00:00";
  String location = "Office Campus";
  int lateMinutes = 5;

  // Attendance Summary
  int presentDays = 22;
  int absentDays = 1;
  int leaveDays = 2;
  int totalWorkingDays = 25;

  // Attendance History
  List<Map<String, dynamic>> attendanceHistory = [
    {"date": "Dec 15, 2024", "checkIn": "09:00 AM", "checkOut": "06:00 PM", "status": "present", "hours": "9h"},
    {"date": "Dec 14, 2024", "checkIn": "09:15 AM", "checkOut": "06:00 PM", "status": "late", "hours": "8h 45m"},
    {"date": "Dec 13, 2024", "checkIn": "09:00 AM", "checkOut": "06:00 PM", "status": "present", "hours": "9h"},
    {"date": "Dec 12, 2024", "checkIn": "--:--", "checkOut": "--:--", "status": "absent", "hours": "0h"},
    {"date": "Dec 11, 2024", "checkIn": "09:30 AM", "checkOut": "05:30 PM", "status": "late", "hours": "8h"},
    {"date": "Dec 10, 2024", "checkIn": "09:00 AM", "checkOut": "06:00 PM", "status": "present", "hours": "9h"},
    {"date": "Dec 09, 2024", "checkIn": "09:00 AM", "checkOut": "06:00 PM", "status": "present", "hours": "9h"},
    {"date": "Dec 08, 2024", "checkIn": "--:--", "checkOut": "--:--", "status": "leave", "hours": "0h"},
    {"date": "Dec 07, 2024", "checkIn": "09:00 AM", "checkOut": "06:00 PM", "status": "present", "hours": "9h"},
    {"date": "Dec 06, 2024", "checkIn": "09:00 AM", "checkOut": "06:00 PM", "status": "present", "hours": "9h"},
  ];

  void init() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      currentTime = DateTime.now();
      notifyListeners();
    });

    // Calculate working hours if checked in
    if (isCheckedIn && checkInTime != null) {
      _updateWorkingHours();
    }
  }

  void _updateWorkingHours() {
    if (checkInTime != null) {
      final now = DateTime.now();
      Duration difference = now.difference(checkInTime!);
      String hours = difference.inHours.toString().padLeft(2, '0');
      String minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
      String seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');
      workingHours = "$hours:$minutes:$seconds";
      notifyListeners();
    }
  }

  Future<void> punchIn(BuildContext context) async {
    checkInTime = DateTime.now();
    isCheckedIn = true;

    // Check if late (after 9:30 AM)
    final checkInHour = checkInTime!.hour;
    final checkInMinute = checkInTime!.minute;
    if (checkInHour > 9 || (checkInHour == 9 && checkInMinute > 30)) {
      lateMinutes = (checkInHour - 9) * 60 + (checkInMinute - 30);
      showSnackBar(context, "You are $lateMinutes minutes late!", isError: true);
    } else {
      showSnackBar(context, "Successfully Checked In", isError: false);
    }

    _updateWorkingHours();
    notifyListeners();
  }

  Future<void> punchOut(BuildContext context) async {
    checkOutTime = DateTime.now();
    isCheckedIn = false;
    _updateWorkingHours();

    showSnackBar(context, "Successfully Checked Out\nTotal Hours: $workingHours", isError: false);
    notifyListeners();
  }

  Future<void> getLocation() async {
    /// GPS API
    location = "Office Campus, Building A";
    notifyListeners();
  }

  Future<void> verifyFace(BuildContext context) async {
    /// Camera API
    showSnackBar(context, "Face verification successful", isError: false);
  }

  String getStatusColor(String status) {
    switch(status) {
      case "present": return "green";
      case "late": return "orange";
      case "absent": return "red";
      case "leave": return "blue";
      default: return "grey";
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}