import 'package:flutter/material.dart';
import 'package:hrms_app/features/auth/sign_in/sign_in_provider.dart';
import 'package:hrms_app/routes/route_names.dart';
import 'package:provider/provider.dart';

import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/help_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInProvider>(
      builder: (_, provider, __) {
        final colorScheme =
            Theme.of(context).colorScheme;

        return Scaffold(
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [

                Positioned(
                  top: -10,
                  right: -120,
                  child: Container(
                    height: 260,
                    width: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.primary
                          .withOpacity(.08),
                    ),
                  ),
                ),

                Positioned(
                  bottom: -10,
                  left: -80,
                  child: Container(
                    height: 220,
                    width: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.secondary
                          .withOpacity(.08),
                    ),
                  ),
                ),

                SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      spaceHeight(40),

                      Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                colorScheme.primary,
                                colorScheme.secondary,
                              ],
                            ),
                            borderRadius:
                            BorderRadius.circular(32),
                          ),
                          child: const Icon(
                            Icons.groups_rounded,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      spaceHeight(40),

                      Text(
                        "Welcome Back 👋",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                          fontWeight:
                          FontWeight.w800,
                        ),
                      ),

                      spaceHeight(8),

                      Text(
                        "Sign in to continue managing your workforce.",
                        style: TextStyle(
                          color: colorScheme.onSurface
                              .withOpacity(.65),
                          fontSize: 15,
                        ),
                      ),

                      spaceHeight(40),

                      AppTextField(
                        controller:
                        provider.emailController,
                        hintText:
                        "Username or Email",
                        prefixIcon:
                        Icons.person_outline_rounded,
                      ),

                      spaceHeight(16),

                      AppTextField(
                        controller:
                        provider.passwordController,
                        hintText: "Password",
                        prefixIcon:
                        Icons.lock_outline_rounded,
                        obscureText:
                        provider.obscurePassword,
                        suffixIcon: IconButton(
                          onPressed: provider
                              .togglePasswordVisibility,
                          icon: Icon(
                            provider.obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),

                      spaceHeight(12),

                      Align(
                        alignment:
                        Alignment.centerRight,
                        child: TextButton(
                          onPressed: ()=> provider.navigateTo(context, RouteNames.forgotPasswordScreen),
                          child: const Text(
                            "Forgot Password?",
                          ),
                        ),
                      ),

                      spaceHeight(24),

                      AppButton(
                        title: "Sign In",
                        isLoading: provider.isLoaded,
                        onPressed: ()=>provider.login(context),
                      ),

                      spaceHeight(40),

                      Center(
                        child: Text(
                          "Secure Employee Management",
                          style: TextStyle(
                            color: colorScheme
                                .onSurface
                                .withOpacity(.55),
                          ),
                        ),
                      ),
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