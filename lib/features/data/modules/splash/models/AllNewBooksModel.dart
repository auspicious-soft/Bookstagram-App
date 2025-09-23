import '../../bookstudy/models/book_market_response_Model.dart';
import '../../bookstudy/models/categoryGetBy_id_model.dart' show File;

// Top-level response model
class AllNewbooksResponseModel {
  bool? success;
  String? message;
  num? page;
  num? limit;
  int? total;
  AllNewBooksData? data;

  AllNewbooksResponseModel({
    this.success,
    this.message,
    this.page,
    this.limit,
    this.total,
    this.data,
  });

  AllNewbooksResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
    page = json['page'] as num?;
    limit = json['limit'] as num?;
    total = json['total'] as int?;
    data = json['data'] != null
        ? AllNewBooksData.fromJson(json['data'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

// Data container for audiobooks
class AllNewBooksData {
  List<NewBooks>? newBooks;

  AllNewBooksData({this.newBooks});

  AllNewBooksData.fromJson(Map<String, dynamic> json) {
    if (json['newBooks'] != null) {
      newBooks = <NewBooks>[];
      json['newBooks'].forEach((v) {
        newBooks!.add(NewBooks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (newBooks != null) {
      data['newBooks'] = newBooks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
