import 'package:bookstagram/features/data/modules/bookstudy/models/book_market_response_Model.dart';

class FavuriteBooksModel {
  int? page;
  int? limit;
  bool? success;
  String? message;
  int? total;
  List<FavouriteData>? data;

  FavuriteBooksModel(
      {this.page,
      this.limit,
      this.success,
      this.message,
      this.total,
      this.data});

  FavuriteBooksModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    success = json['success'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <FavouriteData>[];
      json['data'].forEach((v) {
        data!.add(new FavouriteData.fromJson(v));
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

class FavouriteData {
  String? sId;
  ProductId? productId;
  String? userId;
  int? iV;
  String? createdAt;
  String? updatedAt;

  FavouriteData(
      {this.sId,
      this.productId,
      this.userId,
      this.iV,
      this.createdAt,
      this.updatedAt});

  FavouriteData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['productId'] != null
        ? new ProductId.fromJson(json['productId'])
        : null;
    userId = json['userId'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.productId != null) {
      data['productId'] = this.productId!.toJson();
    }
    data['userId'] = this.userId;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
