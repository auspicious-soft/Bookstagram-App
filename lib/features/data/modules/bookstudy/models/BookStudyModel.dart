import 'package:bookstagram/features/data/modules/home_module/models/author_listmodel.dart';

import '../../home_module/models/CollectionDataModel.dart';
import '../../home_module/models/homeProductModel.dart';
import 'Category_data_model.dart';
import 'book_market_response_Model.dart' show ReadProgress;

class BookStudyModel {
  bool? success;
  String? message;
  BookStudyData? data;

  BookStudyModel({this.success, this.message, this.data});

  BookStudyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? new BookStudyData.fromJson(json['data']) : null;
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

class BookStudyData {
  List<ReadProgress>? readBooks;
  List<NewBooks>? newBooks;
  List<AuthorModel>? teachers;
  List<NewBooks>? popularCourses;
  List<Categories>? categories;
  List<ReadProgress>? readProgress;

  BookStudyData(
      {this.newBooks,
      this.teachers,
      this.readBooks,
      this.categories,
      this.readProgress,
      this.popularCourses});

  BookStudyData.fromJson(Map<String, dynamic> json) {
    if (json['newBooks'] != null) {
      newBooks = <NewBooks>[];
      json['newBooks'].forEach((v) {
        newBooks!.add(new NewBooks.fromJson(v));
      });
    }
    if (json['popularCourses'] != null) {
      popularCourses = <NewBooks>[];
      json['popularCourses'].forEach((v) {
        popularCourses!.add(new NewBooks.fromJson(v));
      });
    }

    if (json['readBooks'] != null) {
      readBooks = <ReadProgress>[];
      json['readBooks'].forEach((v) {
        readBooks!.add(new ReadProgress.fromJson(v));
      });
    }
    if (json['teachers'] != null) {
      teachers = <AuthorModel>[];
      json['teachers'].forEach((v) {
        teachers!.add(new AuthorModel.fromJson(v));
      });
    }
    if (json['readProgress'] != null) {
      readProgress = <ReadProgress>[];
      json['readProgress'].forEach((v) {
        readProgress!.add(new ReadProgress.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.newBooks != null) {
      data['newBooks'] = this.newBooks!.map((v) => v.toJson()).toList();
    }
    if (this.readBooks != null) {
      data['readBooks'] = this.readBooks!.map((v) => v.toJson()).toList();
    }

    if (this.popularCourses != null) {
      data['popularCourses'] =
          this.popularCourses!.map((v) => v.toJson()).toList();
    }
    if (this.teachers != null) {
      data['teachers'] = this.teachers!.map((v) => v.toJson()).toList();
    }
    if (this.readProgress != null) {
      data['readProgress'] = this.readProgress!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewBooks {
  String? sId;
  ProductsId? productsId;
  String? createdAt;
  String? updatedAt;
  num? iV;
  bool? isFavorite;

  NewBooks(
      {this.sId,
      this.productsId,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isFavorite});

  NewBooks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productsId = json['productsId'] != null
        ? new ProductsId.fromJson(json['productsId'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.productsId != null) {
      data['productsId'] = this.productsId!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isFavorite'] = this.isFavorite;
    return data;
  }
}

class ProductsId {
  String? sId;
  Name? name;
  Name? description;
  List<AuthorId>? authorId;
  List<CategoryId>? categoryId;
  List<SubCategoryId>? subCategoryId;
  int? price;
  List<String>? genre;
  String? image;
  File? file;
  String? type;
  PublisherId? publisherId;
  bool? isDiscounted;
  num? discountPercentage;
  num? averageRating;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ProductsId(
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

  ProductsId.fromJson(Map<String, dynamic> json) {
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
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
    type = json['type'];
    publisherId = json['publisherId'] != null
        ? new PublisherId.fromJson(json['publisherId'])
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

class CategoryId {
  String? sId;
  String? image;
  Name? name;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CategoryId(
      {this.sId,
      this.image,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['image'] = this.image;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class SubCategoryId {
  String? sId;
  Name? name;
  String? image;
  String? categoryId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SubCategoryId(
      {this.sId,
      this.name,
      this.image,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  SubCategoryId.fromJson(Map<String, dynamic> json) {
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

class PublisherId {
  String? sId;
  Name? name;
  String? role;
  List<String>? categoryId;
  String? email;
  String? password;
  Name? description;
  String? country;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PublisherId(
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

  PublisherId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    role = json['role'];
    categoryId = json['categoryId'].cast<String>();
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
    data['categoryId'] = this.categoryId;
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
