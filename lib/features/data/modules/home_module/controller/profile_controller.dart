import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../../../datasources/user_storage.dart';
import '../models/setttingProfile.dart';

class ProfileController extends GetxController {
  var isSwitched = true.obs;
  final RxBool isLoading = true.obs;
  final Rx<SettingProfile?> proileData = Rx<SettingProfile?>(null);
  @override
  void onReady() {
    getProfileApiCall();
    // TODO: implement onReady
    super.onReady();
  }

  void toggleSwitch(bool value) {
    isSwitched.value = value;
  }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  Future<SettingProfile> getProfileApi() async {
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

    final response = await httpClient.get(
      Uri.parse('${AppConfig.baseUrl}${AppConfig.SettingProfileEndPoint}'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);

      return SettingProfile.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch books: ${response.statusCode}');
    }
  }

  getBookTitle({required dynamic name}) {
    // Default title if name is null or invalid
    const String defaultTitle = 'No Title';
    String selectedLanguage = Get.locale?.languageCode ?? "";

    if (name == null) return defaultTitle;
    switch (selectedLanguage) {
      case 'en':
        return name.eng?.toString() ?? "";
      case 'kk':
        return name.kaz?.toString() ?? "";
      case 'ru':
        return name.rus?.toString() ?? "";
    }
  }

  Future<void> getProfileApiCall() async {
    isLoading.value = true;
    try {
      var data = await getProfileApi();
      proileData.value = data;
      proileData.refresh();
    } catch (e) {
      print("Error profile Detail: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    print("Logout");
    UserStorage().deleteToken();
    Get.snackbar("Success", "Logout Successfully");
    Get.offAllNamed("/login");
  }
}
