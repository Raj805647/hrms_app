import 'package:base_module/providers/base_providers.dart';
import 'package:flutter/material.dart';

import '../../../routes/route_names.dart';

class ForgotPasswordProvider extends BaseProvider {
  final emailController = TextEditingController();
  String? emailError;

  void validateEmail() {
    if (emailController.text.trim().isEmpty) {
      emailError = "Email address is required";
    } else if (!emailController.text.contains('@') ||
        !emailController.text.contains('.')) {
      emailError = "Please enter a valid email address";
    } else {
      emailError = null;
    }
    notifyListeners();
  }

  Future<void> sendOtp(BuildContext context) async {
    // Validate email
    validateEmail();

    if (emailError != null) {
      showSnackBar(context, emailError!);
      return;
    }

    setLoading(true);

    try {
      await Future.delayed(const Duration(seconds: 2));
      navigateTo(context, RouteNames.bottomNavigationScreen);

    } catch (e) {
      showSnackBar(context, "Something went wrong. Please try again.");
      debugPrint("Forgot password error: $e");
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}