import 'dart:math';

import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';

import '../../../core/utils.dart';
import '../../../routes/route_names.dart';

import 'package:flutter/material.dart';

class OnboardingProvider extends BaseProvider {
  final PageController pageController = PageController();
  int currentIndex = 0;

  void onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> nextPage(BuildContext context) async {
    // Fix: Check if currentIndex is the last page (index 3 for 4 items)
    if (currentIndex < onboardingItems.length - 1) {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to Login/SignIn screen
      navigateTo(context, RouteNames.signInScreen);
    }
  }

  Future<void> skip(BuildContext context) async {
    // Navigate directly to Login/SignIn screen
    navigateTo(context, RouteNames.signInScreen);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}