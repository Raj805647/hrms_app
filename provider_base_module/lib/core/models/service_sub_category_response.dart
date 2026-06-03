import 'package:base_module/base_module.dart';

class ServiceSubCategoryResponse extends BaseModel {
  ServiceSubCategoryResponse({
      super.status,
      super.message,
      this.data,});

  ServiceSubCategoryResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ServiceSubCategoryData.fromJson(v));
      });
    }
  }
  List<ServiceSubCategoryData>? data;

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

class ServiceSubCategoryData {
  ServiceSubCategoryData({
      this.id, 
      this.categoryId, 
      this.name, 
      this.value, 
      this.slug, 
      this.type, 
      this.description, 
      this.icon, 
      this.status, 
      this.order, 
      this.createdAt, 
      this.updatedAt, 
      this.createdBy, 
      this.updatedBy,});

  ServiceSubCategoryData.fromJson(dynamic json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    value = json['value'];
    slug = json['slug'];
    type = json['type'];
    description = json['description'];
    icon = json['icon'];
    status = json['status'];
    order = json['order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }
  int? id;
  int? categoryId;
  String? name;
  String? value;
  String? slug;
  dynamic type;
  String? description;
  String? icon;
  bool? status;
  int? order;
  String? createdAt;
  String? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_id'] = categoryId;
    map['name'] = name;
    map['value'] = value;
    map['slug'] = slug;
    map['type'] = type;
    map['description'] = description;
    map['icon'] = icon;
    map['status'] = status;
    map['order'] = order;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    return map;
  }

}