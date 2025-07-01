class BookEventsResponseModel {
  int? page;
  int? limit;
  bool? success;
  String? message;
  int? total;
  List<BookEventData>? data;

  BookEventsResponseModel(
      {this.page,
      this.limit,
      this.success,
      this.message,
      this.total,
      this.data});

  BookEventsResponseModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    success = json['success'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <BookEventData>[];
      json['data'].forEach((v) {
        data!.add(new BookEventData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['success'] = this.success;
    data['message'] = this.message;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookEventData {
  String? sId;
  String? identifier;
  String? image;
  String? name;
  String? shortDescription;
  String? description;
  String? createdAt;
  String? updatedAt;

  BookEventData(
      {this.sId,
      this.identifier,
      this.image,
      this.name,
      this.shortDescription,
      this.description,
      this.createdAt,
      this.updatedAt});

  BookEventData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    identifier = json['identifier'];
    image = json['image'];
    name = json['name'];
    shortDescription = json['shortDescription'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['identifier'] = this.identifier;
    data['image'] = this.image;
    data['name'] = this.name;
    data['shortDescription'] = this.shortDescription;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
