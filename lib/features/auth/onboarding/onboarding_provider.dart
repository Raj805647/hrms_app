import 'dart:math';

import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';

import '../../../core/utils.dart';
import '../../../routes/route_names.dart';

class OnboardingProvider extends BaseProvider {
  final PageController pageController = PageController();

  int currentIndex = 0;

  void onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> nextPage(BuildContext context) async {
    if (currentIndex < 4) {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      /// Navigate Login
      navigateTo(context, RouteNames.signInScreen);
    }
  }

  Future<void> skip() async {
    /// Navigate Login
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
