import '../../../models/blog_model.dart';
import '../../../models/stock_model.dart';
import 'homeProductModel.dart';

class CollectionDataModel {
  bool? success;
  String? message;
  CollectionMetaData? data;

  CollectionDataModel({this.success, this.message, this.data});

  CollectionDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? CollectionMetaData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['success'] = success;
    dataMap['message'] = message;
    if (data != null) {
      dataMap['data'] = data!.toJson();
    }
    return dataMap;
  }
}


class CollectionMetaData {
  dynamic? page;
  dynamic? limit;
  bool? success;
  String? message;
  dynamic? total;
  CollectionData? data;

  CollectionMetaData({
    this.page,
    this.limit,
    this.success,
    this.message,
    this.total,
    this.data,
  });

  CollectionMetaData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    success = json['success'];
    message = json['message'];
    total = json['total'];
    data = json['data'] != null ? CollectionData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['page'] = page;
    dataMap['limit'] = limit;
    dataMap['success'] = success;
    dataMap['message'] = message;
    dataMap['total'] = total;
    if (data != null) {
      dataMap['data'] = data!.toJson();
    }
    return dataMap;
  }
}


class CollectionData {
  List<MindBlowing>? mindBlowing;
  List<MindBlowing>? popularCollections;
  List<MindBlowing>? newCollections;

  CollectionData({this.mindBlowing, this.popularCollections, this.newCollections});

  CollectionData.fromJson(Map<String, dynamic> json) {
    if (json['mind-blowing'] != null) {
      mindBlowing = [];
      json['mind-blowing'].forEach((v) {
        mindBlowing!.add(MindBlowing.fromJson(v));
      });
    }
    if (json['popular_collections'] != null) {
      popularCollections = [];
      json['popular_collections'].forEach((v) {
        popularCollections!.add(MindBlowing.fromJson(v));
      });
    }
    if (json['new_collections'] != null) {
      newCollections = [];
      json['new_collections'].forEach((v) {
        newCollections!.add(MindBlowing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    if (mindBlowing != null) {
      dataMap['mind-blowing'] = mindBlowing!.map((v) => v.toJson()).toList();
    }
    if (popularCollections != null) {
      dataMap['popular_collections'] =
          popularCollections!.map((v) => v.toJson()).toList();
    }
    if (newCollections != null) {
      dataMap['new_collections'] =
          newCollections!.map((v) => v.toJson()).toList();
    }
    return dataMap;
  }
}


class MindBlowing {
  String? sId;
  Name? name;
  String? image;
  List<BooksId>? booksId;
  bool? displayOnMobile;
  String? createdAt;
  String? updatedAt;

  MindBlowing(
      {this.sId,
        this.name,
        this.image,
        this.booksId,
        this.displayOnMobile,
        this.createdAt,
        this.updatedAt});

  MindBlowing.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    image = json['image'];
    if (json['booksId'] != null) {
      booksId = <BooksId>[];
      json['booksId'].forEach((v) {
        booksId!.add(new BooksId.fromJson(v));
      });
    }
    displayOnMobile = json['displayOnMobile'];
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
    if (this.booksId != null) {
      data['booksId'] = this.booksId!.map((v) => v.toJson()).toList();
    }
    data['displayOnMobile'] = this.displayOnMobile;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}




class BooksId {
  String? sId;
  Name? name;
  Name? description;
  List<AuthorId>? authorId;
  List<CategoryId>? categoryId;

  dynamic? price;
  List<String>? genre;
  String? image;
  Name? file;
  String? type;
  AuthorId? publisherId;
  bool? isDiscounted;
  dynamic? discountPercentage;
  String? createdAt;
  String? updatedAt;
  dynamic? iV;
  dynamic? averageRating;

  BooksId(
      {this.sId,
        this.name,
        this.description,
        this.authorId,
        this.categoryId,

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
        this.iV,
        this.averageRating});

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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    averageRating = json['averageRating'];
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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['averageRating'] = this.averageRating;
    return data;
  }
}



class AuthorId {
  String? sId;
  Name? name;

  AuthorId({this.sId, this.name});

  AuthorId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    return data;
  }
}


class File {
  String? rus;

  File({this.rus});

  File.fromJson(Map<String, dynamic> json) {
    rus = json['rus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rus'] = this.rus;
    return data;
  }
}