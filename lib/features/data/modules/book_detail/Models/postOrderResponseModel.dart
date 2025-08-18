class PostOrderResponseModel {
  bool? success;
  String? message;
  PostOrderData? data;

  PostOrderResponseModel({this.success, this.message, this.data});

  PostOrderResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? new PostOrderData.fromJson(json['data']) : null;
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

class PostOrderData {
  Order? order;
  Payment? payment;

  PostOrderData({this.order, this.payment});

  PostOrderData.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    return data;
  }
}

class Order {
  String? identifier;
  List<String>? productIds;
  String? voucherId;
  String? userId;
  num? totalAmount;
  String? status;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Order(
      {this.identifier,
      this.productIds,
      this.voucherId,
      this.userId,
      this.totalAmount,
      this.status,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Order.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    productIds = json['productIds'].cast<String>();
    voucherId = json['voucherId'];
    userId = json['userId'];
    totalAmount = json['totalAmount'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['productIds'] = this.productIds;
    data['voucherId'] = this.voucherId;
    data['userId'] = this.userId;
    data['totalAmount'] = this.totalAmount;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Payment {
  String? redirectUrl;

  Payment({this.redirectUrl});

  Payment.fromJson(Map<String, dynamic> json) {
    redirectUrl = json['redirect_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['redirect_url'] = this.redirectUrl;
    return data;
  }
}
