// To parse this JSON data, do
//
//     final stockModel = stockModelFromJson(jsonString);

import 'dart:convert';

StockModel stockModelFromJson(String str) =>
    StockModel.fromJson(json.decode(str));

String stockModelToJson(StockModel data) => json.encode(data.toJson());

class StockModel {
  bool? success;
  String? message;
  StockModelData? data;

  StockModel({
    this.success,
    this.message,
    this.data,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
        success: json["success"],
        message: json["message"],
        data:
            json["data"] == null ? null : StockModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class StockModelData {
  String? message;
  DataData? data;

  StockModelData({
    this.message,
    this.data,
  });

  factory StockModelData.fromJson(Map<String, dynamic> json) => StockModelData(
        message: json["message"],
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class DataData {
  List<Book>? books;
  List<Course>? courses;

  DataData({
    this.books,
    this.courses,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        books: json["Books"] == null
            ? []
            : List<Book>.from(json["Books"]!.map((x) => Book.fromJson(x))),
        courses: json["Courses"] == null
            ? []
            : List<Course>.from(
                json["Courses"]!.map((x) => Course.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Books": books == null
            ? []
            : List<dynamic>.from(books!.map((x) => x.toJson())),
        "Courses": courses == null
            ? []
            : List<dynamic>.from(courses!.map((x) => x.toJson())),
      };
}

class Book {
  String? id;
  Description? name;
  Description? description;
  List<AuthorId>? authorId;
  List<BookCategoryId>? categoryId;
  List<SubCategoryId>? subCategoryId;
  int? price;
  List<String>? genre;
  String? image;
  FileClass? file;
  String? type;
  PublisherId? publisherId;
  bool? isDiscounted;
  int? discountPercentage;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? averageRating;

  Book({
    this.id,
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
    this.createdAt,
    this.updatedAt,
    this.averageRating,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["_id"],
        name: json["name"] == null ? null : Description.fromJson(json["name"]),
        description: json["description"] == null
            ? null
            : Description.fromJson(json["description"]),
        authorId: json["authorId"] == null
            ? []
            : List<AuthorId>.from(
                json["authorId"]!.map((x) => AuthorId.fromJson(x))),
        categoryId: json["categoryId"] == null
            ? []
            : List<BookCategoryId>.from(
                json["categoryId"]!.map((x) => BookCategoryId.fromJson(x))),
        subCategoryId: json["subCategoryId"] == null
            ? []
            : List<SubCategoryId>.from(
                json["subCategoryId"]!.map((x) => SubCategoryId.fromJson(x))),
        price: json["price"],
        genre: json["genre"] == null
            ? []
            : List<String>.from(json["genre"]!.map((x) => x)),
        image: json["image"],
        file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
        type: json["type"],
        publisherId: json["publisherId"] == null
            ? null
            : PublisherId.fromJson(json["publisherId"]),
        isDiscounted: json["isDiscounted"],
        discountPercentage: json["discountPercentage"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        averageRating: json["averageRating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name?.toJson(),
        "description": description?.toJson(),
        "authorId": authorId == null
            ? []
            : List<dynamic>.from(authorId!.map((x) => x.toJson())),
        "categoryId": categoryId == null
            ? []
            : List<dynamic>.from(categoryId!.map((x) => x.toJson())),
        "subCategoryId": subCategoryId == null
            ? []
            : List<dynamic>.from(subCategoryId!.map((x) => x.toJson())),
        "price": price,
        "genre": genre == null ? [] : List<dynamic>.from(genre!.map((x) => x)),
        "image": image,
        "file": file?.toJson(),
        "type": type,
        "publisherId": publisherId?.toJson(),
        "isDiscounted": isDiscounted,
        "discountPercentage": discountPercentage,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "averageRating": averageRating,
      };
}

class AuthorId {
  String? id;
  Description? name;
  List<String>? profession;
  String? country;
  DateTime? dob;
  List<String>? genres;
  String? image;
  Description? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  AuthorId({
    this.id,
    this.name,
    this.profession,
    this.country,
    this.dob,
    this.genres,
    this.image,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AuthorId.fromJson(Map<String, dynamic> json) => AuthorId(
        id: json["_id"],
        name: json["name"] == null ? null : Description.fromJson(json["name"]),
        profession: json["profession"] == null
            ? []
            : List<String>.from(json["profession"]!.map((x) => x)),
        country: json["country"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        genres: json["genres"] == null
            ? []
            : List<String>.from(json["genres"]!.map((x) => x)),
        image: json["image"],
        description: json["description"] == null
            ? null
            : Description.fromJson(json["description"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name?.toJson(),
        "profession": profession == null
            ? []
            : List<dynamic>.from(profession!.map((x) => x)),
        "country": country,
        "dob": dob?.toIso8601String(),
        "genres":
            genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
        "image": image,
        "description": description?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Description {
  String? eng;

  Description({
    this.eng,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        eng: json["eng"],
      );

  Map<String, dynamic> toJson() => {
        "eng": eng,
      };
}

class BookCategoryId {
  String? id;
  String? image;
  CategoryIdName? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  BookCategoryId({
    this.id,
    this.image,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory BookCategoryId.fromJson(Map<String, dynamic> json) => BookCategoryId(
        id: json["_id"],
        image: json["image"],
        name:
            json["name"] == null ? null : CategoryIdName.fromJson(json["name"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "name": name?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class CategoryIdName {
  String? eng;
  String? br;

  CategoryIdName({
    this.eng,
    this.br,
  });

  factory CategoryIdName.fromJson(Map<String, dynamic> json) => CategoryIdName(
        eng: json["eng"],
        br: json["br"],
      );

  Map<String, dynamic> toJson() => {
        "eng": eng,
        "br": br,
      };
}

class FileClass {
  String? rus;

  FileClass({
    this.rus,
  });

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
        rus: json["rus"],
      );

  Map<String, dynamic> toJson() => {
        "rus": rus,
      };
}

class PublisherId {
  String? id;
  Description? name;
  String? role;
  List<String>? categoryId;
  String? email;
  String? password;
  Description? description;
  String? country;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  PublisherId({
    this.id,
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
    this.v,
  });

  factory PublisherId.fromJson(Map<String, dynamic> json) => PublisherId(
        id: json["_id"],
        name: json["name"] == null ? null : Description.fromJson(json["name"]),
        role: json["role"],
        categoryId: json["categoryId"] == null
            ? []
            : List<String>.from(json["categoryId"]!.map((x) => x)),
        email: json["email"],
        password: json["password"],
        description: json["description"] == null
            ? null
            : Description.fromJson(json["description"]),
        country: json["country"],
        image: json["image"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name?.toJson(),
        "role": role,
        "categoryId": categoryId == null
            ? []
            : List<dynamic>.from(categoryId!.map((x) => x)),
        "email": email,
        "password": password,
        "description": description?.toJson(),
        "country": country,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class SubCategoryId {
  String? id;
  String? categoryId;
  String? image;
  SubCategoryIdName? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SubCategoryId({
    this.id,
    this.categoryId,
    this.image,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SubCategoryId.fromJson(Map<String, dynamic> json) => SubCategoryId(
        id: json["_id"],
        categoryId: json["categoryId"],
        image: json["image"],
        name: json["name"] == null
            ? null
            : SubCategoryIdName.fromJson(json["name"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryId": categoryId,
        "image": image,
        "name": name?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class SubCategoryIdName {
  String? eng;
  String? kaz;

  SubCategoryIdName({
    this.eng,
    this.kaz,
  });

  factory SubCategoryIdName.fromJson(Map<String, dynamic> json) =>
      SubCategoryIdName(
        eng: json["eng"],
        kaz: json["kaz"],
      );

  Map<String, dynamic> toJson() => {
        "eng": eng,
        "kaz": kaz,
      };
}

class Course {
  String? id;
  Description? name;
  Description? description;
  List<AuthorId>? authorId;
  List<CourseCategoryId>? categoryId;
  List<SubCategoryId>? subCategoryId;
  int? price;
  List<String>? genre;
  String? image;
  Description? file;
  String? type;
  PublisherId? publisherId;
  bool? isDiscounted;
  dynamic discountPercentage;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? averageRating;

  Course({
    this.id,
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
    this.createdAt,
    this.updatedAt,
    this.averageRating,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["_id"],
        name: json["name"] == null ? null : Description.fromJson(json["name"]),
        description: json["description"] == null
            ? null
            : Description.fromJson(json["description"]),
        authorId: json["authorId"] == null
            ? []
            : List<AuthorId>.from(
                json["authorId"]!.map((x) => AuthorId.fromJson(x))),
        categoryId: json["categoryId"] == null
            ? []
            : List<CourseCategoryId>.from(
                json["categoryId"]!.map((x) => CourseCategoryId.fromJson(x))),
        subCategoryId: json["subCategoryId"] == null
            ? []
            : List<SubCategoryId>.from(
                json["subCategoryId"]!.map((x) => SubCategoryId.fromJson(x))),
        price: json["price"],
        genre: json["genre"] == null
            ? []
            : List<String>.from(json["genre"]!.map((x) => x)),
        image: json["image"],
        file: json["file"] == null ? null : Description.fromJson(json["file"]),
        type: json["type"],
        publisherId: json["publisherId"] == null
            ? null
            : PublisherId.fromJson(json["publisherId"]),
        isDiscounted: json["isDiscounted"],
        discountPercentage: json["discountPercentage"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        averageRating: json["averageRating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name?.toJson(),
        "description": description?.toJson(),
        "authorId": authorId == null
            ? []
            : List<dynamic>.from(authorId!.map((x) => x.toJson())),
        "categoryId": categoryId == null
            ? []
            : List<dynamic>.from(categoryId!.map((x) => x.toJson())),
        "subCategoryId": subCategoryId == null
            ? []
            : List<dynamic>.from(subCategoryId!.map((x) => x.toJson())),
        "price": price,
        "genre": genre == null ? [] : List<dynamic>.from(genre!.map((x) => x)),
        "image": image,
        "file": file?.toJson(),
        "type": type,
        "publisherId": publisherId?.toJson(),
        "isDiscounted": isDiscounted,
        "discountPercentage": discountPercentage,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "averageRating": averageRating,
      };
}

class CourseCategoryId {
  String? id;
  String? image;
  Description? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CourseCategoryId({
    this.id,
    this.image,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CourseCategoryId.fromJson(Map<String, dynamic> json) =>
      CourseCategoryId(
        id: json["_id"],
        image: json["image"],
        name: json["name"] == null ? null : Description.fromJson(json["name"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "name": name?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
