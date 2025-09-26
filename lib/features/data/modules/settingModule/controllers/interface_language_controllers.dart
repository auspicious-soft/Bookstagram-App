import 'dart:convert';
import 'dart:ui';
import 'package:bookstagram/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../../../../../localization/no_internet_screen.dart';
import '../../home_module/models/NotificationSettingResponseModel.dart';

class InterfaceLanguageControllers extends GetxController {
  final List<Map<String, dynamic>> languages = [
    {"title": "Қазақ", "code": "kk"},
    {"title": "Русский", "code": "ru"},
    {"title": "English", "code": "en"},
  ];

  var selectedLanguageCode = "en".obs;
  var isSwitched = true.obs;
  final RxBool isLoading = false.obs;

  final Rx<NotifificationSettingEnableResponseModel?> notificationSetting =
      Rx<NotifificationSettingEnableResponseModel?>(null);

  @override
  void onInit() {
    _loadSavedLanguage();
    Get.put(ConnectivityController());
    super.onInit();
  }

  void changeLanguage(String code) async {
    selectedLanguageCode.value = code;
    MyApp.setLocale(Get.context!, Locale(code, ''));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language_code', code);
  }

  void navigateBack() async {
    changeLanguage(selectedLanguageCode.value);
    SetNotificationEnable();
  }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  Future<void> SetNotificationEnable() async {
    isLoading.value = true;
    try {
      var data = await EnableNotification();
      notificationSetting.value = data;
      notificationSetting.refresh();
      Get.back();
      Get.back();
    } catch (e) {
      print("Error profile Detail: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<NotifificationSettingEnableResponseModel> EnableNotification(
      {String? type}) async {
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

    // Base URL
    final uri = Uri.parse(
        '${AppConfig.baseUrl}${AppConfig.NotificationSettingEndPoint}');

    // Build query parameters map
    final queryParams = <String, String>{};

    queryParams['type'] = "interface";

    // Add query parameters if any
    final finalUri = uri.replace(
        queryParameters: queryParams.isNotEmpty ? queryParams : null);

    final response = await httpClient.put(finalUri,
        headers: headers,
        body: jsonEncode({
          "language": selectedLanguageCode.value == "en"
              ? "eng"
              : selectedLanguageCode.value == "kk"
                  ? "kaz"
                  : "rus",
        }));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);

      return NotifificationSettingEnableResponseModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch books: ${response.statusCode}');
    }
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedCode = prefs.getString('selected_language_code');
    if (savedCode != null && savedCode != selectedLanguageCode.value) {
      selectedLanguageCode.value = savedCode;
      MyApp.setLocale(Get.context!, Locale(savedCode));
    }
  }
}
