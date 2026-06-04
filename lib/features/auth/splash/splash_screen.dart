import 'package:flutter/material.dart';
import 'package:hrms_app/widget/help_widget.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_icons.dart';
import 'splash_provider.dart';
import '../../../core/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin { // Changed from SingleTickerProviderStateMixin

  late SplashProvider _animationProvider;

  @override
  void initState() {
    super.initState();
    _animationProvider = SplashProvider();
    _animationProvider.init(context, this); // Now this works with multiple tickers
  }

  @override
  void dispose() {
    _animationProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;

    return ChangeNotifierProvider.value(
      value: _animationProvider,
      child: Consumer<SplashProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: isDarkMode
                    ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey[900]!,
                    Colors.grey[850]!,
                    Colors.black,
                  ],
                )
                    : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue[700]!,
                    Colors.blue[500]!,
                    Colors.blue[300]!,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Animated background circles
                  _buildAnimatedCircles(isDarkMode, screenSize, provider),

                  // Main content
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo - STATIC, no animation
                        _buildLogo(isDarkMode, provider),
                        const SizedBox(height: 30),
                        _buildTitle(provider, isDarkMode),
                        const SizedBox(height: 20),
                        _buildSubtitle(provider, isDarkMode),
                      ],
                    ),
                  ),

                  // Loading indicator
                  if (provider.isLoading)
                    _buildLoadingIndicator(provider, isDarkMode),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedCircles(bool isDarkMode, Size screenSize, SplashProvider provider) {
    return Stack(
      children: [
        // Circle 1
        Positioned(
          left: provider.getCircle1Position(screenSize).dx,
          top: provider.getCircle1Position(screenSize).dy,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  provider.getCircleColor(isDarkMode, 1),
                  provider.getCircleColor(isDarkMode, 1).withOpacity(0.05),
                ],
              ),
            ),
          ),
        ),

        // Circle 2
        Positioned(
          left: provider.getCircle2Position(screenSize).dx,
          top: provider.getCircle2Position(screenSize).dy,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  provider.getCircleColor(isDarkMode, 2),
                  provider.getCircleColor(isDarkMode, 2).withOpacity(0.05),
                ],
              ),
            ),
          ),
        ),

        // Circle 3
        Positioned(
          left: provider.getCircle3Position(screenSize).dx,
          top: provider.getCircle3Position(screenSize).dy,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  provider.getCircleColor(isDarkMode, 3),
                  provider.getCircleColor(isDarkMode, 3).withOpacity(0.05),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo(bool isDarkMode, SplashProvider provider) {
    // Static logo with fade-in only, no movement
    return FadeTransition(
      opacity: provider.fadeAnimation,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: (isDarkMode ? Colors.blue : Colors.white).withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Image.asset(
          AppIcons.appIcon,
          width: 120,
          height: 120,
          color: isDarkMode ? Colors.blue[300] : null,
        ),
      ),
    );
  }

  Widget _buildTitle(SplashProvider provider, bool isDarkMode) {
    return FadeTransition(
      opacity: provider.fadeAnimation,
      child: SlideTransition(
        position: provider.getTitleAnimation(),
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: isDarkMode
                ? [Colors.blue[300]!, Colors.blue[100]!]
                : [Colors.white, Colors.white70],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            "HRMS",
            style: GoogleFonts.poppins(
              fontSize: 62,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitle(SplashProvider provider, bool isDarkMode) {
    return FadeTransition(
      opacity: provider.fadeAnimation,
      child: SlideTransition(
        position: provider.getSubtitleAnimation(),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            "Employee Management Platform",
            style: TextStyle(
              color: isDarkMode
                  ? Colors.white70
                  : Colors.white.withOpacity(0.9),
              fontSize: 16,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(SplashProvider provider, bool isDarkMode) {
    return Positioned(
      bottom: 50,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 2,
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.2)
                  : Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: provider.progressAnimation.value,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isDarkMode ? Colors.blue[300]! : Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Loading...",
            style: TextStyle(
              color: isDarkMode
                  ? Colors.white54
                  : Colors.white70,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}