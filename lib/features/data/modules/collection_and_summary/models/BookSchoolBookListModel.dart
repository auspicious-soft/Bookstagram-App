import 'package:bookstagram/features/data/modules/bookstudy/models/book_market_response_Model.dart';

class Bookschoolbooklistmodel {
  int? page;
  int? limit;
  bool? success;
  String? message;
  int? total;
  List<ProductId>? data;

  Bookschoolbooklistmodel(
      {this.page,
      this.limit,
      this.success,
      this.message,
      this.total,
      this.data});

  Bookschoolbooklistmodel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    success = json['success'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <ProductId>[];
      json['data'].forEach((v) {
        data!.add(new ProductId.fromJson(v));
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
