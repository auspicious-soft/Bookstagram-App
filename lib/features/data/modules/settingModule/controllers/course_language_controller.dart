import 'dart:convert';
import 'dart:ui';
import 'package:bookstagram/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../../../../../localization/no_internet_screen.dart';
import '../../home_module/models/NotificationSettingResponseModel.dart';
import '../../home_module/models/setttingProfile.dart';

class CourseLanguageController extends GetxController {
  final Rx<SettingProfile?> proileData = Rx<SettingProfile?>(null);
  final List<Map<String, dynamic>> languages = [
    {"title": "Қазақ", "code": "kk"},
    {"title": "Русский", "code": "ru"},
    {"title": "English", "code": "en"},
  ];

  var selectedLanguageCodes = <String>[].obs;
  var isSwitched = true.obs;
  final RxBool isLoading = false.obs;

  final Rx<NotifificationSettingEnableResponseModel?> notificationSetting =
      Rx<NotifificationSettingEnableResponseModel?>(null);

  @override
  void onInit() {
    Get.put(ConnectivityController());
    getProfileApiCall();
    super.onInit();
  }

  Future<void> getProfileApiCall() async {
    isLoading.value = true;
    try {
      var data = await getProfileApi();
      proileData.value = data;
      final product = proileData.value?.data?.data?.productsLanguage;
      final languageCodes = product?.map((code) {
        return code == "eng"
            ? "en"
            : code == "kaz"
                ? "kk"
                : "ru";
      }).toList();
      selectedLanguageCodes.value = languageCodes ?? [];
      selectedLanguageCodes.refresh();
      proileData.refresh();
    } catch (e) {
      print("Error profile Detail: $e");
    } finally {
      isLoading.value = false;
    }
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

  void toggleLanguage(String code) {
    if (selectedLanguageCodes.contains(code)) {
      selectedLanguageCodes.remove(code);
    } else {
      selectedLanguageCodes.add(code);
    }
    update([
      'language_check_${languages.indexWhere((lang) => lang['code'] == code)}'
    ]);
  }

  void navigateBack() async {
    if (selectedLanguageCodes.isNotEmpty) {
      // Set the first selected language as the app's locale
      // MyApp.setLocale(Get.context!, Locale(selectedLanguageCodes.first, ''));
      await SetNotificationEnable();
    }
    Get.back();
    Get.back();
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

    final uri = Uri.parse(
        '${AppConfig.baseUrl}${AppConfig.NotificationSettingEndPoint}');

    final queryParams = <String, String>{};
    queryParams['type'] = "products";

    final finalUri = uri.replace(
        queryParameters: queryParams.isNotEmpty ? queryParams : null);

    // Map selected language codes to API-compatible format
    final languageCodes = selectedLanguageCodes.map((code) {
      return code == "en"
          ? "eng"
          : code == "kk"
              ? "kaz"
              : "rus";
    }).toList();

    final response = await httpClient.put(
      finalUri,
      headers: headers,
      body: jsonEncode({
        "productsLanguage": languageCodes, // Send array of languages
      }),
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return NotifificationSettingEnableResponseModel.fromJson(jsonBody);
    } else {
      throw Exception(
          'Failed to update notification settings: ${response.statusCode}');
    }
  }
}
