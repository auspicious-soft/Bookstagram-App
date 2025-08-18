class AcheivementResponseModel {
  bool? success;
  String? message;
  List<AcheivementData>? data;

  AcheivementResponseModel({this.success, this.message, this.data});

  AcheivementResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AcheivementData>[];
      json['data'].forEach((v) {
        data!.add(new AcheivementData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AcheivementData {
  String? badge;
  bool? achieved;

  AcheivementData({this.badge, this.achieved});

  AcheivementData.fromJson(Map<String, dynamic> json) {
    badge = json['badge'];
    achieved = json['achieved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['badge'] = this.badge;
    data['achieved'] = this.achieved;
    return data;
  }
}
