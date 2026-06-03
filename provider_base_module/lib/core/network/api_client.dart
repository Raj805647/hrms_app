import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../storage/storage_service.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: AppConfig.baseUrl,
          ),
        ) {
    debugPrint("🌐 Base URL: ${AppConfig.baseUrl}");
  }

  Future<Response> postDio(
      String endpoint, {
        dynamic body,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        bool isFormData = false,
        bool requiresAuth = true,
      }) async {
    try {
      final data = isFormData && body is Map<String, dynamic>
          ? FormData.fromMap(body)
          : body;

      final updatedHeaders = await _attachAuthHeader(
        headers,
        requiresAuth: requiresAuth,
      );

      print("ENDPOINT: $endpoint");
      print("BODY: $body");
      print("HEADERS: $updatedHeaders");

      final response = await dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: updatedHeaders),
      );

      print("RESPONSE: ${response.data}");

      return response;
    } on DioException catch (e) {
      print("ERROR STATUS: ${e.response?.statusCode}");
      print("ERROR DATA: ${e.response?.data}");
      rethrow;
    }
  }

  Future<Response> getDio(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async {
    final updatedHeaders = await _attachAuthHeader(
      headers,
      requiresAuth: requiresAuth,
    );

    return await dio.get(
      endpoint,
      queryParameters: queryParameters,
      options: Options(headers: updatedHeaders),
    );
  }

  Future<http.Response> getHttp(
    String url, {
    bool requiresAuth = true,
  }) async {
    final headers = <String, String>{
      'Accept': 'application/json',
    };

    if (requiresAuth) {
      final token = await StorageService.getUserToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return await http.get(
      Uri.parse(url),
      headers: headers,
    );
  }

  Future<http.Response> postHttp(
    String url,
    Map<String, dynamic> body, {
    bool requiresAuth = true,
  }) async {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    if (requiresAuth) {
      final token = await StorageService.getUserToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  Future<Map<String, dynamic>> _attachAuthHeader(
    Map<String, dynamic>? headers, {
    bool requiresAuth = true,
  }) async {
    final updatedHeaders = Map<String, dynamic>.from(headers ?? {});

    // Always set Accept
    updatedHeaders['Accept'] = 'application/json';

    if (requiresAuth) {
      final token = await StorageService.getUserToken();

      if (token != null && token.isNotEmpty) {
        updatedHeaders['Authorization'] = 'Bearer $token';
      }
    }

    return updatedHeaders;
  }
}
