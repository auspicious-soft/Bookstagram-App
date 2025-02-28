// To parse this JSON data, do
//
//     final changePassModel = changePassModelFromJson(jsonString);

import 'dart:convert';

ChangePassModel changePassModelFromJson(String str) =>
    ChangePassModel.fromJson(json.decode(str));

String changePassModelToJson(ChangePassModel data) =>
    json.encode(data.toJson());

class ChangePassModel {
  bool? success;
  String? message;
  Data? data;

  ChangePassModel({
    this.success,
    this.message,
    this.data,
  });

  factory ChangePassModel.fromJson(Map<String, dynamic> json) =>
      ChangePassModel(
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
  StName? firstName;
  StName? lastName;
  String? email;
  String? authType;
  dynamic phoneNumber;
  dynamic profilePic;
  bool? emailVerified;
  bool? whatsappNumberVerified;
  String? language;
  String? fcmToken;
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
    this.firstName,
    this.lastName,
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        schoolVoucher: json["schoolVoucher"] == null
            ? null
            : SchoolVoucher.fromJson(json["schoolVoucher"]),
        id: json["_id"],
        identifier: json["identifier"],
        role: json["role"],
        firstName: json["firstName"] == null
            ? null
            : StName.fromJson(json["firstName"]),
        lastName:
            json["lastName"] == null ? null : StName.fromJson(json["lastName"]),
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
        "firstName": firstName?.toJson(),
        "lastName": lastName?.toJson(),
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

class StName {
  String? eng;

  StName({
    this.eng,
  });

  factory StName.fromJson(Map<String, dynamic> json) => StName(
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
