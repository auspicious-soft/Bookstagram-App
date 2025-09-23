import '../../bookstudy/models/book_market_response_Model.dart';

class CollectionDetailModel {
  bool? success;
  String? message;
  CollectionDetailData? data;

  CollectionDetailModel({this.success, this.message, this.data});

  CollectionDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new CollectionDetailData.fromJson(json['data'])
        : null;
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

class CollectionDetailData {
  String? sId;
  Name? name;
  String? image;
  List<BooksId>? booksId;
  bool? displayOnMobile;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CollectionDetailData(
      {this.sId,
      this.name,
      this.image,
      this.booksId,
      this.displayOnMobile,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CollectionDetailData.fromJson(Map<String, dynamic> json) {
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
    iV = json['__v'];
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
    data['__v'] = this.iV;
    return data;
  }
}
