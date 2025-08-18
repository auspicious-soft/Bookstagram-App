import '../../../bookstudy/models/book_market_response_Model.dart';
import '../../../bookstudy/models/categoryGetBy_id_model.dart';

class AddDetailResponseModel {
  bool? success;
  String? message;
  AddtoCartData? data;

  AddDetailResponseModel({this.success, this.message, this.data});

  AddDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? new AddtoCartData.fromJson(json['data']) : null;
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

class AddtoCartData {
  String? sId;
  String? userId;
  List<cartProductId>? productId;
  String? buyed;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AddtoCartData(
      {this.sId,
      this.userId,
      this.productId,
      this.buyed,
      this.createdAt,
      this.updatedAt,
      this.iV});

  AddtoCartData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    if (json['productId'] != null) {
      productId = <cartProductId>[];
      json['productId'].forEach((v) {
        productId!.add(new cartProductId.fromJson(v));
      });
    }
    buyed = json['buyed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    if (this.productId != null) {
      data['productId'] = this.productId!.map((v) => v.toJson()).toList();
    }
    data['buyed'] = this.buyed;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class cartProductId {
  String? sId;
  Name? name;
  Name? description;
  List<AuthorId>? authorId;
  List<String>? categoryId;
  List<String>? subCategoryId;
  num? price;
  List<String>? genre;
  String? image;
  File? file;
  String? type;
  String? publisherId;
  bool? isDiscounted;
  num? discountPercentage;
  num? averageRating;
  String? createdAt;
  String? updatedAt;
  num? iV;

  cartProductId(
      {this.sId,
      this.name,
      this.description,
      this.authorId,
      this.categoryId,
      this.subCategoryId,
      this.price,
      this.genre,
      this.image,
      this.file,
      this.type,
      this.publisherId,
      this.isDiscounted,
      this.discountPercentage,
      this.averageRating,
      this.createdAt,
      this.updatedAt,
      this.iV});

  cartProductId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    description = json['description'] != null
        ? new Name.fromJson(json['description'])
        : null;
    if (json['authorId'] != null) {
      authorId = <AuthorId>[];
      json['authorId'].forEach((v) {
        authorId!.add(AuthorId.fromJson(v));
      });
    }
    categoryId = json['categoryId'].cast<String>();
    subCategoryId = json['subCategoryId'].cast<String>();
    price = json['price'];
    genre = json['genre'].cast<String>();
    image = json['image'];
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
    type = json['type'];
    publisherId = json['publisherId'];
    isDiscounted = json['isDiscounted'];
    discountPercentage = json['discountPercentage'];
    averageRating = json['averageRating'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    if (authorId != null) {
      data['authorId'] = authorId!.map((v) => v.toJson()).toList();
    }
    data['categoryId'] = this.categoryId;
    data['subCategoryId'] = this.subCategoryId;
    data['price'] = this.price;
    data['genre'] = this.genre;
    data['image'] = this.image;
    if (this.file != null) {
      data['file'] = this.file!.toJson();
    }
    data['type'] = this.type;
    data['publisherId'] = this.publisherId;
    data['isDiscounted'] = this.isDiscounted;
    data['discountPercentage'] = this.discountPercentage;
    data['averageRating'] = this.averageRating;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class AuthorId {
  String? sId;
  Name? name;
  List<String>? profession;
  String? country;
  String? dob;
  List<String>? genres;
  String? image;
  Name? description;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AuthorId(
      {this.sId,
      this.name,
      this.profession,
      this.country,
      this.dob,
      this.genres,
      this.image,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.iV});

  AuthorId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    profession = json['profession'].cast<String>();
    country = json['country'];
    dob = json['dob'];
    genres = json['genres'].cast<String>();
    image = json['image'];
    description = json['description'] != null
        ? new Name.fromJson(json['description'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['profession'] = this.profession;
    data['country'] = this.country;
    data['dob'] = this.dob;
    data['genres'] = this.genres;
    data['image'] = this.image;
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
