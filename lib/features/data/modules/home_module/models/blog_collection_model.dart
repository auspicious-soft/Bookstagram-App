class BlogCollectionModel {
  bool? success;
  String? message;
  BlogData? data;

  BlogCollectionModel({this.success, this.message, this.data});

  BlogCollectionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new BlogData.fromJson(json['data']) : null;
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
    data =
        json['data'] != null ? new BlogDataModel.fromJson(json['data']) : null;
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

class BlogDataModel {
  Blog? blog;
  Blog? news;

  BlogDataModel({this.blog, this.news});

  BlogDataModel.fromJson(Map<String, dynamic> json) {
    blog = json['blog'] != null ? new Blog.fromJson(json['blog']) : null;
    news = json['news'] != null ? new Blog.fromJson(json['news']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blog != null) {
      data['blog'] = this.blog!.toJson();
    }
    if (this.news != null) {
      data['news'] = this.news!.toJson();
    }
    return data;
  }
}

class Blog {
  String? sId;
  Name? name;
  String? image;
  String? createdAt;
  String? updatedAt;
  List<Blogs>? blogs;

  Blog(
      {this.sId,
      this.name,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.blogs});

  Blog.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['blogs'] != null) {
      blogs = <Blogs>[];
      json['blogs'].forEach((v) {
        blogs!.add(new Blogs.fromJson(v));
      });
    }
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
    if (this.blogs != null) {
      data['blogs'] = this.blogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Name {
  String? kaz;
  String? eng;
  String? rus;

  Name({this.kaz, this.eng, this.rus});

  Name.fromJson(Map<String, dynamic> json) {
    kaz = json['kaz'];
    eng = json['eng'];
    rus = json['rus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['kaz'] = kaz;
    data['eng'] = eng;
    data['rus'] = rus;
    return data;
  }

  // Get the name based on the selected language
  String getLocalizedName(String languageCode) {
    switch (languageCode) {
      case 'kaz':
        return kaz ?? eng ?? rus ?? '';
      case 'eng':
        return eng ?? kaz ?? rus ?? '';
      case 'rus':
        return rus ?? eng ?? kaz ?? '';
      default:
        return eng ??
            kaz ??
            rus ??
            ''; // Fallback to English or another default
    }
  }
}

class Blogs {
  String? sId;
  String? categoryId;
  String? image;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;

  Blogs(
      {this.sId,
      this.categoryId,
      this.image,
      this.name,
      this.description,
      this.createdAt,
      this.updatedAt});

  Blogs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryId = json['categoryId'];
    image = json['image'];
    name = json['name'];
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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
