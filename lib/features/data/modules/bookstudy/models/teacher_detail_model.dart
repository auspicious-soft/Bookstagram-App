import '../../home_module/models/CollectionDataModel.dart';
import '../../home_module/models/homeProductModel.dart';

class TeacherProfileModel {
  bool? success;
  String? message;
  TeacherData? data;
  List<AuthorBooks>? authorBooks;
  bool? isFavorite;

  TeacherProfileModel(
      {this.success,
      this.message,
      this.data,
      this.authorBooks,
      this.isFavorite});

  TeacherProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new TeacherData.fromJson(json['data']) : null;
    if (json['authorBooks'] != null) {
      authorBooks = <AuthorBooks>[];
      json['authorBooks'].forEach((v) {
        authorBooks!.add(new AuthorBooks.fromJson(v));
      });
    }
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.authorBooks != null) {
      data['authorBooks'] = this.authorBooks!.map((v) => v.toJson()).toList();
    }
    data['isFavorite'] = this.isFavorite;
    return data;
  }
}

class TeacherData {
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

  TeacherData(
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

  TeacherData.fromJson(Map<String, dynamic> json) {
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

class AuthorBooks {
  String? sId;
  Name? name;
  Name? description;
  List<AuthorId>? authorId;
  List<CategoryId>? categoryId;
  List<SubCategoryId>? subCategoryId;
  num? price;
  List<String>? genre;
  String? image;
  Name? file;
  String? type;
  AuthorId? publisherId;
  bool? isDiscounted;
  num? discountPercentage;
  num? averageRating;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AuthorBooks(
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

  AuthorBooks.fromJson(Map<String, dynamic> json) {
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
    file = json['file'] != null ? new Name.fromJson(json['file']) : null;
    type = json['type'];
    publisherId = json['publisherId'] != null
        ? new AuthorId.fromJson(json['publisherId'])
        : null;
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
    if (this.authorId != null) {
      data['authorId'] = this.authorId!.map((v) => v.toJson()).toList();
    }
    if (this.categoryId != null) {
      data['categoryId'] = this.categoryId!.map((v) => v.toJson()).toList();
    }
    if (this.subCategoryId != null) {
      data['subCategoryId'] =
          this.subCategoryId!.map((v) => v.toJson()).toList();
    }
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
    data['averageRating'] = this.averageRating;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
