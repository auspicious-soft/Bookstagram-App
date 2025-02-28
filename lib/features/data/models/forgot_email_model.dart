// To parse this JSON data, do
//
//     final forgotEmailModel = forgotEmailModelFromJson(jsonString);

import 'dart:convert';

ForgotEmailModel forgotEmailModelFromJson(String str) =>
    ForgotEmailModel.fromJson(json.decode(str));

String forgotEmailModelToJson(ForgotEmailModel data) =>
    json.encode(data.toJson());

class ForgotEmailModel {
  bool? success;
  String? message;

  ForgotEmailModel({
    this.success,
    this.message,
  });

  factory ForgotEmailModel.fromJson(Map<String, dynamic> json) =>
      ForgotEmailModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
