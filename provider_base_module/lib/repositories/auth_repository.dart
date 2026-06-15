import 'package:base_module/core/app_config.dart';
import 'package:flutter/cupertino.dart';

import '../core/network/api_client.dart';
import '../core/network/base_repository.dart';
import '../core/network/result.dart';

class AuthRepository extends BaseRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);

  Future<Result<dynamic>> signIn(Map<String, dynamic> body) {
    return safeApiCall(() async {

      final response = await apiClient.postDio(
        AppConfig.actionSignIn,
        requiresAuth: false,
        body: body,
      );

      return response.data;
    });
  }

  Future<Result<dynamic>> signOut(String userToken) {
    return safeApiCall(() async {
      final response = await apiClient.getDio(AppConfig.actionSignOut);
      debugPrint("SIGN IN RESPONSE: ${response.data}");
      return response.data;
    });
  }

  Future<Result<dynamic>> employeeDashboard() {
    return safeApiCall(() async {
      final response = await apiClient.getDio(AppConfig.actionEmployeeDashboard);
      debugPrint("SIGN IN RESPONSE: ${response.data}");
      return response.data;
    });
  }

}
