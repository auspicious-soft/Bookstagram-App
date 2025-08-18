class BlogCollectionModel {
  bool? success;
  String? message;
  BlogData? data;

  BlogCollectionModel({this.success, this.message, this.data});

  BlogCollectionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? BlogData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BlogData {
  bool? success;
  String? message;
  int? page;
  int? limit;
  int? total;
  BlogDataModel? data;

  BlogData(
      {this.success,
      this.message,
      this.page,
      this.limit,
      this.total,
      this.data});

  BlogData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    data = json['data'] != null ? BlogDataModel.fromJson(json['data']) : null;
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

class BlogDataModel {
  List<Category>? categories;
  List<Blog>? blogs;

  BlogDataModel({this.categories, this.blogs});

  BlogDataModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
    if (json['blogs'] != null) {
      blogs = <Blog>[];
      json['blogs'].forEach((v) {
        blogs!.add(Blog.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (blogs != null) {
      data['blogs'] = blogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? sId;
  Name? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  Category({this.sId, this.name, this.image, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Name {
  String? eng;
  String? kaz;
  String? rus;

  Name({this.eng, this.kaz, this.rus});

  Name.fromJson(Map<String, dynamic> json) {
    eng = json['eng'];
    kaz = json['kaz'];
    rus = json['rus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eng'] = eng;
    data['kaz'] = kaz;
    data['rus'] = rus;
    return data;
  }

  String getLocalizedName(String languageCode) {
    switch (languageCode) {
      case 'kaz':
        return kaz ?? eng ?? rus ?? '';
      case 'eng':
        return eng ?? kaz ?? rus ?? '';
      case 'rus':
        return rus ?? eng ?? kaz ?? '';
      default:
        return eng ?? kaz ?? rus ?? '';
    }
  }
}

class Blog {
  String? sId;
  String? categoryId;
  String? image;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;

  Blog({
    this.sId,
    this.categoryId,
    this.image,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  Blog.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryId = json['categoryId'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['categoryId'] = categoryId;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
