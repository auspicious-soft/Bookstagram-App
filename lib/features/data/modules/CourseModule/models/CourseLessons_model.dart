class CourseLessonsModel {
  bool? success;
  String? message;
  num? page;
  num? limit;
  num? total;
  CourseLessonData? data;

  CourseLessonsModel(
      {this.success,
      this.message,
      this.page,
      this.limit,
      this.total,
      this.data});

  CourseLessonsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    data = json['data'] != null
        ? new CourseLessonData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CourseLessonData {
  List<CourseLessons>? courseLessons;
  num? reviewCount;
  bool? isFavorite;
  bool? isPurchased;
  bool? certificateAvailable;
  bool? courseCompleted;

  CourseLessonData(
      {this.courseLessons,
      this.reviewCount,
      this.isFavorite,
      this.certificateAvailable,
      this.courseCompleted,
      this.isPurchased});

  CourseLessonData.fromJson(Map<String, dynamic> json) {
    if (json['courseLessons'] != null) {
      courseLessons = <CourseLessons>[];
      json['courseLessons'].forEach((v) {
        courseLessons!.add(new CourseLessons.fromJson(v));
      });
    }
    reviewCount = json['reviewCount'];
    isFavorite = json['isFavorite'];
    courseCompleted = json['courseCompleted'];
    certificateAvailable = json['certificateAvailable'];
    isPurchased = json['isPurchased'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseLessons != null) {
      data['courseLessons'] =
          this.courseLessons!.map((v) => v.toJson()).toList();
    }
    data['reviewCount'] = this.reviewCount;
    data['isFavorite'] = this.isFavorite;
    data['courseCompleted'] = this.courseCompleted;
    data['certificateAvailable'] = this.certificateAvailable;
    data['isPurchased'] = this.isPurchased;
    return data;
  }
}

class CourseLessons {
  String? sId;
  String? lang;
  String? name;
  String? productId;
  num? srNo;
  List<SubLessons>? subLessons;
  num? iV;
  bool? isOpen;

  String? createdAt;
  String? updatedAt;

  CourseLessons(
      {this.sId,
      this.lang,
      this.name,
      this.isOpen,
      this.productId,
      this.srNo,
      this.subLessons,
      this.iV,
      this.createdAt,
      this.updatedAt});

  CourseLessons.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    lang = json['lang'];
    name = json['name'];
    productId = json['productId'];
    isOpen = json['isOpen'];
    srNo = json['srNo'];
    if (json['subLessons'] != null) {
      subLessons = <SubLessons>[];
      json['subLessons'].forEach((v) {
        subLessons!.add(new SubLessons.fromJson(v));
      });
    }
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['lang'] = this.lang;
    data['name'] = this.name;
    data['isOpen'] = this.isOpen;
    data['productId'] = this.productId;
    data['srNo'] = this.srNo;
    if (this.subLessons != null) {
      data['subLessons'] = this.subLessons!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class SubLessons {
  String? name;
  String? description;
  num? srNo;
  String? file;
  List<AdditionalFiles>? additionalFiles;
  List<Links>? links;
  String? sId;
  bool? isDone;

  SubLessons(
      {this.name,
      this.description,
      this.srNo,
      this.file,
      this.additionalFiles,
      this.links,
      this.sId,
      this.isDone});

  SubLessons.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    srNo = json['srNo'];
    file = json['file'];
    if (json['additionalFiles'] != null) {
      additionalFiles = <AdditionalFiles>[];
      json['additionalFiles'].forEach((v) {
        additionalFiles!.add(new AdditionalFiles.fromJson(v));
      });
    }
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    sId = json['_id'];
    isDone = json['isDone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['srNo'] = this.srNo;
    data['file'] = this.file;
    if (this.additionalFiles != null) {
      data['additionalFiles'] =
          this.additionalFiles!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['isDone'] = this.isDone;
    return data;
  }
}

class AdditionalFiles {
  String? file;
  String? name;

  AdditionalFiles({this.file, this.name});

  AdditionalFiles.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    data['name'] = this.name;
    return data;
  }
}

class Links {
  String? url;
  String? name;

  Links({this.url, this.name});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    return data;
  }
}
