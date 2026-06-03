class BaseModel {
  bool? status;
  String? message;

  BaseModel({this.status, this.message});

  BaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}