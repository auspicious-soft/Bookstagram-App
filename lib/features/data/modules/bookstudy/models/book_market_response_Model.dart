import '../../home_module/models/CollectionDataModel.dart';
import 'Category_data_model.dart';

class BookMarketResponseModel {
  bool? success;
  String? message;
  BookMarketData? data;

  BookMarketResponseModel({this.success, this.message, this.data});

  BookMarketResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? new BookMarketData.fromJson(json['data']) : null;
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

class BookMarketData {
  List<ReadProgress>? readProgress;
  List<Audiobooks>? audiobooks;
  List<Categories>? categories;
  Collections? collections;
  List<PublisherId>? publisher;
  List<Author>? author;
  List<NewBooks>? newBooks;
  List<BestSellers>? bestSellers;

  BookMarketData(
      {this.readProgress,
      this.audiobooks,
      this.categories,
      this.collections,
      this.publisher,
      this.author,
      this.newBooks,
      this.bestSellers});

  BookMarketData.fromJson(Map<String, dynamic> json) {
    if (json['readProgress'] != null) {
      readProgress = <ReadProgress>[];
      json['readProgress'].forEach((v) {
        readProgress!.add(new ReadProgress.fromJson(v));
      });
    }
    if (json['audiobooks'] != null) {
      audiobooks = <Audiobooks>[];
      json['audiobooks'].forEach((v) {
        audiobooks!.add(new Audiobooks.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    collections = json['collections'] != null
        ? new Collections.fromJson(json['collections'])
        : null;
    if (json['publisher'] != null) {
      publisher = <PublisherId>[];
      json['publisher'].forEach((v) {
        publisher!.add(new PublisherId.fromJson(v));
      });
    }
    if (json['author'] != null) {
      author = <Author>[];
      json['author'].forEach((v) {
        author!.add(new Author.fromJson(v));
      });
    }
    if (json['newBooks'] != null) {
      newBooks = <NewBooks>[];
      json['newBooks'].forEach((v) {
        newBooks!.add(new NewBooks.fromJson(v));
      });
    }
    if (json['bestSellers'] != null) {
      bestSellers = <BestSellers>[];
      json['bestSellers'].forEach((v) {
        bestSellers!.add(new BestSellers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.readProgress != null) {
      data['readProgress'] = this.readProgress!.map((v) => v.toJson()).toList();
    }
    if (this.audiobooks != null) {
      data['audiobooks'] = this.audiobooks!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.collections != null) {
      data['collections'] = this.collections!.toJson();
    }
    if (this.publisher != null) {
      data['publisher'] = this.publisher!.map((v) => v.toJson()).toList();
    }
    if (this.author != null) {
      data['author'] = this.author!.map((v) => v.toJson()).toList();
    }
    if (this.newBooks != null) {
      data['newBooks'] = this.newBooks!.map((v) => v.toJson()).toList();
    }
    if (this.bestSellers != null) {
      data['bestSellers'] = this.bestSellers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReadProgress {
  String? sId;
  String? userId;
  BookId? bookId;
  num? progress;

  ReadProgress({this.sId, this.userId, this.bookId, this.progress});

  ReadProgress.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    bookId =
        json['bookId'] != null ? new BookId.fromJson(json['bookId']) : null;
    progress = json['progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    if (this.bookId != null) {
      data['bookId'] = this.bookId!.toJson();
    }
    data['progress'] = this.progress;
    return data;
  }
}

class BookId {
  String? sId;
  Name? name;
  List<AuthorId>? authorId;
  String? image;
  String? type;

  BookId({this.sId, this.name, this.authorId, this.image, this.type});

  BookId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    if (json['authorId'] != null) {
      authorId = <AuthorId>[];
      json['authorId'].forEach((v) {
        authorId!.add(new AuthorId.fromJson(v));
      });
    }
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    if (this.authorId != null) {
      data['authorId'] = this.authorId!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['type'] = this.type;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eng'] = this.eng;
    data['kaz'] = this.kaz;
    data['rus'] = this.rus;
    return data;
  }
}

class Audiobooks {
  String? sId;
  String? lang;
  String? name;
  ProductId? productId;
  num? srNo;
  String? file;
  num? iV;
  String? createdAt;
  String? updatedAt;

  Audiobooks(
      {this.sId,
      this.lang,
      this.name,
      this.productId,
      this.srNo,
      this.file,
      this.iV,
      this.createdAt,
      this.updatedAt});

  Audiobooks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    lang = json['lang'];
    name = json['name'];
    productId = json['productId'] != null
        ? new ProductId.fromJson(json['productId'])
        : null;
    srNo = json['srNo'];
    file = json['file'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['lang'] = this.lang;
    data['name'] = this.name;
    if (this.productId != null) {
      data['productId'] = this.productId!.toJson();
    }
    data['srNo'] = this.srNo;
    data['file'] = this.file;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class ProductId {
  String? sId;
  Name? name;
  Name? description;
  List<AuthorId>? authorId;
  List<CategoryId>? categoryId;
  List<SubCategoryId>? subCategoryId;
  int? price;
  List<String>? genre;
  String? image;
  Null? file;
  String? type;
  AuthorId? publisherId;
  bool? isDiscounted;
  int? discountPercentage;
  int? averageRating;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ProductId(
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

  ProductId.fromJson(Map<String, dynamic> json) {
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
        ? new AuthorId.fromJson(json['publisherId'])
        : null;
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

  CategoryId(
      {this.sId,
      this.image,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['image'] = this.image;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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

  SubCategoryId(
      {this.sId,
      this.name,
      this.image,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  SubCategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    image = json['image'];
    categoryId = json['categoryId'];
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
    data['image'] = this.image;
    data['categoryId'] = this.categoryId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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

  PublisherId(
      {this.sId,
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
      this.iV});

  PublisherId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    role = json['role'];
    categoryId = json['categoryId'].cast<String>();
    email = json['email'];
    password = json['password'];
    description = json['description'] != null
        ? new Name.fromJson(json['description'])
        : null;
    country = json['country'];
    image = json['image'];
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
    data['role'] = this.role;
    data['categoryId'] = this.categoryId;
    data['email'] = this.email;
    data['password'] = this.password;
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    data['country'] = this.country;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Description {
  String? eng;
  String? kaz;
  String? rus;

  Description({this.eng, this.kaz, this.rus});

  Description.fromJson(Map<String, dynamic> json) {
    eng = json['eng'];
    kaz = json['kaz'];
    rus = json['rus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eng'] = this.eng;
    data['kaz'] = this.kaz;
    data['rus'] = this.rus;
    return data;
  }
}

class Collections {
  int? page;
  int? limit;
  bool? success;
  String? message;
  int? total;
  CollectionsData? data;

  Collections(
      {this.page,
      this.limit,
      this.success,
      this.message,
      this.total,
      this.data});

  Collections.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    success = json['success'];
    message = json['message'];
    total = json['total'];
    data = json['data'] != null
        ? new CollectionsData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['success'] = this.success;
    data['message'] = this.message;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CollectionsData {
  List<MindBlowing>? mindBlowing;
  List<MindBlowing>? popularCollections;
  List<MindBlowing>? newCollections;

  CollectionsData(
      {this.mindBlowing, this.popularCollections, this.newCollections});

  CollectionsData.fromJson(Map<String, dynamic> json) {
    if (json['mind-blowing'] != null) {
      mindBlowing = <MindBlowing>[];
      json['mind-blowing'].forEach((v) {
        mindBlowing!.add(new MindBlowing.fromJson(v));
      });
    }
    if (json['popular_collections'] != null) {
      popularCollections = <MindBlowing>[];
      json['popular_collections'].forEach((v) {
        popularCollections!.add(new MindBlowing.fromJson(v));
      });
    }
    if (json['new_collections'] != null) {
      newCollections = <MindBlowing>[];
      json['new_collections'].forEach((v) {
        newCollections!.add(new MindBlowing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mindBlowing != null) {
      data['mind-blowing'] = this.mindBlowing!.map((v) => v.toJson()).toList();
    }
    if (this.popularCollections != null) {
      data['popular_collections'] =
          this.popularCollections!.map((v) => v.toJson()).toList();
    }
    if (this.newCollections != null) {
      data['new_collections'] =
          this.newCollections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BooksId {
  String? sId;
  Name? name;
  Name? description;
  List<AuthorId>? authorId;
  List<CategoryId>? categoryId;
  List<SubCategoryId>? subCategoryId;
  int? price;
  List<String>? genre;
  String? image;
  Name? file;
  String? type;
  AuthorId? publisherId;
  bool? isDiscounted;
  num? discountPercentage;
  num? averageRating;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BooksId(
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

  BooksId.fromJson(Map<String, dynamic> json) {
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
    file = json['file'] != null ? new Name.fromJson(json['file']) : null;
    type = json['type'];
    publisherId = json['publisherId'] != null
        ? new AuthorId.fromJson(json['publisherId'])
        : null;
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
    if (this.file != null) {
      data['file'] = this.file!.toJson();
    }
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
    return data;
  }
}

class AuthorId {
  String? sId;
  Name? name;
  String? image;

  AuthorId({this.sId, this.name, this.image});

  AuthorId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['image'] = this.image;
    return data;
  }
}

class Author {
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

  Author(
      {this.sId,
      this.name,
      this.profession,
      this.country,
      this.dob,
      this.genres,
      this.image,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Author.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    profession = json['profession'].cast<String>();
    country = json['country'];
    dob = json['dob'];
    genres = json['genres'].cast<String>();
    image = json['image'];
    description = json['description'] != null
        ? new Name.fromJson(json['description'])
        : null;
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
    data['profession'] = this.profession;
    data['country'] = this.country;
    data['dob'] = this.dob;
    data['genres'] = this.genres;
    data['image'] = this.image;
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class NewBooks {
  String? sId;
  Name? name;
  Name? description;
  List<AuthorId>? authorId;
  List<CategoryId>? categoryId;
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

  NewBooks(
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

  NewBooks.fromJson(Map<String, dynamic> json) {
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
    if (this.categoryId != null) {
      data['categoryId'] = this.categoryId!.map((v) => v.toJson()).toList();
    }
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

class BestSellers {
  int? orderCount;
  Book? book;

  BestSellers({this.orderCount, this.book});

  BestSellers.fromJson(Map<String, dynamic> json) {
    orderCount = json['orderCount'];
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderCount'] = this.orderCount;
    if (this.book != null) {
      data['book'] = this.book!.toJson();
    }
    return data;
  }
}

class Book {
  String? sId;
  Name? name;
  Name? description;
  List<String>? authorId;
  List<String>? categoryId;
  List<String>? subCategoryId;
  int? price;
  List<String>? genre;
  String? image;
  Null? file;
  String? type;
  String? publisherId;
  bool? isDiscounted;
  int? discountPercentage;
  int? averageRating;
  String? createdAt;
  String? updatedAt;
  int? iV;
  Author? authors;

  Book(
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
      this.authors});

  Book.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    description = json['description'] != null
        ? new Name.fromJson(json['description'])
        : null;
    authorId = json['authorId'].cast<String>();
    categoryId = json['categoryId'].cast<String>();
    subCategoryId = json['subCategoryId'].cast<String>();
    price = json['price'];
    genre = json['genre'].cast<String>();
    image = json['image'];
    file = json['file'];
    type = json['type'];
    publisherId = json['publisherId'];
    isDiscounted = json['isDiscounted'];
    discountPercentage = json['discountPercentage'];
    averageRating = json['averageRating'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    authors =
        json['authors'] != null ? new Author.fromJson(json['authors']) : null;
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
    data['authorId'] = this.authorId;
    data['categoryId'] = this.categoryId;
    data['subCategoryId'] = this.subCategoryId;
    data['price'] = this.price;
    data['genre'] = this.genre;
    data['image'] = this.image;
    data['file'] = this.file;
    data['type'] = this.type;
    data['publisherId'] = this.publisherId;
    data['isDiscounted'] = this.isDiscounted;
    data['discountPercentage'] = this.discountPercentage;
    data['averageRating'] = this.averageRating;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.authors != null) {
      data['authors'] = this.authors!.toJson();
    }
    return data;
  }
}
