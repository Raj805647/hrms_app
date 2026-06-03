import 'package:base_module/base_module.dart';

class PortfolioDetailsResponse extends BaseModel {
  PortfolioDetailsResponse({
      super.status,
      super.message,
      this.data,});

  PortfolioDetailsResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PortfolioDetailsData.fromJson(v));
      });
    }
  }
  List<PortfolioDetailsData>? data;

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

class PortfolioDetailsData {
  PortfolioDetailsData({
    this.policyId,
    this.applicationNumber,
    this.status,
    this.productName,
    this.service,
    this.serviceType,
    this.filledBy,
    this.userEmail,
    this.userPhone,
    this.formFilledAt,
    this.formDetails,
  });

  PortfolioDetailsData.fromJson(dynamic json) {
    policyId = json['policy_id'];
    applicationNumber = json['application_number'];
    status = json['status'];
    productName = json['product_name'];
    service = json['service'];
    serviceType = json['service_type'];
    filledBy = json['filled_by'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    formFilledAt = json['form_filled_at'];

    // Dynamic form details
    formDetails = json['form_details'] != null
        ? Map<String, dynamic>.from(json['form_details'])
        : {};
  }

  int? policyId;
  String? applicationNumber;
  String? status;
  String? productName;
  String? service;
  String? serviceType;
  String? filledBy;
  String? userEmail;
  String? userPhone;
  String? formFilledAt;

  // Dynamic data
  Map<String, dynamic>? formDetails;

  // ADD THIS METHOD
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['policy_id'] = policyId;
    map['application_number'] = applicationNumber;
    map['status'] = status;
    map['product_name'] = productName;
    map['service'] = service;
    map['service_type'] = serviceType;
    map['filled_by'] = filledBy;
    map['user_email'] = userEmail;
    map['user_phone'] = userPhone;
    map['form_filled_at'] = formFilledAt;
    map['form_details'] = formDetails;

    return map;
  }
}