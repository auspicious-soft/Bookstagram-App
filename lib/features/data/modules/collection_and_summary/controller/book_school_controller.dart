import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../../home_module/models/ReadProgressModel.dart';

class PgBookSchoolController extends GetxController {
  // Reactive state for apply coupon toggle
  final applyCoupon = false.obs;
  final isLoading = false.obs;

  // TextEditingController for the school code input
  final schoolCodeController = TextEditingController();

  // Toggle apply coupon state
  void toggleApplyCoupon() {
    HandleApplyCoupon();
  }

  Future<void> HandleApplyCoupon() async {
    try {
      if (schoolCodeController.text.isEmpty) {
        return;
      }
      isLoading.value == true;
      isLoading.refresh();
      var data = await VerifyCoupan();

      if (data.success == true) {
        isLoading.value == false;
        isLoading.refresh();
        Get.toNamed("/book-school-congrats");
      }
    } catch (e) {
      isLoading.value == false;
      isLoading.refresh();
      Get.snackbar("Error", "$e");
      print("Error fetching books: $e");
    }
  }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  Future<progressReadResponseModel> VerifyCoupan() async {
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

      String uri = '${AppConfig.baseUrl}${AppConfig.VerifyCouponEndPoint}';
      final response = await httpClient.post(Uri.parse(uri),
          headers: headers,
          body: jsonEncode({"couponCode": schoolCodeController.text}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonBody = json.decode(response.body);
        return progressReadResponseModel.fromJson(jsonBody);
      } else {
        final jsonBody = json.decode(response.body);

        throw Exception(jsonBody['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      print("API Error: ${e}");
      throw e;
    }
  }

  @override
  void onClose() {
    // Dispose the TextEditingController to prevent memory leaks
    schoolCodeController.dispose();
    super.onClose();
  }
}
