import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_response.dart';

class StorageService {
  static const String _userIdKey = 'userId';
  static const String _token = 'token';
  static const String _userData = 'userData';
  static const String _userType = 'userType';

  //get set userId
  static Future<void> setUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, userId);
  }

  static  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  //get set userToken
  static Future<void> setToken(String token) async {
    print('akdbfkbdsa=> $token');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_token, token);
  }

  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString(_token);

    return token;
  }

  //get set user Types
  static  Future<void> setUserType(String? userType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userType, userType ?? '');
  }

  static Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userType);
  }

  // get set user data response
  static Future<void> setUserData(UserData? user) async {
    if (user == null) return;
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(user.toJson());
    print('adkfbsdahfh=> $user');
    await prefs.setString(_userData, jsonString);
  }

  // Retrieve user data
  static  Future<UserData?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userData);
    if (jsonString == null || jsonString.isEmpty) {
      print('⚠️ No user data found in SharedPreferences');
      return null;
    }
    try {
      final jsonMap = jsonDecode(jsonString);
      print('adkhbfhsadhf=>$jsonMap');
      return UserData.fromJson(jsonMap);
    } catch (e) {
      print('❌ Error decoding user data: $e');
      return null;
    }
  }

  //clear all user data
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    print('✅ All local storage data cleared successfully');
  }
}
