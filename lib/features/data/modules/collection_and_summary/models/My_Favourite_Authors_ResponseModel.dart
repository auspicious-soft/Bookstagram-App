import '../../bookstudy/models/book_market_response_Model.dart';

class MyFavouriteAuthorsResponseModel {
  int? page;
  int? limit;
  bool? success;
  String? message;
  int? total;
  List<FavouruiteAuthors>? data;

  MyFavouriteAuthorsResponseModel(
      {this.page,
      this.limit,
      this.success,
      this.message,
      this.total,
      this.data});

  MyFavouriteAuthorsResponseModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    success = json['success'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <FavouruiteAuthors>[];
      json['data'].forEach((v) {
        data!.add(new FavouruiteAuthors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['success'] = this.success;
    data['message'] = this.message;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavouruiteAuthors {
  String? sId;
  FavAuthorId? authorId;
  String? userId;
  String? createdAt;
  String? updatedAt;
  FavProductId? productId;

  FavouruiteAuthors(
      {this.sId,
      this.authorId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.productId});

  FavouruiteAuthors.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    authorId = json['authorId'] != null
        ? new FavAuthorId.fromJson(json['authorId'])
        : null;
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    productId = json['productId'] != null
        ? new FavProductId.fromJson(json['productId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.authorId != null) {
      data['authorId'] = this.authorId!.toJson();
    }
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.productId != null) {
      data['productId'] = this.productId!.toJson();
    }
    return data;
  }
}

class FavAuthorId {
  String? sId;
  Name? name;
  List<String>? profession;
  String? country;
  String? dob;
  List<String>? genres;
  String? image;
  Description? description;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FavAuthorId(
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

  FavAuthorId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    profession = json['profession'].cast<String>();
    country = json['country'];
    dob = json['dob'];
    genres = json['genres'].cast<String>();
    image = json['image'];
    description = json['description'] != null
        ? new Description.fromJson(json['description'])
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

class FavProductId {
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
  bool? favorite;

  FavProductId(
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
      this.iV,
      this.favorite});

  FavProductId.fromJson(Map<String, dynamic> json) {
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
    favorite = json['favorite'];
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
    data['favorite'] = this.favorite;
    return data;
  }
}
