// // To parse this JSON data, do
// //
// //     final blogModel = blogModelFromJson(jsonString);
//
// import 'dart:convert';
//
// BlogModel blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));
//
// String blogModelToJson(BlogModel data) => json.encode(data.toJson());
//
// class BlogModel {
//   bool? success;
//   String? message;
//   Data? data;
//
//   BlogModel({
//     this.success,
//     this.message,
//     this.data,
//   });
//
//   factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
//         success: json["success"],
//         message: json["message"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": data?.toJson(),
//       };
// }
//
// class Data {
//   bool? success;
//   String? message;
//   int? page;
//   int? limit;
//   int? total;
//   List<Datum>? data;
//
//   Data({
//     this.success,
//     this.message,
//     this.page,
//     this.limit,
//     this.total,
//     this.data,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         success: json["success"],
//         message: json["message"],
//         page: json["page"],
//         limit: json["limit"],
//         total: json["total"],
//         data: json["data"] == null
//             ? []
//             : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "page": page,
//         "limit": limit,
//         "total": total,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }
//
// class Datum {
//   String? id;
//   Name? name;
//   String? image;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   List<Blog>? blogs;
//
//   Datum({
//     this.id,
//     this.name,
//     this.image,
//     this.createdAt,
//     this.updatedAt,
//     this.blogs,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["_id"],
//
//         image: json["image"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         blogs: json["blogs"] == null
//             ? []
//             : List<Blog>.from(json["blogs"]!.map((x) => Blog.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name?.toJson(),
//         "image": image,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//
//       };
// }
//
// class Blog {
//   String? id;
//
//   String? image;
//   String? name;
//   String? description;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Blog({
//     this.id,
//     this.categoryId,
//     this.image,
//     this.name,
//     this.description,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Blog.fromJson(Map<String, dynamic> json) => Blog(
//         id: json["_id"],
//
//         image: json["image"],
//         name: json["name"],
//         description: json["description"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//       );
//
//
// }
//
//
//
//
//
