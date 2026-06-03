import 'package:base_module/base_module.dart';

class ServiceProductsResponse extends BaseModel{
  ServiceProductsResponse({
      super.status,
      super.message,
      this.data, 
      this.pagination,});

  ServiceProductsResponse.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ServiceProductsData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<ServiceProductsData>? data;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }

}

class Pagination {
  Pagination({
      this.currentPage, 
      this.limit, 
      this.totalPages, 
      this.totalRecords,});

  Pagination.fromJson(dynamic json) {
    currentPage = json['current_page'];
    limit = json['limit'];
    totalPages = json['total_pages'];
    totalRecords = json['total_records'];
  }
  int? currentPage;
  int? limit;
  int? totalPages;
  int? totalRecords;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    map['limit'] = limit;
    map['total_pages'] = totalPages;
    map['total_records'] = totalRecords;
    return map;
  }

}

class ServiceProductsData {
  ServiceProductsData({
      this.id, 
      this.serviceId, 
      this.serviceTypeId, 
      this.name, 
      this.companyName, 
      this.minAmount, 
      this.maxAmount, 
      this.interestRate, 
      this.tenure, 
      this.premium, 
      this.eligibility, 
      this.requiredDocuments, 
      this.description, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.createdBy, 
      this.updatedBy,});

  ServiceProductsData.fromJson(dynamic json) {
    id = json['id'];
    serviceId = json['service_id'];
    serviceTypeId = json['service_type_id'];
    name = json['name'];
    companyName = json['company_name'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    interestRate = json['interest_rate'];
    tenure = json['tenure'];
    premium = json['premium'];
    eligibility = json['eligibility'];
    requiredDocuments = json['required_documents'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }
  int? id;
  int? serviceId;
  int? serviceTypeId;
  String? name;
  String? companyName;
  String? minAmount;
  String? maxAmount;
  String? interestRate;
  String? tenure;
  String? premium;
  String? eligibility;
  String? requiredDocuments;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  dynamic updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['service_id'] = serviceId;
    map['service_type_id'] = serviceTypeId;
    map['name'] = name;
    map['company_name'] = companyName;
    map['min_amount'] = minAmount;
    map['max_amount'] = maxAmount;
    map['interest_rate'] = interestRate;
    map['tenure'] = tenure;
    map['premium'] = premium;
    map['eligibility'] = eligibility;
    map['required_documents'] = requiredDocuments;
    map['description'] = description;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    return map;
  }

}