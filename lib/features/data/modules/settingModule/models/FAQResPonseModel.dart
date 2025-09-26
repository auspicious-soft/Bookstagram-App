class FAQResponseModel {
  bool? success;
  String? message;
  int? total;
  int? page;
  int? limit;
  List<String>? types;
  String? selectedType;
  List<FAQData>? data;

  FAQResponseModel(
      {this.success,
      this.message,
      this.total,
      this.page,
      this.limit,
      this.types,
      this.selectedType,
      this.data});

  FAQResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    selectedType = json['selectedType'];
    types = json['types'].cast<String>();
    if (json['data'] != null) {
      data = <FAQData>[];
      json['data'].forEach((v) {
        data!.add(new FAQData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['selectedType'] = this.selectedType;
    data['types'] = this.types;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FAQData {
  String? sId;
  String? identifier;
  String? question;
  String? answer;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FAQData(
      {this.sId,
      this.identifier,
      this.question,
      this.answer,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.iV});

  FAQData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    identifier = json['identifier'];
    question = json['question'];
    answer = json['answer'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['identifier'] = this.identifier;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
