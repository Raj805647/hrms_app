import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';

import '../../../routes/route_names.dart';

class SignInProvider extends BaseProvider {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {    navigateTo(context, RouteNames.bottomNavigationScreen);


  setLoading(true);

    try {
      await Future.delayed(
        const Duration(seconds: 2),
      );

      /// Login API
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