import 'package:base_module/base_module.dart';

class UserResponse extends BaseModel{
  UserResponse({
      super.status,
      super.message,
      super.statusCode,
      this.data,});

  UserResponse.fromJson(dynamic json) {
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  UserData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['status_code'] = statusCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class UserData {
  UserData({
      this.user, 
      this.tokens,});

  UserData.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    tokens = json['tokens'];
  }
  User? user;
  String? tokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['tokens'] = tokens;
    return map;
  }

}

class User {
  User({
      this.id, 
      this.name, 
      this.email, 
      this.username, 
      this.workspaceType, 
      this.roleType,
      this.avatar,});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    workspaceType = json['workspace_type'];
    avatar = json['avatar'];
    roleType = json['role_type'];
  }
  int? id;
  String? name;
  String? email;
  String? username;
  int? workspaceType;
  String? avatar;
  String? roleType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['username'] = username;
    map['role_type'] = roleType;
    map['workspace_type'] = workspaceType;
    map['avatar'] = avatar;
    return map;
  }

}