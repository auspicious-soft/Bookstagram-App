import '../../bookstudy/models/book_market_response_Model.dart';
import '../../bookstudy/models/categoryGetBy_id_model.dart' show File;

// Top-level response model
class AllaudiobooksResponseModel {
  bool? success;
  String? message;
  num? page;
  num? limit;
  int? total;
  AllBooksData? data;

  AllaudiobooksResponseModel({
    this.success,
    this.message,
    this.page,
    this.limit,
    this.total,
    this.data,
  });

  AllaudiobooksResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
    page = json['page'] as num?;
    limit = json['limit'] as num?;
    total = json['total'] as int?;
    data = json['data'] != null
        ? AllBooksData.fromJson(json['data'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

// Data container for audiobooks
class AllBooksData {
  List<AudioBooksDetail>? audioBooks;

  AllBooksData({this.audioBooks});

  AllBooksData.fromJson(Map<String, dynamic> json) {
    if (json['audioBooks'] != null) {
      audioBooks = (json['audioBooks'] as List<dynamic>)
          .map((v) => AudioBooksDetail.fromJson(v as Map<String, dynamic>))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (audioBooks != null) {
      data['audioBooks'] = audioBooks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// Details for each audiobook
class AudioBooksDetail {
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
  String? publisherId;
  bool? isDiscounted;
  num? discountPercentage;
  String? format;
  num? averageRating;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isFavorite;

  AudioBooksDetail({
    this.sId,
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
    this.iV,
    this.isFavorite,
  });

  AudioBooksDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] as String?;
    name = json['name'] != null
        ? Name.fromJson(json['name'] as Map<String, dynamic>)
        : null;
    description = json['description'] != null
        ? Name.fromJson(json['description'] as Map<String, dynamic>)
        : null;
    if (json['authorId'] != null) {
      authorId = (json['authorId'] as List<dynamic>)
          .map((v) => AuthorId.fromJson(v as Map<String, dynamic>))
          .toList();
    }
    if (json['categoryId'] != null) {
      categoryId = (json['categoryId'] as List<dynamic>)
          .map((v) => CategoryId.fromJson(v as Map<String, dynamic>))
          .toList();
    }
    subCategoryId = (json['subCategoryId'] as List<dynamic>?)?.cast<String>();
    price = json['price'] as num?;
    genre = (json['genre'] as List<dynamic>?)?.cast<String>();
    image = json['image'] as String? ??
        json['books'] as String?; // Handle image field if misnamed
    file = json['file'] != null
        ? File.fromJson(json['file'] as Map<String, dynamic>)
        : null;
    type = json['type'] as String?;
    publisherId = json['publisherId'] as String?;
    isDiscounted = json['isDiscounted'] as bool?;
    discountPercentage = json['discountPercentage'] as int?;
    format = json['format'] as String?;
    averageRating = json['averageRating'] as int?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    iV = json['__v'] as int?;
    isFavorite = json['isFavorite'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (description != null) {
      data['description'] = description!.toJson();
    }
    if (authorId != null) {
      data['authorId'] = authorId!.map((v) => v.toJson()).toList();
    }
    if (categoryId != null) {
      data['categoryId'] = categoryId!.map((v) => v.toJson()).toList();
    }
    data['subCategoryId'] = subCategoryId;
    data['price'] = price;
    data['genre'] = genre;
    data['image'] = image;
    if (file != null) {
      data['file'] = file!.toJson();
    }
    data['type'] = type;
    data['publisherId'] = publisherId;
    data['isDiscounted'] = isDiscounted;
    data['discountPercentage'] = discountPercentage;
    data['format'] = format;
    data['averageRating'] = averageRating;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['isFavorite'] = isFavorite;
    return data;
  }
}
