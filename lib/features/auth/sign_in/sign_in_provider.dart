import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/user_response.dart';
import 'package:flutter/material.dart';

import '../../../firebase_service.dart';
import '../../../routes/route_names.dart';

import 'package:flutter/material.dart';

class SignInProvider extends BaseProvider {
  NotificationService notificationService = NotificationService();
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
      final fcmToken = await notificationService.messaging.getToken();
      final Map<String,dynamic> body = {
        "username": emailController.text,
        "password": passwordController.text,
        "fcm_token": fcmToken,
        "device_type": 'ios',
        "uuid": "test_uuid_123"
      };

    final response = await authRepository.signIn(body);

    if(response.isSuccess){
      final userDataMap = response.data['data'];
      UserData user = UserData.fromJson(userDataMap);

      await StorageService.setUserId(user.user?.id ?? 0);
      await StorageService.setToken(user.tokens ?? '');
      await StorageService.setUserType(user.user?.roleType ?? '');
      await StorageService.setUserData(user);

      showSnackBar(context, 'Login Successfully',isError: false);
      navigateAndClearStack(context, RouteNames.bottomNavigationScreen);

      clearController();
    } else {
        showSnackBar(context, response.error ?? 'login failed');
      }

    } catch (e) {
      debugPrint("Login error: $e");
    } finally {
      setLoading(false);
    }
  }

  void clearController() {
    emailController.clear();
    passwordController.clear();
  }
}