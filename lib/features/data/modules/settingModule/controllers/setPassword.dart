// controllers/change_pass_controller.dart
import 'dart:convert';

import 'package:bookstagram/features/domain/usecases/usecase_change_pass.dart';
import 'package:bookstagram/features/domain/usecases/usecase_forgot_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/components/label.dart';
import '../../../../../app_settings/constants/app_colors.dart';
import '../../../../../app_settings/constants/app_config.dart';
import '../../home_module/models/setttingProfile.dart';

class Setpassword extends GetxController {
  TextEditingController newPassController = TextEditingController();
  TextEditingController repPassController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool passEye = true.obs;
  RxBool passEye2 = true.obs;

  void togglePassEye() => passEye.value = !passEye.value;

  void togglePassEye2() => passEye2.value = !passEye2.value;

  Future<void> ChangePassword() async {
    isLoading.value = true;
    try {
      var data = await updateProfile();

      Get.back();
      Get.back();
    } catch (e) {
      print("Error profile Detail: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  Future<SettingProfile> updateProfile() async {
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

      String uri = '${AppConfig.baseUrl}${AppConfig.ProfilePasswordChange}';

      final response = await httpClient.put(Uri.parse(uri),
          headers: headers,
          body: jsonEncode({
            "newPassword": repPassController.text,
          }));

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return SettingProfile.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
