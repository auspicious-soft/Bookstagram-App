import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../models/Certificate_data.dart';

class PgCertificateController extends GetxController {
  final RxBool isLoading = true.obs;
  String Id = "";
  final Rx<CertificateResponse?> certificate = Rx<CertificateResponse?>(null);

  void goBack() {
    Get.back();
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      Id = Get.arguments["CourseID"];
      handelGernateCertificate(Id);
    }
    super.onInit();
  }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  Future<void> handelGernateCertificate(String? id) async {
    isLoading.value = true;
    try {
      var data = await getCertificateDetail(Id: id);
      certificate.value = data;
      certificate.refresh();
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<CertificateResponse> getCertificateDetail({String? Id}) async {
    try {
      final token = await getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'role': 'admin',
        'x-client-type': 'mobile',
      };

      HttpWithMiddleware httpClient = HttpWithMiddleware.build(
        middlewares: [HttpLogger(logLevel: LogLevel.BODY)],
      );

      String uri = '${AppConfig.baseUrl}${AppConfig.GetCertificate}/${Id}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return CertificateResponse.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  void downloadCertificate() async {
    // Example URL, replace with your actual URL (e.g., from CourseLessonsModel)
    final String url =
        "${AppConfig.imgBaseUrl}${certificate.value?.data?.certificatePdf}";

    // Check if the URL can be launched
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView);
    }

    // Handle download certificate logic (e.g., API call, file download)
  }
}
