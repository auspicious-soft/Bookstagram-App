// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? success;
  String? message;
  Data? data;

  LoginModel({
    this.success,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
  SchoolVoucher? schoolVoucher;
  String? id;
  String? identifier;
  String? role;
  FullName? fullName;
  String? email;
  String? authType;
  String? countryCode;
  String? phoneNumber;
  dynamic profilePic;
  bool? emailVerified;
  bool? whatsappNumberVerified;
  String? language;
  dynamic fcmToken;
  List<String>? productsLanguage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? token;

  Data({
    this.schoolVoucher,
    this.id,
    this.identifier,
    this.role,
    this.fullName,
    this.email,
    this.authType,
    this.countryCode,
    this.phoneNumber,
    this.profilePic,
    this.emailVerified,
    this.whatsappNumberVerified,
    this.language,
    this.fcmToken,
    this.productsLanguage,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        schoolVoucher: json["schoolVoucher"] == null
            ? null
            : SchoolVoucher.fromJson(json["schoolVoucher"]),
        id: json["_id"],
        identifier: json["identifier"],
        role: json["role"],
        fullName: json["fullName"] == null
            ? null
            : FullName.fromJson(json["fullName"]),
        email: json["email"],
        authType: json["authType"],
        countryCode: json["countryCode"],
        phoneNumber: json["phoneNumber"],
        profilePic: json["profilePic"],
        emailVerified: json["emailVerified"],
        whatsappNumberVerified: json["whatsappNumberVerified"],
        language: json["language"],
        fcmToken: json["fcmToken"],
        productsLanguage: json["productsLanguage"] == null
            ? []
            : List<String>.from(json["productsLanguage"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "schoolVoucher": schoolVoucher?.toJson(),
        "_id": id,
        "identifier": identifier,
        "role": role,
        "fullName": fullName?.toJson(),
        "email": email,
        "authType": authType,
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
        "profilePic": profilePic,
        "emailVerified": emailVerified,
        "whatsappNumberVerified": whatsappNumberVerified,
        "language": language,
        "fcmToken": fcmToken,
        "productsLanguage": productsLanguage == null
            ? []
            : List<dynamic>.from(productsLanguage!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "token": token,
      };
}

class FullName {
  String? kaz;

  FullName({
    this.kaz,
  });

  factory FullName.fromJson(Map<String, dynamic> json) => FullName(
        kaz: json["kaz"],
      );

  Map<String, dynamic> toJson() => {
        "kaz": kaz,
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
