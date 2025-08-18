class GernateCrtifcateResponse {
  bool? success;
  String? message;
  Data? data;

  GernateCrtifcateResponse({this.success, this.message, this.data});

  GernateCrtifcateResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  Pdf? pdf;
  Png? png;

  Data({this.pdf, this.png});

  Data.fromJson(Map<String, dynamic> json) {
    pdf = json['pdf'] != null ? new Pdf.fromJson(json['pdf']) : null;
    png = json['png'] != null ? new Png.fromJson(json['png']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pdf != null) {
      data['pdf'] = this.pdf!.toJson();
    }
    if (this.png != null) {
      data['png'] = this.png!.toJson();
    }
    return data;
  }
}

class Pdf {
  String? s3Key;
  String? fileName;

  Pdf({this.s3Key, this.fileName});

  Pdf.fromJson(Map<String, dynamic> json) {
    s3Key = json['s3Key'];
    fileName = json['fileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s3Key'] = this.s3Key;
    data['fileName'] = this.fileName;
    return data;
  }
}

class Png {
  String? s3Key;
  String? fileName;
  String? format;

  Png({this.s3Key, this.fileName, this.format});

  Png.fromJson(Map<String, dynamic> json) {
    s3Key = json['s3Key'];
    fileName = json['fileName'];
    format = json['format'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s3Key'] = this.s3Key;
    data['fileName'] = this.fileName;
    data['format'] = this.format;
    return data;
  }
}
