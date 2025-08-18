class MediaUploadResponse {
  bool? success;
  String? message;
  MediaData? data;

  MediaUploadResponse({this.success, this.message, this.data});

  MediaUploadResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new MediaData.fromJson(json['data']) : null;
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

class MediaData {
  String? imageKey;

  MediaData({this.imageKey});

  MediaData.fromJson(Map<String, dynamic> json) {
    imageKey = json['imageKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageKey'] = this.imageKey;
    return data;
  }
}
