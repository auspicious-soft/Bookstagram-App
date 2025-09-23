import '../../bookstudy/models/book_market_response_Model.dart';

class BestSellerResponseModel {
  bool? success;
  String? message;
  List<BestSellers>? data;

  BestSellerResponseModel({this.success, this.message, this.data});

  BestSellerResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BestSellers>[];
      json['data'].forEach((v) {
        data!.add(new BestSellers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
