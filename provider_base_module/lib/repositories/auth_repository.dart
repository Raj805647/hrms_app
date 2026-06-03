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
      debugPrint("SIGN IN REQUEST: $body");

      final response = await apiClient.postDio(
        AppConfig.actionSignIn,
        requiresAuth: false,
        body: body,
      );

      debugPrint("SIGN IN RESPONSE: ${response.data}");

      return response.data;
    });
  }

}
