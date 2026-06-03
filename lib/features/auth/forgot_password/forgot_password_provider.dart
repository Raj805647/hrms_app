import 'package:base_module/base_module.dart';

import 'package:flutter/material.dart';
import 'package:hrms_app/routes/route_names.dart';

class ForgotPasswordProvider extends BaseProvider {
  final emailController = TextEditingController();

  Future<void> sendOtp(BuildContext context) async {
    navigateTo(context, RouteNames.bottomNavigationScreen);
    if (emailController.text.trim().isEmpty) {
      showSnackBar(context,"Please enter email address");
      return;
    }

    setLoading(true);

    try {
      await Future.delayed(
        const Duration(seconds: 2),
      );

      /// API Call

      // context.push(AppRoutes.verifyOtp);

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