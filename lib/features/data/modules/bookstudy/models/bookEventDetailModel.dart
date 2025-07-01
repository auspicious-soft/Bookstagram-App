class BookEventsDetailModel {
  String? sId;
  String? identifier;
  String? image;
  String? name;
  String? shortDescription;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BookEventsDetailModel(
      {this.sId,
      this.identifier,
      this.image,
      this.name,
      this.shortDescription,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.iV});

  BookEventsDetailModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    identifier = json['identifier'];
    image = json['image'];
    name = json['name'];
    shortDescription = json['shortDescription'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
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
    data['__v'] = this.iV;
    return data;
  }
}
