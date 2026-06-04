import 'package:flutter/material.dart';
import 'package:hrms_app/features/auth/sign_in/sign_in_provider.dart';
import 'package:hrms_app/routes/route_names.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/help_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Consumer<SignInProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                // Background decorative circles
                Positioned(
                  top: -10,
                  right: -120,
                  child: TweenAnimationBuilder(
                    tween: Tween(begin: 0.8, end: 1.0),
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          height: 260,
                          width: 260,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: themeManager.primary.withOpacity(0.08),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Positioned(
                  bottom: -10,
                  left: -80,
                  child: TweenAnimationBuilder(
                    tween: Tween(begin: 0.8, end: 1.0),
                    duration: const Duration(seconds: 2, milliseconds: 500),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          height: 220,
                          width: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: themeManager.secondary.withOpacity(0.08),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),

                      // Logo/Brand Icon
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
                                  gradient: LinearGradient(
                                    colors: [
                                      themeManager.primary,
                                      themeManager.secondary,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(32),
                                  boxShadow: [
                                    BoxShadow(
                                      color: themeManager.primary.withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.groups_rounded,
                                  size: 60,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Welcome Text
                      Text(
                        "Welcome Back 👋",
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: themeManager.text,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Sign in to continue managing your workforce.",
                        style: TextStyle(
                          color: themeManager.textSecondary,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Email Field
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

                      const SizedBox(height: 16),

                      // Password Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                            controller: provider.passwordController,
                            hintText: "Password",
                            prefixIcon: Icons.lock_outline_rounded,
                            obscureText: provider.obscurePassword,
                            suffixIcon: IconButton(
                              onPressed: provider.togglePasswordVisibility,
                              icon: Icon(
                                provider.obscurePassword
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                color: themeManager.textSecondary,
                              ),
                            ),
                          ),
                          if (provider.passwordError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8, left: 12),
                              child: Text(
                                provider.passwordError!,
                                style: TextStyle(
                                  color: Colors.red[400],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => provider.navigateTo(
                              context,
                              RouteNames.forgotPasswordScreen
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: themeManager.primary,
                          ),
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Sign In Button
                      AppButton(
                        title: "Sign In",
                        isLoading: provider.isLoaded,
                        onPressed: () => provider.login(context),
                      ),

                      const SizedBox(height: 40),

                      // Footer Text
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Secure Employee Management",
                              style: TextStyle(
                                color: themeManager.textSecondary.withOpacity(0.7),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shield_outlined,
                                  size: 14,
                                  color: themeManager.textSecondary.withOpacity(0.5),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "SSL Encrypted",
                                  style: TextStyle(
                                    color: themeManager.textSecondary.withOpacity(0.5),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
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
