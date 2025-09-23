import '../../bookstudy/models/book_market_response_Model.dart';

class AllCollectionsModel {
  num? page;
  num? limit;
  bool? success;
  String? message;
  num? total;
  List<GetAllCollectionData>? data;

  AllCollectionsModel(
      {this.page,
      this.limit,
      this.success,
      this.message,
      this.total,
      this.data});

  AllCollectionsModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    success = json['success'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <GetAllCollectionData>[];
      json['data'].forEach((v) {
        data!.add(new GetAllCollectionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['success'] = this.success;
    data['message'] = this.message;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAllCollectionData {
  String? sId;
  Name? name;
  String? image;
  List<BooksId>? booksId;
  bool? displayOnMobile;
  String? createdAt;
  String? updatedAt;

  GetAllCollectionData(
      {this.sId,
      this.name,
      this.image,
      this.booksId,
      this.displayOnMobile,
      this.createdAt,
      this.updatedAt});

  GetAllCollectionData.fromJson(Map<String, dynamic> json) {
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
