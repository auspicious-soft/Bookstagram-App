import '../../bookstudy/models/book_market_response_Model.dart';

class progressReadResponseModel {
  bool? success;
  String? message;

  progressReadResponseModel({this.success, this.message});

  progressReadResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;

    return data;
  }
}
