import 'package:flutter/material.dart';
import 'package:hrms_app/widget/help_widget.dart';
import 'package:provider/provider.dart';
import 'splash_provider.dart';
import '../../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

    final provider = context.read<SplashProvider>();

    provider.init(this);
    provider.startApp(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Consumer<SplashProvider>(
        builder: (_, provider, __) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary, AppColors.secondary],
                ),
              ),
              child: Center(
                child: AnimatedBuilder(
                  animation: provider.controller,
                  builder: (_, __) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [

                        Positioned(
                          top: 120,
                          left: -40,
                          child: Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(.08),
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 100,
                          right: -50,
                          child: Container(
                            height: 220,
                            width: 220,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(.06),
                            ),
                          ),
                        ),

                        FadeTransition(
                          opacity: provider.fadeAnimation,
                          child: Transform.rotate(
                            angle: provider.rotationAnimation.value,
                            child: ScaleTransition(
                              scale: provider.scaleAnimation,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(36),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(.4),
                                          blurRadius: provider.glowAnimation.value,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.groups_rounded,
                                      size: 70,
                                      color: AppColors.primary,
                                    ),
                                  ),

                                  const SizedBox(height: 30),

                                  ShaderMask(
                                    shaderCallback: (bounds) {
                                      return const LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Color(0xFFE0E7FF),
                                        ],
                                      ).createShader(bounds);
                                    },
                                    child: const Text(
                                      "HRMS",
                                      style: TextStyle(
                                        fontSize: 42,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    "Employee Management Platform",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.8),
                                      fontSize: 15,
                                      letterSpacing: 1,
                                    ),
                                  ),

                                  const SizedBox(height: 50),

                                  SizedBox(
                                    width: 180,
                                    child: LinearProgressIndicator(
                                      borderRadius: BorderRadius.circular(100),
                                      minHeight: 6,
                                      backgroundColor: Colors.white12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
