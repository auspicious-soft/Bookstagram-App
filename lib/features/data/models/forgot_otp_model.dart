// To parse this JSON data, do
//
//     final forgotOtpModel = forgotOtpModelFromJson(jsonString);

import 'dart:convert';

ForgotOtpModel forgotOtpModelFromJson(String str) =>
    ForgotOtpModel.fromJson(json.decode(str));

String forgotOtpModelToJson(ForgotOtpModel data) => json.encode(data.toJson());

class ForgotOtpModel {
  bool? success;
  String? message;

  ForgotOtpModel({
    this.success,
    this.message,
  });

  factory ForgotOtpModel.fromJson(Map<String, dynamic> json) => ForgotOtpModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
