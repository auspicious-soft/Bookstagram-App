// To parse this JSON data, do
//
//     final collectionModel = collectionModelFromJson(jsonString);

import 'dart:convert';

CollectionModel collectionModelFromJson(String str) =>
    CollectionModel.fromJson(json.decode(str));

String collectionModelToJson(CollectionModel data) =>
    json.encode(data.toJson());

class CollectionModel {
  bool? success;
  String? message;
  Data? data;

  CollectionModel({
    this.success,
    this.message,
    this.data,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      CollectionModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? page;
  int? limit;
  bool? success;
  String? message;
  int? total;
  List<Datum>? data;

  Data({
    this.page,
    this.limit,
    this.success,
    this.message,
    this.total,
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json["page"],
        limit: json["limit"],
        success: json["success"],
        message: json["message"],
        total: json["total"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "success": success,
        "message": message,
        "total": total,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? id;
  dynamic name;
  String? image;
  List<BooksId>? booksId;
  bool? displayOnMobile;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.name,
    this.image,
    this.booksId,
    this.displayOnMobile,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        booksId: json["booksId"] == null
            ? []
            : List<BooksId>.from(
                json["booksId"]!.map((x) => BooksId.fromJson(x))),
        displayOnMobile: json["displayOnMobile"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "booksId": booksId == null
            ? []
            : List<dynamic>.from(booksId!.map((x) => x.toJson())),
        "displayOnMobile": displayOnMobile,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class BooksId {
  String? id;
  Description? name;
  Description? description;
  List<AuthorId>? authorId;
  List<CategoryId>? categoryId;
  List<CategoryId>? subCategoryId;
  int? price;
  List<String>? genre;
  String? image;
  FileClass? file;
  String? type;
  PublisherId? publisherId;
  bool? isDiscounted;
  int? discountPercentage;
  double? averageRating;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  BooksId({
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
    this.averageRating,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory BooksId.fromJson(Map<String, dynamic> json) => BooksId(
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
            : List<CategoryId>.from(
                json["categoryId"]!.map((x) => CategoryId.fromJson(x))),
        subCategoryId: json["subCategoryId"] == null
            ? []
            : List<CategoryId>.from(
                json["subCategoryId"]!.map((x) => CategoryId.fromJson(x))),
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
        averageRating: json["averageRating"]?.toDouble(),
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
        "averageRating": averageRating,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class AuthorId {
  String? id;
  AuthorIdName? name;

  AuthorId({
    this.id,
    this.name,
  });

  factory AuthorId.fromJson(Map<String, dynamic> json) => AuthorId(
        id: json["_id"],
        name: json["name"] == null ? null : AuthorIdName.fromJson(json["name"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name?.toJson(),
      };
}

class AuthorIdName {
  String? eng;
  String? kaz;
  String? rus;

  AuthorIdName({
    this.eng,
    this.kaz,
    this.rus,
  });

  factory AuthorIdName.fromJson(Map<String, dynamic> json) => AuthorIdName(
        eng: json["eng"],
        kaz: json["kaz"],
        rus: json["rus"],
      );

  Map<String, dynamic> toJson() => {
        "eng": eng,
        "kaz": kaz,
        "rus": rus,
      };
}

class CategoryId {
  String? id;
  CategoryIdName? name;

  CategoryId({
    this.id,
    this.name,
  });

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["_id"],
        name:
            json["name"] == null ? null : CategoryIdName.fromJson(json["name"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name?.toJson(),
      };
}

class CategoryIdName {
  String? eng;
  String? rus;
  String? kaz;

  CategoryIdName({
    this.eng,
    this.rus,
    this.kaz,
  });

  factory CategoryIdName.fromJson(Map<String, dynamic> json) => CategoryIdName(
        eng: json["eng"],
        rus: json["br"],
        kaz: json["kaz"],
      );

  Map<String, dynamic> toJson() => {
        "eng": eng,
        "br": rus,
        "kaz": kaz,
      };
}

class Description {
  String? kaz;
  String? eng;

  Description({
    this.kaz,
    this.eng,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        kaz: json["kaz"],
        eng: json["eng"],
      );

  Map<String, dynamic> toJson() => {
        "kaz": kaz,
        "eng": eng,
      };
}

class FileClass {
  String? eng;
  String? rus;

  FileClass({
    this.eng,
    this.rus,
  });

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
        eng: json["eng"],
        rus: json["rus"],
      );

  Map<String, dynamic> toJson() => {
        "eng": eng,
        "rus": rus,
      };
}

class PublisherId {
  String? id;
  PublisherIdName? name;

  PublisherId({
    this.id,
    this.name,
  });

  factory PublisherId.fromJson(Map<String, dynamic> json) => PublisherId(
        id: json["_id"],
        name: json["name"] == null
            ? null
            : PublisherIdName.fromJson(json["name"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name?.toJson(),
      };
}

class PublisherIdName {
  String? eng;

  PublisherIdName({
    this.eng,
  });

  factory PublisherIdName.fromJson(Map<String, dynamic> json) =>
      PublisherIdName(
        eng: json["eng"],
      );

  Map<String, dynamic> toJson() => {
        "eng": eng,
      };
}

class NameName {
  String? br;
  String? eng;
  String? rus;

  NameName({
    this.br,
    this.eng,
    this.rus,
  });

  factory NameName.fromJson(Map<String, dynamic> json) => NameName(
        br: json["br"],
        eng: json["eng"],
        rus: json["rus"],
      );

  Map<String, dynamic> toJson() => {
        "br": br,
        "eng": eng,
        "rus": rus,
      };
}
