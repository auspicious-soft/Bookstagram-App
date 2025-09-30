import '../../../models/collection_model.dart';
import '../../home_module/models/blog_collection_model.dart';

class SubCategoriesResponseModel {
  bool? success;
  String? message;
  SubCategoriesData? data;
  int? page;
  int? limit;
  int? total;

  SubCategoriesResponseModel(
      {this.success,
      this.message,
      this.data,
      this.page,
      this.limit,
      this.total});

  SubCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new SubCategoriesData.fromJson(json['data'])
        : null;
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    return data;
  }
}

class SubCategoriesData {
  List<SubcategoryLIST>? subcategory;

  SubCategoriesData({this.subcategory});

  SubCategoriesData.fromJson(Map<String, dynamic> json) {
    if (json['subcategory'] != null) {
      subcategory = <SubcategoryLIST>[];
      json['subcategory'].forEach((v) {
        subcategory!.add(new SubcategoryLIST.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubcategoryLIST {
  String? sId;
  Name? name;
  String? image;
  CategoryId? categoryId;
  String? createdAt;
  String? updatedAt;

  SubcategoryLIST(
      {this.sId,
      this.name,
      this.image,
      this.categoryId,
      this.createdAt,
      this.updatedAt});

  SubcategoryLIST.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    image = json['image'];
    categoryId = json['categoryId'] != null
        ? new CategoryId.fromJson(json['categoryId'])
        : null;
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
    if (this.categoryId != null) {
      data['categoryId'] = this.categoryId!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
