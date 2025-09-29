class VoucherResponseModel {
  bool? success;
  String? message;
  VoucherData? data;

  VoucherResponseModel({this.success, this.message, this.data});

  VoucherResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new VoucherData.fromJson(json['data']) : null;
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

class VoucherData {
  String? sId;
  String? couponCode;
  num? percentage;
  num? activationAllowed;
  num? codeActivated;
  String? createdAt;
  String? updatedAt;
  int? iV;

  VoucherData(
      {this.sId,
      this.couponCode,
      this.percentage,
      this.activationAllowed,
      this.codeActivated,
      this.createdAt,
      this.updatedAt,
      this.iV});

  VoucherData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    couponCode = json['couponCode'];
    percentage = json['percentage'];
    activationAllowed = json['activationAllowed'];
    codeActivated = json['codeActivated'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['couponCode'] = this.couponCode;
    data['percentage'] = this.percentage;
    data['activationAllowed'] = this.activationAllowed;
    data['codeActivated'] = this.codeActivated;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
