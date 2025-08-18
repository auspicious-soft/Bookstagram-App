import 'package:bookstagram/features/data/modules/bookstudy/models/book_market_response_Model.dart';

class ReviewResponseModel {
  bool? success;
  String? message;
  ReviewData? data;

  ReviewResponseModel({this.success, this.message, this.data});

  ReviewResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new ReviewData.fromJson(json['data']) : null;
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

class ReviewData {
  List<Ratings>? ratings;
  num? rating1;
  num? rating2;
  num? rating3;
  num? rating4;
  num? rating5;
  num? averageRating;
  num? totalRatings;

  ReviewData(
      {this.ratings,
      this.rating1,
      this.rating2,
      this.rating3,
      this.rating4,
      this.rating5,
      this.averageRating,
      this.totalRatings});

  ReviewData.fromJson(Map<String, dynamic> json) {
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(new Ratings.fromJson(v));
      });
    }
    rating1 = json['rating1'];
    rating2 = json['rating2'];
    rating3 = json['rating3'];
    rating4 = json['rating4'];
    rating5 = json['rating5'];
    averageRating = json['averageRating'];
    totalRatings = json['totalRatings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ratings != null) {
      data['ratings'] = this.ratings!.map((v) => v.toJson()).toList();
    }
    data['rating1'] = this.rating1;
    data['rating2'] = this.rating2;
    data['rating3'] = this.rating3;
    data['rating4'] = this.rating4;
    data['rating5'] = this.rating5;
    data['averageRating'] = this.averageRating;
    data['totalRatings'] = this.totalRatings;
    return data;
  }
}

class Ratings {
  String? sId;
  UserId? userId;
  String? productId;
  num? iV;
  String? comment;
  num? rating;

  Ratings(
      {this.sId,
      this.userId,
      this.productId,
      this.iV,
      this.comment,
      this.rating});

  Ratings.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId =
        json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
    productId = json['productId'];
    iV = json['__v'];
    comment = json['comment'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    data['productId'] = this.productId;
    data['__v'] = this.iV;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    return data;
  }
}

class UserId {
  SchoolVoucher? schoolVoucher;
  String? sId;
  String? role;
  String? email;
  String? authType;
  String? phoneNumber;
  String? profilePic;
  bool? emailVerified;
  bool? whatsappNumberVerified;
  String? language;
  String? fcmToken;
  Name? fullName;
  Name? firstName;
  List<String>? productsLanguage;
  String? identifier;
  String? createdAt;
  String? updatedAt;
  num? wallet;
  bool? notificationAllowed;

  UserId(
      {this.schoolVoucher,
      this.sId,
      this.role,
      this.email,
      this.authType,
      this.phoneNumber,
      this.fullName,
      this.firstName,
      this.profilePic,
      this.emailVerified,
      this.whatsappNumberVerified,
      this.language,
      this.fcmToken,
      this.productsLanguage,
      this.identifier,
      this.createdAt,
      this.updatedAt,
      this.wallet,
      this.notificationAllowed});

  UserId.fromJson(Map<String, dynamic> json) {
    schoolVoucher = json['schoolVoucher'] != null
        ? new SchoolVoucher.fromJson(json['schoolVoucher'])
        : null;
    sId = json['_id'];
    role = json['role'];
    email = json['email'];
    authType = json['authType'];
    phoneNumber = json['phoneNumber'];
    fullName =
        json['fullName'] != null ? new Name.fromJson(json['fullName']) : null;
    firstName =
        json['firstName'] != null ? new Name.fromJson(json['firstName']) : null;

    authType = json['authType'];
    phoneNumber = json['phoneNumber'];
    profilePic = json['profilePic'];
    emailVerified = json['emailVerified'];
    whatsappNumberVerified = json['whatsappNumberVerified'];
    language = json['language'];

    fcmToken = json['fcmToken'];
    productsLanguage = json['productsLanguage'].cast<String>();
    identifier = json['identifier'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    wallet = json['wallet'];
    notificationAllowed = json['notificationAllowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.schoolVoucher != null) {
      data['schoolVoucher'] = this.schoolVoucher!.toJson();
    }
    data['_id'] = this.sId;
    data['role'] = this.role;
    if (this.fullName != null) {
      data['fullName'] = this.fullName!.toJson();
    }
    if (this.firstName != null) {
      data['firstName'] = this.firstName!.toJson();
    }

    data['email'] = this.email;

    data['authType'] = this.authType;
    data['phoneNumber'] = this.phoneNumber;
    data['profilePic'] = this.profilePic;
    data['emailVerified'] = this.emailVerified;
    data['whatsappNumberVerified'] = this.whatsappNumberVerified;
    data['language'] = this.language;
    data['fcmToken'] = this.fcmToken;
    data['productsLanguage'] = this.productsLanguage;
    data['identifier'] = this.identifier;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['wallet'] = this.wallet;
    data['notificationAllowed'] = this.notificationAllowed;
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
