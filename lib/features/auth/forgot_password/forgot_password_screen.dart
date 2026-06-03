import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/help_widget.dart';
import 'forgot_password_provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<ForgotPasswordProvider>(
      builder: (_, provider, __) {
        return Scaffold(
          body: SizedBox(
            height: double.infinity,
            child: Stack(
              children: [

                /// Background
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          colorScheme.primary.withOpacity(.08),
                          colorScheme.secondary.withOpacity(.05),
                          colorScheme.surface,
                        ],
                      ),
                    ),
                  ),
                ),

                /// Top Blob
                Positioned(
                  top: -120,
                  right: -80,
                  child: Container(
                    height: 280,
                    width: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                      colorScheme.primary.withOpacity(.08),
                    ),
                  ),
                ),

                /// Bottom Blob
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24,vertical:150),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      spaceHeight(20),

                      Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                colorScheme.primary,
                                colorScheme.secondary,
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.lock_reset_rounded,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                      ),

                      spaceHeight(40),

                      Text(
                        "Forgot Password?",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                          fontWeight:
                          FontWeight.w800,
                        ),
                      ),

                      spaceHeight(10),

                      Text(
                        "Enter your registered email address and we'll send you a verification code.",
                        style: TextStyle(
                          color: colorScheme.onSurface
                              .withOpacity(.65),
                          height: 1.6,
                        ),
                      ),

                      spaceHeight(40),

                      AppTextField(
                        controller:
                        provider.emailController,
                        hintText:
                        "Email Address",
                        prefixIcon:
                        Icons.email_outlined,
                        keyboardType:
                        TextInputType.emailAddress,
                      ),

                      spaceHeight(30),

                      AppButton(
                        title: "Send OTP",
                        icon:
                        Icons.arrow_forward_rounded,
                        isLoading:
                        provider.isLoaded,
                        onPressed: ()=>
                        provider.sendOtp(context),
                      ),

                      spaceHeight(20),

                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Back to Sign In",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: -150,
                  left: -100,
                  child: Container(
                    height: 320,
                    width: 320,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.secondary
                          .withOpacity(.08),
                    ),
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