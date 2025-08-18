class CertificateResponse {
  bool? success;
  String? message;
  CertificateData? data;

  CertificateResponse({this.success, this.message, this.data});

  CertificateResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new CertificateData.fromJson(json['data'])
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

class CertificateData {
  String? sId;
  String? certificatePdf;
  String? certificatePng;

  CertificateData({this.sId, this.certificatePdf, this.certificatePng});

  CertificateData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    certificatePdf = json['certificatePdf'];
    certificatePng = json['certificatePng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['certificatePdf'] = this.certificatePdf;
    data['certificatePng'] = this.certificatePng;
    return data;
  }
}
