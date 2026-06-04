import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';

import '../../../routes/route_names.dart';

import 'package:flutter/material.dart';

class SignInProvider extends BaseProvider {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  String? emailError;
  String? passwordError;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    setLoading(true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Implement actual login API call
      // Example:
      // final response = await apiService.login(
      //   emailController.text.trim(),
      //   passwordController.text,
      // );

      // if (response.success) {
      navigateTo(context, RouteNames.bottomNavigationScreen);
      // } else {
      //   showError(response.message);
      // }

    } catch (e) {
      // Handle error
      debugPrint("Login error: $e");
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}