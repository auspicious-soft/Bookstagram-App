class AddToCartResponseModel {
  bool? success;
  String? message;
  AddToCartResponseData? data;

  AddToCartResponseModel({this.success, this.message, this.data});

  AddToCartResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new AddToCartResponseData.fromJson(json['data'])
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

class AddToCartResponseData {
  String? userId;
  List<String>? productId;
  String? buyed;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AddToCartResponseData(
      {this.userId,
      this.productId,
      this.buyed,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  AddToCartResponseData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    productId = json['productId'].cast<String>();
    buyed = json['buyed'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['productId'] = this.productId;
    data['buyed'] = this.buyed;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
