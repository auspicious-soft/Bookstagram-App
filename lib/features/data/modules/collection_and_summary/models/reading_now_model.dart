import 'package:bookstagram/features/data/modules/book_detail/Models/bookDetailResponseModel.dart';

import '../../bookstudy/models/book_market_response_Model.dart';

class ReadingNowModel {
  num? page;
  num? limit;
  bool? success;
  String? message;
  num? total;
  List<ReadingNowData>? data;

  ReadingNowModel(
      {this.page,
      this.limit,
      this.success,
      this.message,
      this.total,
      this.data});

  ReadingNowModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    success = json['success'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <ReadingNowData>[];
      json['data'].forEach((v) {
        data!.add(new ReadingNowData.fromJson(v));
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

class ReadingNowData {
  String? sId;
  BookId? bookId;
  String? userId;
  num? iV;

  String? createdAt;
  bool? isCompleted;
  num? progress;

  List<Chapters>? readAudioChapter;

  String? updatedAt;

  ReadingNowData(
      {this.sId,
      this.bookId,
      this.userId,
      this.iV,
      this.createdAt,
      this.isCompleted,
      this.progress,
      this.readAudioChapter,
      this.updatedAt});

  ReadingNowData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bookId =
        json['bookId'] != null ? new BookId.fromJson(json['bookId']) : null;
    userId = json['userId'];
    iV = json['__v'];

    createdAt = json['createdAt'];
    isCompleted = json['isCompleted'];

    progress = json['progress'];
    if (json['readAudioChapter'] != null) {
      readAudioChapter = <Chapters>[];
      json['readAudioChapter'].forEach((v) {
        readAudioChapter!.add(new Chapters.fromJson(v));
      });
    }
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.bookId != null) {
      data['bookId'] = this.bookId!.toJson();
    }
    data['userId'] = this.userId;
    data['__v'] = this.iV;

    data['createdAt'] = this.createdAt;
    data['isCompleted'] = this.isCompleted;

    data['progress'] = this.progress;
    if (this.readAudioChapter != null) {
      data['readAudioChapter'] =
          this.readAudioChapter!.map((v) => v.toJson()).toList();
    }

    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
