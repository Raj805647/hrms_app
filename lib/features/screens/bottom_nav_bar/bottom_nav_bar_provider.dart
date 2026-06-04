import 'package:base_module/base_module.dart';

import 'package:flutter/material.dart';

class BottomNavBarProvider extends BaseProvider {
  int currentIndex = 0;

  // Optional: Track previous index for animation
  int previousIndex = 0;

  void changeIndex(int index) {
    if (currentIndex != index) {
      previousIndex = currentIndex;
      currentIndex = index;
      notifyListeners();
    }
  }
}