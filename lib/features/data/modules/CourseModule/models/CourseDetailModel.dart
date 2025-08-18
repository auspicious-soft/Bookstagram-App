import '../../bookstudy/models/book_market_response_Model.dart';

class CourseDetailModel {
  bool? success;
  String? message;
  CourseDetailData? data;

  CourseDetailModel({this.success, this.message, this.data});

  CourseDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new CourseDetailData.fromJson(json['data'])
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

class CourseDetailData {
  Course? course;
  num? reviewCount;
  List<RelatedCourses>? relatedCourses;
  bool? isPurchased;
  bool? isAddedToCart;
  bool? certificateAvailable;
  bool? favorite;

  CourseDetailData(
      {this.course,
      this.reviewCount,
      this.relatedCourses,
      this.isAddedToCart,
      this.certificateAvailable,
      this.isPurchased,
      this.favorite});

  CourseDetailData.fromJson(Map<String, dynamic> json) {
    course =
        json['course'] != null ? new Course.fromJson(json['course']) : null;
    reviewCount = json['reviewCount'];
    if (json['relatedCourses'] != null) {
      relatedCourses = <RelatedCourses>[];
      json['relatedCourses'].forEach((v) {
        relatedCourses!.add(new RelatedCourses.fromJson(v));
      });
    }
    isPurchased = json['isPurchased'];
    isAddedToCart = json['isAddedToCart'];
    certificateAvailable = json['certificateAvailable'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.course != null) {
      data['course'] = this.course!.toJson();
    }
    data['reviewCount'] = this.reviewCount;
    if (this.relatedCourses != null) {
      data['relatedCourses'] =
          this.relatedCourses!.map((v) => v.toJson()).toList();
    }
    data['isPurchased'] = this.isPurchased;
    data['isAddedToCart'] = this.isAddedToCart;
    data['certificateAvailable'] = this.certificateAvailable;
    data['favorite'] = this.favorite;
    return data;
  }
}

class Course {
  String? sId;
  Name? name;
  Description? description;
  List<AuthorId>? authorId;
  List<CategoryId>? categoryId;
  List<SubCategoryId>? subCategoryId;
  num? price;
  List<String>? genre;
  String? image;
  String? type;
  CategoryId? publisherId;
  bool? isDiscounted;
  num? discountPercentage;
  num? averageRating;
  String? createdAt;
  String? updatedAt;
  num? iV;
  num? lessons;

  Course(
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
      this.lessons});

  Course.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    description = json['description'] != null
        ? new Description.fromJson(json['description'])
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
    publisherId = json['publisherId'] != null
        ? new CategoryId.fromJson(json['publisherId'])
        : null;
    isDiscounted = json['isDiscounted'];
    discountPercentage = json['discountPercentage'];
    averageRating = json['averageRating'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    lessons = json['lessons'];
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
    data['lessons'] = this.lessons;
    return data;
  }
}

class RelatedCourses {
  String? sId;
  Name? name;
  Description? description;
  List<AuthorId>? authorId;
  List<String>? categoryId;
  List<String>? subCategoryId;
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
  num? iV;

  RelatedCourses(
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
      this.iV});

  RelatedCourses.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    description = json['description'] != null
        ? new Description.fromJson(json['description'])
        : null;
    if (json['authorId'] != null) {
      authorId = <AuthorId>[];
      json['authorId'].forEach((v) {
        authorId!.add(new AuthorId.fromJson(v));
      });
    }
    categoryId = json['categoryId'].cast<String>();
    subCategoryId = json['subCategoryId'].cast<String>();
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
    data['categoryId'] = this.categoryId;
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
    return data;
  }
}
