import 'package:base_module/base_module.dart';

class UserResponse extends BaseModel {
  UserResponse({
      super.status,
      super.message,
      this.data,});

  UserResponse.fromJson(dynamic json) {
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
  UserData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class UserData {
  UserData({
      this.id, 
      this.name, 
      this.email, 
      this.type, 
      this.status, 
      this.token, 
      this.createdAt,});

  UserData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    type = json['type'];
    status = json['status'];
    token = json['token'];
    createdAt = json['created_at'];
  }
  int? id;
  String? name;
  String? email;
  String? type;
  bool? status;
  String? token;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['type'] = type;
    map['status'] = status;
    map['token'] = token;
    map['created_at'] = createdAt;
    return map;
  }

}
