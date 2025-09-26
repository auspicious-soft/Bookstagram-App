class walletHistoryResponseModel {
  bool? success;
  String? message;
  WalletHistoryData? data;

  walletHistoryResponseModel({this.success, this.message, this.data});

  walletHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new WalletHistoryData.fromJson(json['data'])
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

class WalletHistoryData {
  num? wallet;
  List<History>? history;

  WalletHistoryData({this.wallet, this.history});

  WalletHistoryData.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(new History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet'] = this.wallet;
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  String? sId;
  String? userId;
  HistoryOrderId? orderId;
  String? points;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? iV;

  History(
      {this.sId,
      this.userId,
      this.orderId,
      this.points,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.iV});

  History.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    orderId = json['orderId'] != null
        ? new HistoryOrderId.fromJson(json['orderId'])
        : null;
    points = json['points'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['orderId'] = this.orderId;
    data['points'] = this.points;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class HistoryOrderId {
  String? sId;
  String? identifier;
  List<String>? productIds;
  String? userId;
  num? totalAmount;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  num? paymentAmount;
  String? paymentCompletedAt;
  String? paymentMethod;
  String? transactionId;

  HistoryOrderId(
      {this.sId,
      this.identifier,
      this.productIds,
      this.userId,
      this.totalAmount,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.paymentAmount,
      this.paymentCompletedAt,
      this.paymentMethod,
      this.transactionId});

  HistoryOrderId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    identifier = json['identifier'];
    productIds = json['productIds'].cast<String>();
    userId = json['userId'];
    totalAmount = json['totalAmount'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    paymentAmount = json['paymentAmount'];
    paymentCompletedAt = json['paymentCompletedAt'];
    paymentMethod = json['paymentMethod'];
    transactionId = json['transactionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['identifier'] = this.identifier;
    data['productIds'] = this.productIds;
    data['userId'] = this.userId;
    data['totalAmount'] = this.totalAmount;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['paymentAmount'] = this.paymentAmount;
    data['paymentCompletedAt'] = this.paymentCompletedAt;
    data['paymentMethod'] = this.paymentMethod;
    data['transactionId'] = this.transactionId;
    return data;
  }
}
