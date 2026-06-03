import 'dart:async';
import 'package:flutter/material.dart';
import 'package:base_module/base_module.dart';


class AttendanceProvider extends BaseProvider{
  DateTime currentTime = DateTime.now();

  Timer? timer;

  bool isCheckedIn = false;

  String workingHours = "00:00:00";

  String location = "Office Campus";

  int lateMinutes = 5;

  void init() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) {
        currentTime = DateTime.now();
        notifyListeners();
      },
    );
  }

  Future<void> punchIn(
      BuildContext context,
      ) async {
    isCheckedIn = true;
    notifyListeners();

    showSnackBar(
      context,
      "Successfully Checked In",
      isError: false,
    );
  }

  Future<void> punchOut(
      BuildContext context,
      ) async {
    isCheckedIn = false;
    notifyListeners();

    showSnackBar(
      context,
      "Successfully Checked Out",
      isError: false,
    );
  }

  Future<void> getLocation() async {
    /// GPS API
  }

  Future<void> verifyFace() async {
    /// Camera API
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}