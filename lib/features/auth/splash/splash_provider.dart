import 'dart:async';
import 'dart:math';
import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/routes/route_names.dart';


class SplashProvider extends BaseProvider {
  // Animation Controllers
  late AnimationController _mainController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _progressAnimation;

  // Separate animation controllers for background circles
  late AnimationController _circle1Controller;
  late AnimationController _circle2Controller;
  late AnimationController _circle3Controller;

  // Getters for animations
  Animation<double> get fadeAnimation => _fadeAnimation;
  Animation<Offset> get slideAnimation => _slideAnimation;
  Animation<double> get progressAnimation => _progressAnimation;

  // Circle animation values
  double _circle1Value = 0;
  double _circle2Value = 0;
  double _circle3Value = 0;

  double get circle1Value => _circle1Value;
  double get circle2Value => _circle2Value;
  double get circle3Value => _circle3Value;

  // Loading state
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  // Ticker provider for animation
  late TickerProvider _vsync;

  void init(BuildContext context, TickerProvider vsync) {
    _vsync = vsync;
    _initializeAnimations();
    Future.delayed(Duration(seconds: 3),()=> navigateAndClearStack(context, RouteNames.onBoardingScreen) );
  }

  void _initializeAnimations() {
    // Main animation controller
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: _vsync, // Using the same vsync for all controllers
    );

    // Background circle controllers
    _circle1Controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: _vsync, // Same vsync
    );

    _circle2Controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: _vsync, // Same vsync
    );

    _circle3Controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: _vsync, // Same vsync
    );

    // Core animations (no logo movement)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Progress animation for loading bar
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    // Listen to circle animation updates
    _circle1Controller.addListener(() {
      _circle1Value = _circle1Controller.value;
      notifyListeners();
    });

    _circle2Controller.addListener(() {
      _circle2Value = _circle2Controller.value;
      notifyListeners();
    });

    _circle3Controller.addListener(() {
      _circle3Value = _circle3Controller.value;
      notifyListeners();
    });

    // Start background circle animations
    _circle1Controller.forward();
    _circle2Controller.forward();
    _circle3Controller.forward();

    // Start main animation
    _mainController.forward();

    // Simulate loading process
    _simulateLoading();
  }

  void _simulateLoading() {
    // Simulate loading process (4 seconds)
    Future.delayed(const Duration(seconds: 3), () {
      _isLoading = false;
      notifyListeners();
    });
  }

  // Get color based on theme and animation value
  Color getCircleColor(bool isDarkMode, int circleNumber) {
    switch(circleNumber) {
      case 1:
        return (isDarkMode ? Colors.blue[800]! : Colors.white)
            .withOpacity(0.1 + (_circle1Value * 0.05));
      case 2:
        return (isDarkMode ? Colors.cyan[800]! : Colors.blue.shade200)
            .withOpacity(0.1 + (_circle2Value * 0.05));
      case 3:
        return (isDarkMode ? Colors.purple[800]! : Colors.blue.shade300)
            .withOpacity(0.1 + (_circle3Value * 0.05));
      default:
        return Colors.transparent;
    }
  }

  // Get circle positions based on animation
  Offset getCircle1Position(Size screenSize) {
    return Offset(
      -50 - (_circle1Value * 30),
      -50 + (_circle1Value * 20),
    );
  }

  Offset getCircle2Position(Size screenSize) {
    return Offset(
      screenSize.width - 50 - (_circle2Value * 50),
      screenSize.height - 100 + (_circle2Value * 30),
    );
  }

  Offset getCircle3Position(Size screenSize) {
    return Offset(
      screenSize.width - 50 + (_circle3Value * 30),
      screenSize.height * 0.5 - 100 + (_circle3Value * 40),
    );
  }

  // Get title animation (moves up slightly)
  Animation<Offset> getTitleAnimation() {
    return Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.2, 0.5, curve: Curves.easeOut),
    ));
  }

  // Get subtitle animation
  Animation<Offset> getSubtitleAnimation() {
    return Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.4, 0.7, curve: Curves.easeOut),
    ));
  }

  // Clean up resources
  @override
  void dispose() {
    _mainController.dispose();
    _circle1Controller.dispose();
    _circle2Controller.dispose();
    _circle3Controller.dispose();
    super.dispose();
  }
}