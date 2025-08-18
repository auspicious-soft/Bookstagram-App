import 'package:bookstagram/features/data/modules/bookstudy/models/book_market_response_Model.dart';

class SettingProfile {
  bool? success;
  String? message;
  SettingData? data;

  SettingProfile({this.success, this.message, this.data});

  SettingProfile.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new SettingData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SettingData {
  SettingProfileData? data;
  num? booksReadCount;

  SettingData({this.data, this.booksReadCount});

  SettingData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new SettingProfileData.fromJson(json['data'])
        : null;
    booksReadCount = json['booksReadCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['booksReadCount'] = this.booksReadCount;
    return data;
  }
}

class SettingProfileData {
  SchoolVoucher? schoolVoucher;
  String? sId;
  String? identifier;
  String? role;
  Name? firstName;
  Name? fullName;
  Name? lastName;
  String? email;
  String? authType;
  String? phoneNumber;
  String? profilePic;
  String? language;
  List<String>? productsLanguage;
  String? createdAt;
  String? updatedAt;
  String? country;
  num? wallet;

  SettingProfileData(
      {this.schoolVoucher,
      this.sId,
      this.identifier,
      this.role,
      this.firstName,
      this.fullName,
      this.lastName,
      this.email,
      this.authType,
      this.phoneNumber,
      this.profilePic,
      this.language,
      this.productsLanguage,
      this.createdAt,
      this.updatedAt,
      this.country,
      this.wallet});

  SettingProfileData.fromJson(Map<String, dynamic> json) {
    schoolVoucher = json['schoolVoucher'] != null
        ? new SchoolVoucher.fromJson(json['schoolVoucher'])
        : null;
    sId = json['_id'];
    identifier = json['identifier'];
    role = json['role'];
    firstName =
        json['firstName'] != null ? new Name.fromJson(json['firstName']) : null;
    fullName =
        json['fullName'] != null ? new Name.fromJson(json['fullName']) : null;
    lastName =
        json['lastName'] != null ? new Name.fromJson(json['lastName']) : null;
    email = json['email'];

    authType = json['authType'];
    phoneNumber = json['phoneNumber'];
    profilePic = json['profilePic'];
    language = json['language'];
    productsLanguage = json['productsLanguage'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    country = json['country'];
    wallet = json['wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.schoolVoucher != null) {
      data['schoolVoucher'] = this.schoolVoucher!.toJson();
    }
    data['_id'] = this.sId;
    data['identifier'] = this.identifier;
    data['role'] = this.role;
    if (this.firstName != null) {
      data['firstName'] = this.firstName!.toJson();
    }
    if (this.fullName != null) {
      data['fullName'] = this.fullName!.toJson();
    }
    if (this.lastName != null) {
      data['lastName'] = this.lastName!.toJson();
    }
    data['email'] = this.email;
    data['authType'] = this.authType;
    data['phoneNumber'] = this.phoneNumber;
    data['profilePic'] = this.profilePic;
    data['language'] = this.language;
    data['productsLanguage'] = this.productsLanguage;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['country'] = this.country;
    data['wallet'] = this.wallet;
    return data;
  }
}

class SchoolVoucher {
  String? createdAt;
  String? expiredAt;

  SchoolVoucher({this.createdAt, this.expiredAt});

  SchoolVoucher.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    expiredAt = json['expiredAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['expiredAt'] = this.expiredAt;
    return data;
  }
}
