// To parse this JSON data, do
//
//     final verificationOtpModel = verificationOtpModelFromJson(jsonString);

import 'dart:convert';

VerificationOtpModel verificationOtpModelFromJson(String str) =>
    VerificationOtpModel.fromJson(json.decode(str));

String verificationOtpModelToJson(VerificationOtpModel data) =>
    json.encode(data.toJson());

class VerificationOtpModel {
  bool? success;
  Data? data;

  VerificationOtpModel({
    this.success,
    this.data,
  });

  factory VerificationOtpModel.fromJson(Map<String, dynamic> json) =>
      VerificationOtpModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  User? user;

  Data({
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}

class User {
  SchoolVoucher? schoolVoucher;
  String? id;
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
  dynamic fcmToken;
  List<String>? productsLanguage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? token;

  User({
    this.schoolVoucher,
    this.id,
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
    this.fcmToken,
    this.productsLanguage,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
