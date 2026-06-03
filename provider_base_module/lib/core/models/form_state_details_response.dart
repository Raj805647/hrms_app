import 'package:base_module/base_module.dart';

class FormStateDetailsResponse extends BaseModel {
  FormStateDetailsResponse({
      super.status,
      super.message,
      this.data,});

  FormStateDetailsResponse.fromJson(dynamic json) {
    data = json['data'] != null ? FormStateDetailsData.fromJson(json['data']) : null;
  }
  FormStateDetailsData? data;

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

class FormStateDetailsData {
  FormStateDetailsData({
      this.productId, 
      this.productName, 
      this.fields,});

  FormStateDetailsData.fromJson(dynamic json) {
    productId = json['product_id'];
    productName = json['product_name'];
    if (json['fields'] != null) {
      fields = [];
      json['fields'].forEach((v) {
        fields?.add(Fields.fromJson(v));
      });
    }
  }
  int? productId;
  String? productName;
  List<Fields>? fields;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['product_name'] = productName;
    if (fields != null) {
      map['fields'] = fields?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Fields {
  Fields({
      this.id, 
      this.label, 
      this.fieldName, 
      this.fieldType, 
      this.options,});

  Fields.fromJson(dynamic json) {
    id = json['id'];
    label = json['label'];
    fieldName = json['field_name'];
    fieldType = json['field_type'];
    options = json['options'];
  }
  int? id;
  String? label;
  String? fieldName;
  String? fieldType;
  dynamic options;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['label'] = label;
    map['field_name'] = fieldName;
    map['field_type'] = fieldType;
    map['options'] = options;
    return map;
  }

}