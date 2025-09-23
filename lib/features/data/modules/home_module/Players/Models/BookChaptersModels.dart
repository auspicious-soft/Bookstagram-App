class AudioBookChapters {
  bool? success;
  String? message;
  AudioBookChaptersData? data;

  AudioBookChapters({this.success, this.message, this.data});

  AudioBookChapters.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new AudioBookChaptersData.fromJson(json['data'])
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

class AudioBookChaptersData {
  List<Chapter>? chapter;

  AudioBookChaptersData({this.chapter});

  AudioBookChaptersData.fromJson(Map<String, dynamic> json) {
    if (json['chapter'] != null) {
      chapter = <Chapter>[];
      json['chapter'].forEach((v) {
        chapter!.add(new Chapter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chapter != null) {
      data['chapter'] = this.chapter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapter {
  String? sId;
  String? lang;
  String? name;
  String? productId;
  num? srNo;
  String? file;
  num? iV;
  String? createdAt;
  String? updatedAt;
  bool? isRead;

  Chapter(
      {this.sId,
      this.lang,
      this.name,
      this.productId,
      this.srNo,
      this.file,
      this.iV,
      this.createdAt,
      this.updatedAt,
      this.isRead});

  Chapter.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    lang = json['lang'];
    name = json['name'];
    productId = json['productId'];
    srNo = json['srNo'];
    file = json['file'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['lang'] = this.lang;
    data['name'] = this.name;
    data['productId'] = this.productId;
    data['srNo'] = this.srNo;
    data['file'] = this.file;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isRead'] = this.isRead;
    return data;
  }
}
