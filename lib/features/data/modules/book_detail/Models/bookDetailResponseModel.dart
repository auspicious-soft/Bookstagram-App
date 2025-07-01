import '../../bookstudy/models/book_market_response_Model.dart';

class BookDetailResponseModel {
  bool? success;
  String? message;
  BookDetailData? data;

  BookDetailResponseModel({this.success, this.message, this.data});

  BookDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? new BookDetailData.fromJson(json['data']) : null;
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

class BookDetailData {
  BookData? book;
  List<RelatedBooks>? relatedBooks;
  bool? isPurchased;
  bool? favorite;

  BookDetailData(
      {this.book, this.relatedBooks, this.isPurchased, this.favorite});

  BookDetailData.fromJson(Map<String, dynamic> json) {
    book = json['book'] != null ? new BookData.fromJson(json['book']) : null;
    if (json['relatedBooks'] != null) {
      relatedBooks = <RelatedBooks>[];
      json['relatedBooks'].forEach((v) {
        relatedBooks!.add(new RelatedBooks.fromJson(v));
      });
    }
    isPurchased = json['isPurchased'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.book != null) {
      data['book'] = this.book!.toJson();
    }
    if (this.relatedBooks != null) {
      data['relatedBooks'] = this.relatedBooks!.map((v) => v.toJson()).toList();
    }
    data['isPurchased'] = this.isPurchased;
    data['favorite'] = this.favorite;
    return data;
  }
}

class BookData {
  String? sId;
  Name? name;
  Name? description;
  List<AuthorId>? authorId;
  List<CategoryId>? categoryId;
  List<SubCategoryId>? subCategoryId;
  int? price;
  List<String>? genre;
  String? image;
  String? file;
  String? type;
  PublisherId? publisherId;
  bool? isDiscounted;
  int? discountPercentage;
  int? averageRating;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? readers;
  List<Chapters>? chapters;
  String? language;

  BookData(
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
      this.readers,
      this.chapters,
      this.language});

  BookData.fromJson(Map<String, dynamic> json) {
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
    file = json['file'];
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
    readers = json['readers'];
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(new Chapters.fromJson(v));
      });
    }
    language = json['language'];
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
    data['file'] = this.file;
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
    data['readers'] = this.readers;
    if (this.chapters != null) {
      data['chapters'] = this.chapters!.map((v) => v.toJson()).toList();
    }
    data['language'] = this.language;
    return data;
  }
}

class Chapters {
  String? sId;
  String? lang;
  String? name;
  String? productId;
  int? srNo;
  String? file;
  int? iV;
  String? createdAt;
  String? updatedAt;
  bool? isRead;

  Chapters(
      {this.sId,
      this.lang,
      this.name,
      this.productId,
      this.srNo,
      this.file,
      this.iV,
      this.createdAt,
      this.updatedAt,
      this.isRead});

  Chapters.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    lang = json['lang'];
    name = json['name'];
    productId = json['productId'];
    srNo = json['srNo'];
    file = json['file'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['lang'] = this.lang;
    data['name'] = this.name;
    data['productId'] = this.productId;
    data['srNo'] = this.srNo;
    data['file'] = this.file;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isRead'] = this.isRead;
    return data;
  }
}

class RelatedBooks {
  String? sId;
  Name? name;
  Name? description;
  List<AuthorId>? authorId;
  List<String>? categoryId;
  List<String>? subCategoryId;
  int? price;
  List<String>? genre;
  String? image;
  Name? file;
  String? type;
  String? publisherId;
  bool? isDiscounted;
  int? discountPercentage;
  int? averageRating;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RelatedBooks(
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

  RelatedBooks.fromJson(Map<String, dynamic> json) {
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
    categoryId = json['categoryId'].cast<String>();
    subCategoryId = json['subCategoryId'].cast<String>();
    price = json['price'];
    genre = json['genre'].cast<String>();
    image = json['image'];
    file = json['file'] != null ? new Name.fromJson(json['file']) : null;
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
