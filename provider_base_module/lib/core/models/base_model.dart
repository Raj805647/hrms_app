class BaseModel {
  bool? status;
  int? statusCode;
  String? message;

  BaseModel({this.status, this.message,this.statusCode});

  BaseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    status = json['status'];
    message = json['message'];
  }
}