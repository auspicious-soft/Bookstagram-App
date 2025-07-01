import 'package:bookstagram/features/data/modules/home_module/models/homeProductModel.dart';

class BooksListModel {
  int? page;
  int? limit;
  String? message;
  bool? success;
  int? total;
  List<BookModel>? data;

  BooksListModel(
      {this.page,
        this.limit,
        this.message,
        this.success,
        this.total,
        this.data});

  BooksListModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    message = json['message'];
    success = json['success'];
    total = json['total'];
    if (json['data'] != null) {
      data = <BookModel>[];
      json['data'].forEach((v) {
        data!.add(new BookModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['message'] = this.message;
    data['success'] = this.success;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}










