import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';

import 'forgot_password_provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Consumer<ForgotPasswordProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          body: SizedBox(
            height: double.infinity,
            child: Stack(
              children: [
                // Background gradient
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: themeManager.isDarkMode
                            ? [
                          Colors.grey[900]!.withOpacity(0.5),
                          Colors.grey[850]!.withOpacity(0.3),
                          Colors.black,
                        ]
                            : [
                          themeManager.primary.withOpacity(0.05),
                          themeManager.secondary.withOpacity(0.03),
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                ),

                // Top decorative circle
                Positioned(
                  top: -120,
                  right: -80,
                  child: TweenAnimationBuilder(
                    tween: Tween(begin: 0.8, end: 1.0),
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          height: 280,
                          width: 280,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: themeManager.primary.withOpacity(0.08),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Bottom decorative circle
                Positioned(
                  bottom: -150,
                  left: -100,
                  child: TweenAnimationBuilder(
                    tween: Tween(begin: 0.8, end: 1.0),
                    duration: const Duration(seconds: 2, milliseconds: 500),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          height: 320,
                          width: 320,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: themeManager.secondary.withOpacity(0.08),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Main content
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),

                      // Animated Icon
                      Center(
                        child: TweenAnimationBuilder(
                          tween: Tween(begin: 0.5, end: 1.0),
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.elasticOut,
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value,
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                    colors: [
                                      themeManager.primary,
                                      themeManager.secondary,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: themeManager.primary.withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.lock_reset_rounded,
                                  color: Colors.white,
                                  size: 60,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Title
                      Text(
                        "Forgot Password?",
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: themeManager.text,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Description
                      Text(
                        "Enter your registered email address and we'll send you a verification code to reset your password.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themeManager.textSecondary,
                          height: 1.6,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Email Field with validation
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                            controller: provider.emailController,
                            hintText: "Email Address",
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          if (provider.emailError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8, left: 12),
                              child: Text(
                                provider.emailError!,
                                style: TextStyle(
                                  color: Colors.red[400],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // Send OTP Button
                      AppButton(
                        title: "Send OTP",
                        icon: Icons.arrow_forward_rounded,
                        isLoading: provider.isLoaded,
                        onPressed: () => provider.sendOtp(context),
                      ),

                      const SizedBox(height: 20),

                      // Back to Sign In
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: themeManager.primary,
                          ),
                          child: const Text(
                            "← Back to Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Info text
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: themeManager.isDarkMode
                              ? Colors.white.withOpacity(0.05)
                              : themeManager.primary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 20,
                              color: themeManager.primary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "We'll send a 6-digit verification code to your email",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: themeManager.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}