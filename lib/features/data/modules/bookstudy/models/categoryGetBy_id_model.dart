import '../../../models/collection_model.dart';
import '../../home_module/models/CollectionDataModel.dart';
import '../../home_module/models/blog_collection_model.dart';

class CategoryById {
  bool? success;
  String? message;
  CategoryByIdData? data;

  CategoryById({this.success, this.message, this.data});

  CategoryById.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new CategoryByIdData.fromJson(json['data'])
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

class CategoryByIdData {
  Category? category;
  List<Books>? books;

  CategoryByIdData({this.category, this.books});

  CategoryByIdData.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books!.add(new Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.books != null) {
      data['books'] = this.books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? sId;
  String? image;
  Name? name;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Category(
      {this.sId,
      this.image,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Category.fromJson(Map<String, dynamic> json) {
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

class Books {
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
  num? averageRating;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isFavorite;

  Books(
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
      this.iV,
      this.isFavorite});

  Books.fromJson(Map<String, dynamic> json) {
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
    data['isFavorite'] = this.isFavorite;
    return data;
  }
}

class AuthorId {
  String? sId;
  Name? name;

  AuthorId({this.sId, this.name});

  AuthorId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    return data;
  }
}

class File {
  String? kaz;
  String? eng;
  String? rus;

  File({this.kaz, this.eng, this.rus});

  File.fromJson(Map<String, dynamic> json) {
    kaz = json['kaz'];
    eng = json['eng'];
    rus = json['rus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kaz'] = this.kaz;
    data['eng'] = this.eng;
    data['rus'] = this.rus;
    return data;
  }
}

class CategoryId {
  String? sId;
  Name? name;

  CategoryId({this.sId, this.name});

  CategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    return data;
  }
}
