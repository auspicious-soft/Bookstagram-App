class GetNotificationResponseModel {
  bool? success;
  String? message;
  List<NotificationsData>? data;

  GetNotificationResponseModel({this.success, this.message, this.data});

  GetNotificationResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationsData>[];
      json['data'].forEach((v) {
        data!.add(new NotificationsData.fromJson(v));
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

class NotificationsData {
  ReferenceId? referenceId;
  String? sId;
  List<String>? userIds;
  String? title;
  String? description;
  bool? isRead;
  String? type;
  String? language;
  String? date;
  String? createdAt;
  String? updatedAt;

  NotificationsData(
      {this.referenceId,
      this.sId,
      this.userIds,
      this.title,
      this.description,
      this.isRead,
      this.type,
      this.language,
      this.date,
      this.createdAt,
      this.updatedAt});

  NotificationsData.fromJson(Map<String, dynamic> json) {
    referenceId = json['referenceId'] != null
        ? new ReferenceId.fromJson(json['referenceId'])
        : null;
    sId = json['_id'];
    userIds = json['userIds'].cast<String>();
    title = json['title'];
    description = json['description'];
    isRead = json['isRead'];
    type = json['type'];
    language = json['language'];
    date = json['date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.referenceId != null) {
      data['referenceId'] = this.referenceId!.toJson();
    }
    data['_id'] = this.sId;
    data['userIds'] = this.userIds;
    data['title'] = this.title;
    data['description'] = this.description;
    data['isRead'] = this.isRead;
    data['type'] = this.type;
    data['language'] = this.language;
    data['date'] = this.date;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class ReferenceId {
  String? authorId;

  ReferenceId({this.authorId});

  ReferenceId.fromJson(Map<String, dynamic> json) {
    authorId = json['authorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authorId'] = this.authorId;
    return data;
  }
}
