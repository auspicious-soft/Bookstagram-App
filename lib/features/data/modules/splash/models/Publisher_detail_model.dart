import '../../bookstudy/models/book_market_response_Model.dart';

class PublisherDetailResponseModel {
  bool? success;
  String? message;
  PublisherDetailData? data;

  PublisherDetailResponseModel({this.success, this.message, this.data});

  PublisherDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new PublisherDetailData.fromJson(json['data'])
        : null;
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

class PublisherDetailData {
  Publishers? publisher;
  num? booksCount;
  List<PublisherBooks>? publisherBooks;

  PublisherDetailData({this.publisher, this.booksCount, this.publisherBooks});

  PublisherDetailData.fromJson(Map<String, dynamic> json) {
    publisher = json['publisher'] != null
        ? new Publishers.fromJson(json['publisher'])
        : null;
    booksCount = json['booksCount'];
    if (json['publisherBooks'] != null) {
      publisherBooks = <PublisherBooks>[];
      json['publisherBooks'].forEach((v) {
        publisherBooks!.add(new PublisherBooks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.publisher != null) {
      data['publisher'] = this.publisher!.toJson();
    }
    data['booksCount'] = this.booksCount;
    if (this.publisherBooks != null) {
      data['publisherBooks'] =
          this.publisherBooks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Publishers {
  String? sId;
  Name? name;
  String? role;
  List<CategoryId>? categoryId;
  String? email;
  String? password;
  Name? description;
  String? country;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Publishers(
      {this.sId,
      this.name,
      this.role,
      this.categoryId,
      this.email,
      this.password,
      this.description,
      this.country,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Publishers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    role = json['role'];
    if (json['categoryId'] != null) {
      categoryId = <CategoryId>[];
      json['categoryId'].forEach((v) {
        categoryId!.add(new CategoryId.fromJson(v));
      });
    }
    email = json['email'];
    password = json['password'];
    description = json['description'] != null
        ? new Name.fromJson(json['description'])
        : null;
    country = json['country'];
    image = json['image'];
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
    data['role'] = this.role;
    if (this.categoryId != null) {
      data['categoryId'] = this.categoryId!.map((v) => v.toJson()).toList();
    }
    data['email'] = this.email;
    data['password'] = this.password;
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    data['country'] = this.country;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class PublisherBooks {
  String? sId;
  Name? name;
  Name? description;
  List<AuthorId>? authorId;
  List<CategoryId>? categoryId;
  List<SubCategoryId>? subCategoryId;
  num? price;
  List<String>? genre;
  String? image;

  String? type;
  String? publisherId;
  bool? isDiscounted;
  num? discountPercentage;
  num? averageRating;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isFavorite;

  PublisherBooks(
      {this.sId,
      this.name,
      this.description,
      this.authorId,
      this.categoryId,
      this.subCategoryId,
      this.price,
      this.genre,
      this.image,
      this.type,
      this.publisherId,
      this.isDiscounted,
      this.discountPercentage,
      this.averageRating,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isFavorite});

  PublisherBooks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    description = json['description'] != null
        ? new Name.fromJson(json['description'])
        : null;
    if (json['authorId'] != null) {
      authorId = <AuthorId>[];
      json['authorId'].forEach((v) {
        authorId!.add(new AuthorId.fromJson(v));
      });
    }
    if (json['categoryId'] != null) {
      categoryId = <CategoryId>[];
      json['categoryId'].forEach((v) {
        categoryId!.add(new CategoryId.fromJson(v));
      });
    }
    if (json['subCategoryId'] != null) {
      subCategoryId = <SubCategoryId>[];
      json['subCategoryId'].forEach((v) {
        subCategoryId!.add(new SubCategoryId.fromJson(v));
      });
    }

    price = json['price'];
    genre = json['genre'].cast<String>();
    image = json['image'];

    type = json['type'];
    publisherId = json['publisherId'];
    isDiscounted = json['isDiscounted'];
    discountPercentage = json['discountPercentage'];
    averageRating = json['averageRating'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.authorId != null) {
      data['authorId'] = this.authorId!.map((v) => v.toJson()).toList();
    }
    if (this.categoryId != null) {
      data['categoryId'] = this.categoryId!.map((v) => v.toJson()).toList();
    }
    data['subCategoryId'] = this.subCategoryId;
    data['price'] = this.price;
    data['genre'] = this.genre;
    data['image'] = this.image;

    data['type'] = this.type;

    data['publisherId'] = this.publisherId;

    data['isDiscounted'] = this.isDiscounted;
    data['discountPercentage'] = this.discountPercentage;
    data['averageRating'] = this.averageRating;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isFavorite'] = this.isFavorite;
    return data;
  }
}
