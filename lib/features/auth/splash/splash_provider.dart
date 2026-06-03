import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:base_module/providers/base_providers.dart';

import '../../../routes/route_names.dart';

import 'package:flutter/material.dart';

class SplashProvider extends BaseProvider {
  late AnimationController controller;

  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<double> rotationAnimation;
  late Animation<double> glowAnimation;

  void init(TickerProvider vsync) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 4),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0, .4)),
    );

    scaleAnimation = Tween<double>(
      begin: .6,
      end: 1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));

    rotationAnimation = Tween<double>(
      begin: -0.05,
      end: 0.05,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    glowAnimation = Tween<double>(
      begin: 10,
      end: 35,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    controller.repeat(reverse: true);
  }

  Future<void> startApp(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4));
    navigateTo(context, RouteNames.onBoardingScreen);
  }

  void disposeController() {
    controller.dispose();
  }
}
