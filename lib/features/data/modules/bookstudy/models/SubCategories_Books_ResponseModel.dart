import '../../../models/collection_model.dart';
import '../../home_module/models/CollectionDataModel.dart' show File;
import '../../home_module/models/blog_collection_model.dart';

class SubCategoriesBookResponse {
  bool? success;
  String? message;
  num? page;
  num? limit;
  num? total;
  SubCategoriesBookResponseData? data;

  SubCategoriesBookResponse(
      {this.success,
      this.message,
      this.page,
      this.limit,
      this.total,
      this.data});

  SubCategoriesBookResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    data = json['data'] != null
        ? new SubCategoriesBookResponseData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SubCategoriesBookResponseData {
  SubCategories? subCategories;
  List<SubCategoriesBookResponseBooks>? books;

  SubCategoriesBookResponseData({this.subCategories, this.books});

  SubCategoriesBookResponseData.fromJson(Map<String, dynamic> json) {
    subCategories = json['subCategories'] != null
        ? new SubCategories.fromJson(json['subCategories'])
        : null;
    if (json['books'] != null) {
      books = <SubCategoriesBookResponseBooks>[];
      json['books'].forEach((v) {
        books!.add(new SubCategoriesBookResponseBooks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subCategories != null) {
      data['subCategories'] = this.subCategories!.toJson();
    }
    if (this.books != null) {
      data['books'] = this.books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  String? sId;
  Name? name;
  String? image;
  String? categoryId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SubCategories(
      {this.sId,
      this.name,
      this.image,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  SubCategories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    image = json['image'];
    categoryId = json['categoryId'];
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
    data['image'] = this.image;
    data['categoryId'] = this.categoryId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class SubCategoriesBookResponseBooks {
  String? sId;
  Name? name;
  Name? description;
  List<AuthorId>? authorId;
  List<CategoryId>? categoryId;
  List<String>? subCategoryId;
  num? price;
  List<String>? genre;
  String? image;
  File? file;
  String? type;
  AuthorId? publisherId;
  bool? isDiscounted;
  num? discountPercentage;
  String? format;
  num? averageRating;
  String? createdAt;
  String? updatedAt;
  bool? isFavorite;

  SubCategoriesBookResponseBooks(
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
      this.format,
      this.averageRating,
      this.createdAt,
      this.updatedAt,
      this.isFavorite});

  SubCategoriesBookResponseBooks.fromJson(Map<String, dynamic> json) {
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
    subCategoryId = json['subCategoryId'].cast<String>();
    price = json['price'];
    genre = json['genre'].cast<String>();
    image = json['image'];
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
    type = json['type'];
    publisherId = json['publisherId'] != null
        ? new AuthorId.fromJson(json['publisherId'])
        : null;
    isDiscounted = json['isDiscounted'];
    discountPercentage = json['discountPercentage'];
    format = json['format'];
    averageRating = json['averageRating'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isFavorite = json['isFavorite'];
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
    if (this.file != null) {
      data['file'] = this.file!.toJson();
    }
    data['type'] = this.type;
    if (this.publisherId != null) {
      data['publisherId'] = this.publisherId!.toJson();
    }
    data['isDiscounted'] = this.isDiscounted;
    data['discountPercentage'] = this.discountPercentage;
    data['format'] = this.format;
    data['averageRating'] = this.averageRating;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isFavorite'] = this.isFavorite;
    return data;
  }
}
