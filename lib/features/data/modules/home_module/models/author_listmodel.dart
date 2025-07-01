import 'package:bookstagram/features/data/modules/home_module/models/homeProductModel.dart';

class AuthorListModel {
  bool? success;
  String? message;
  int? page;
  int? limit;
  int? total;
  AutherData? data;

  AuthorListModel(
      {this.success,
        this.message,
        this.page,
        this.limit,
        this.total,
        this.data});

  AuthorListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    data = json['data'] != null ? new AutherData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AutherData {
  List<AuthorModel>? authors;

  AutherData({this.authors});

  AutherData.fromJson(Map<String, dynamic> json) {
    if (json['authors'] != null) {
      authors = <AuthorModel>[];
      json['authors'].forEach((v) {
        authors!.add(new AuthorModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.authors != null) {
      data['authors'] = this.authors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

