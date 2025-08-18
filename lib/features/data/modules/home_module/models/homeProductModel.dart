class ResponseModel {
  final bool success;
  final dynamic message;
  final DataModel data;

  ResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null
          ? DataModel.fromJson(json['data'])
          : DataModel.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    data['data'] = this.data.toJson();
    return data;
  }
}

class DataModel {
  final dynamic message;
  final DataBooksAndCourses data;

  DataModel({
    required this.message,
    required this.data,
  });

  factory DataModel.empty() {
    return DataModel(
      message: '',
      data: DataBooksAndCourses(books: [], courses: []),
    );
  }

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      message: json['message'],
      data: json['data'] != null
          ? DataBooksAndCourses.fromJson(json['data'])
          : DataBooksAndCourses(books: [], courses: []),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    data['data'] = this.data.toJson();
    return data;
  }
}

class DataBooksAndCourses {
  final List<BookModel>? books;
  final List<CourseModel>? courses;

  DataBooksAndCourses({this.books, this.courses});

  factory DataBooksAndCourses.fromJson(Map<String, dynamic> json) {
    return DataBooksAndCourses(
      books: json['Books'] != null
          ? List<BookModel>.from(
              json['Books'].map((v) => BookModel.fromJson(v)))
          : [],
      courses: json['Courses'] != null
          ? List<CourseModel>.from(
              json['Courses'].map((v) => CourseModel.fromJson(v)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (books != null && books!.isNotEmpty) {
      data['Books'] = books!.map((v) => v.toJson()).toList();
    }
    if (courses != null && courses!.isNotEmpty) {
      data['Courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookModel {
  String? sId;
  Name? name;
  Name? description;
  List<AuthorModel>? authors;
  List<CategoryId>? categoryId;
  List<SubCategoryId>? subCategoryId;
  num? price;
  List<String>? genre;
  String? image;
  Name? file;
  String? type;
  PublisherId? publisherId;
  bool? isDiscounted;
  num? discountPercentage;
  num? averageRating;
  String? createdAt;
  String? updatedAt;

  BookModel({
    this.sId,
    this.name,
    this.description,
    this.authors,
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
  });

  BookModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    description =
        json['description'] != null ? Name.fromJson(json['description']) : null;
    if (json['authorId'] != null) {
      authors = <AuthorModel>[];
      json['authorId'].forEach((v) {
        authors!.add(AuthorModel.fromJson(v));
      });
    }
    if (json['categoryId'] != null) {
      categoryId = <CategoryId>[];
      json['categoryId'].forEach((v) {
        categoryId!.add(CategoryId.fromJson(v));
      });
    }
    if (json['subCategoryId'] != null) {
      subCategoryId = <SubCategoryId>[];
      json['subCategoryId'].forEach((v) {
        subCategoryId!.add(SubCategoryId.fromJson(v));
      });
    }
    price = json['price'];
    genre = json['genre']?.cast<String>();
    image = json['image'];
    file = json['file'] != null ? Name.fromJson(json['file']) : null;
    type = json['type'];
    publisherId = json['publisherId'] != null
        ? PublisherId.fromJson(json['publisherId'])
        : null;
    isDiscounted = json['isDiscounted'];
    discountPercentage = json['discountPercentage'];
    averageRating = json['averageRating'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (description != null) {
      data['description'] = description!.toJson();
    }
    if (authors != null) {
      data['authorId'] = authors!.map((v) => v.toJson()).toList();
    }
    if (categoryId != null) {
      data['categoryId'] = categoryId!.map((v) => v.toJson()).toList();
    }
    if (subCategoryId != null) {
      data['subCategoryId'] = subCategoryId!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['genre'] = genre;
    data['image'] = image;
    if (file != null) {
      data['file'] = file!.toJson();
    }
    data['type'] = type;
    if (publisherId != null) {
      data['publisherId'] = publisherId!.toJson();
    }
    data['isDiscounted'] = isDiscounted;
    data['discountPercentage'] = discountPercentage;
    data['averageRating'] = averageRating;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class CourseModel {
  String? sId;
  Name? name;
  Name? description;
  List<AuthorModel>? authorId;
  List<CategoryId>? categoryId;
  List<SubCategoryId>? subCategoryId;
  num? price;
  List<String>? genre;
  String? image;
  Name? file;
  String? type;
  PublisherId? publisherId;
  bool? isDiscounted;
  num? discountPercentage;
  num? averageRating;
  String? createdAt;
  String? updatedAt;

  CourseModel({
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
    this.averageRating,
    this.createdAt,
    this.updatedAt,
  });

  CourseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    description =
        json['description'] != null ? Name.fromJson(json['description']) : null;
    if (json['authorId'] != null) {
      authorId = <AuthorModel>[];
      json['authorId'].forEach((v) {
        authorId!.add(AuthorModel.fromJson(v));
      });
    }
    if (json['categoryId'] != null) {
      categoryId = <CategoryId>[];
      json['categoryId'].forEach((v) {
        categoryId!.add(CategoryId.fromJson(v));
      });
    }
    if (json['subCategoryId'] != null) {
      subCategoryId = <SubCategoryId>[];
      json['subCategoryId'].forEach((v) {
        subCategoryId!.add(SubCategoryId.fromJson(v));
      });
    }
    price = json['price'];
    genre = json['genre']?.cast<String>();
    image = json['image'];
    file = json['file'] != null ? Name.fromJson(json['file']) : null;
    type = json['type'];
    publisherId = json['publisherId'] != null
        ? PublisherId.fromJson(json['publisherId'])
        : null;
    isDiscounted = json['isDiscounted'];
    discountPercentage = json['discountPercentage'];
    averageRating = json['averageRating'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
    if (subCategoryId != null) {
      data['subCategoryId'] = subCategoryId!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['genre'] = genre;
    data['image'] = image;
    if (file != null) {
      data['file'] = file!.toJson();
    }
    data['type'] = type;
    if (publisherId != null) {
      data['publisherId'] = publisherId!.toJson();
    }
    data['isDiscounted'] = isDiscounted;
    data['discountPercentage'] = discountPercentage;
    data['averageRating'] = averageRating;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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

class AuthorModel {
  String? sId;
  Name? name;
  List<String>? profession;
  String? country;
  String? dob;
  List<String>? genres;
  String? image;
  Name? description;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AuthorModel({
    this.sId,
    this.name,
    this.profession,
    this.country,
    this.dob,
    this.genres,
    this.image,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  AuthorModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    profession = json['profession']?.cast<String>();
    country = json['country'];
    dob = json['dob'];
    genres = json['genres']?.cast<String>();
    image = json['image'];
    description =
        json['description'] != null ? Name.fromJson(json['description']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['profession'] = profession;
    data['country'] = country;
    data['dob'] = dob;
    data['genres'] = genres;
    data['image'] = image;
    if (description != null) {
      data['description'] = description!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class CategoryId {
  String? sId;
  String? image;
  Name? name;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CategoryId({
    this.sId,
    this.image,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  CategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['image'] = image;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class SubCategoryId {
  String? sId;
  Name? name;
  String? image;
  String? categoryId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SubCategoryId({
    this.sId,
    this.name,
    this.image,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  SubCategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    image = json['image | null'];
    categoryId = json['categoryId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['image'] = image;
    data['categoryId'] = categoryId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class PublisherId {
  String? sId;
  Name? name;
  String? role;
  List<String>? categoryId;
  String? email;
  String? password;
  Name? description;
  String? country;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PublisherId({
    this.sId,
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
    this.iV,
  });

  PublisherId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    role = json['role'];
    categoryId = json['categoryId']?.cast<String>();
    email = json['email'];
    password = json['password'];
    description =
        json['description'] != null ? Name.fromJson(json['description']) : null;
    country = json['country'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['role'] = role;
    data['categoryId'] = categoryId;
    data['email'] = email;
    data['password'] = password;
    if (description != null) {
      data['description'] = description!.toJson();
    }
    data['country'] = country;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
