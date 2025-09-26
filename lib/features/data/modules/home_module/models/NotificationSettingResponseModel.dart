class NotifificationSettingEnableResponseModel {
  bool? success;
  String? message;
  NotifificationSettingData? data;

  NotifificationSettingEnableResponseModel(
      {this.success, this.message, this.data});

  NotifificationSettingEnableResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new NotifificationSettingData.fromJson(json['data'])
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

class NotifificationSettingData {
  String? sId;
  bool? notificationAllowed;
  String? language;
  List<String>? productsLanguage;

  NotifificationSettingData({
    this.sId,
    this.notificationAllowed,
    this.language,
    this.productsLanguage,
  });

  NotifificationSettingData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    notificationAllowed = json['notificationAllowed'];
    language = json['language'];
    // ✅ safely parse productsLanguage
    if (json['productsLanguage'] != null) {
      productsLanguage = List<String>.from(json['productsLanguage']);
    } else {
      productsLanguage = []; // or keep it null depending on your logic
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = this.sId;
    data['notificationAllowed'] = this.notificationAllowed;
    data['language'] = this.language;
    if (this.productsLanguage != null) {
      data['productsLanguage'] = this.productsLanguage;
    }
    return data;
  }
}
