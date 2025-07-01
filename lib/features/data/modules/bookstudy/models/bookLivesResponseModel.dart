import '../../home_module/models/blog_collection_model.dart';

class BookLivesResponseModel {
  bool? success;
  String? message;
  num? page;
  num? limit;
  int? total;
  BookLivesData? data;

  BookLivesResponseModel(
      {this.success,
      this.message,
      this.page,
      this.limit,
      this.total,
      this.data});

  BookLivesResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    data =
        json['data'] != null ? new BookLivesData.fromJson(json['data']) : null;
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

class BookLivesData {
  List<Categories>? categories;
  List<Blogs>? blogs;

  BookLivesData({this.categories, this.blogs});

  BookLivesData.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['blogs'] != null) {
      blogs = <Blogs>[];
      json['blogs'].forEach((v) {
        blogs!.add(new Blogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.blogs != null) {
      data['blogs'] = this.blogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? sId;
  Name? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  Categories({this.sId, this.name, this.image, this.createdAt, this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Blogs {
  String? sId;
  String? categoryId;
  String? image;
  String? name;
  String? description;
  String? shortDescription;
  String? createdAt;
  String? updatedAt;

  Blogs(
      {this.sId,
      this.categoryId,
      this.image,
      this.name,
      this.description,
      this.shortDescription,
      this.createdAt,
      this.updatedAt});

  Blogs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryId = json['categoryId'];
    image = json['image'];
    name = json['name'];
    shortDescription = json['shortDescription'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['categoryId'] = this.categoryId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    data['shortDescription'] = this.shortDescription;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
