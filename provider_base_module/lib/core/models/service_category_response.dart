import 'package:base_module/base_module.dart';

class ServiceCategoryResponse extends BaseModel {
  ServiceCategoryResponse({
      super.status,
      super.message,
      this.data,});

  ServiceCategoryResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ServiceCategoryData.fromJson(v));
      });
    }
  }
  List<ServiceCategoryData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ServiceCategoryData {
  ServiceCategoryData({
      this.id, 
      this.name, 
      this.slug, 
      this.description, 
      this.icon, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.createdBy, 
      this.updatedBy,});

  ServiceCategoryData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    icon = json['icon'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }
  int? id;
  String? name;
  String? slug;
  String? description;
  String? icon;
  int? status;
  String? createdAt;
  String? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['description'] = description;
    map['icon'] = icon;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    return map;
  }

}