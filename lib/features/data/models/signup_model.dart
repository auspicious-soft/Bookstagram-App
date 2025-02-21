// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  bool? success;
  String? message;
  Data? data;

  SignUpModel({
    this.success,
    this.message,
    this.data,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? identifier;
  String? role;
  FullName? fullName;
  String? email;
  String? authType;
  dynamic phoneNumber;
  dynamic profilePic;
  bool? emailVerified;
  bool? whatsappNumberVerified;
  String? language;
  SchoolVoucher? schoolVoucher;
  dynamic fcmToken;
  List<String>? productsLanguage;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.identifier,
    this.role,
    this.fullName,
    this.email,
    this.authType,
    this.phoneNumber,
    this.profilePic,
    this.emailVerified,
    this.whatsappNumberVerified,
    this.language,
    this.schoolVoucher,
    this.fcmToken,
    this.productsLanguage,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        identifier: json["identifier"],
        role: json["role"],
        fullName: json["fullName"] == null
            ? null
            : FullName.fromJson(json["fullName"]),
        email: json["email"],
        authType: json["authType"],
        phoneNumber: json["phoneNumber"],
        profilePic: json["profilePic"],
        emailVerified: json["emailVerified"],
        whatsappNumberVerified: json["whatsappNumberVerified"],
        language: json["language"],
        schoolVoucher: json["schoolVoucher"] == null
            ? null
            : SchoolVoucher.fromJson(json["schoolVoucher"]),
        fcmToken: json["fcmToken"],
        productsLanguage: json["productsLanguage"] == null
            ? []
            : List<String>.from(json["productsLanguage"]!.map((x) => x)),
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "role": role,
        "fullName": fullName?.toJson(),
        "email": email,
        "authType": authType,
        "phoneNumber": phoneNumber,
        "profilePic": profilePic,
        "emailVerified": emailVerified,
        "whatsappNumberVerified": whatsappNumberVerified,
        "language": language,
        "schoolVoucher": schoolVoucher?.toJson(),
        "fcmToken": fcmToken,
        "productsLanguage": productsLanguage == null
            ? []
            : List<dynamic>.from(productsLanguage!.map((x) => x)),
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class FullName {
  String? eng;

  FullName({
    this.eng,
  });

  factory FullName.fromJson(Map<String, dynamic> json) => FullName(
        eng: json["eng"],
      );

  Map<String, dynamic> toJson() => {
        "eng": eng,
      };
}

class SchoolVoucher {
  DateTime? createdAt;
  DateTime? expiredAt;

  SchoolVoucher({
    this.createdAt,
    this.expiredAt,
  });

  factory SchoolVoucher.fromJson(Map<String, dynamic> json) => SchoolVoucher(
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        expiredAt: json["expiredAt"] == null
            ? null
            : DateTime.parse(json["expiredAt"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "expiredAt": expiredAt?.toIso8601String(),
      };
}
