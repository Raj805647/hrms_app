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
      // TODO: Implement actual login API call
      final Map<String,dynamic> body = {
        "username": emailController.text,
        "password": passwordController.text,
        "fcm_token": "test_fcm_token",
        "device_type": "android"
      };
    final response = await authRepository.signIn(body);
    if(response.isSuccess){
      showSnackBar(context, 'Login Successfully');
      navigateTo(context, RouteNames.bottomNavigationScreen);
    }
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