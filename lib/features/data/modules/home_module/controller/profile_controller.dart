import 'dart:convert';
import 'dart:ffi';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../../../datasources/user_storage.dart';
import '../models/NotificationSettingResponseModel.dart';
import '../models/setttingProfile.dart';

class ProfileController extends GetxController {
  var isSwitched = true.obs;
  final RxBool isLoading = true.obs;
  final Rx<SettingProfile?> proileData = Rx<SettingProfile?>(null);
  final Rx<NotifificationSettingEnableResponseModel?> notificationSetting =
      Rx<NotifificationSettingEnableResponseModel?>(null);

  @override
  void onReady() {
    getProfileApiCall();
    // TODO: implement onReady
    super.onReady();
  }

  void toggleSwitch(bool value) {
    isSwitched.value = value;
    SetNotificationEnable();
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
      isSwitched.value =
          proileData.value?.data?.data?.notificationAllowed ?? false;
      isSwitched.refresh();
    } catch (e) {
      print("Error profile Detail: $e");
    } finally {
      isLoading.value = false;
    }
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

    // Base URL
    final uri = Uri.parse(
        '${AppConfig.baseUrl}${AppConfig.NotificationSettingEndPoint}');

    // Build query parameters map
    final queryParams = <String, String>{};

    queryParams['type'] = "notifications";

    // Add query parameters if any
    final finalUri = uri.replace(
        queryParameters: queryParams.isNotEmpty ? queryParams : null);

    final response = await httpClient.put(finalUri,
        headers: headers,
        body: jsonEncode({"notificationAllowed": isSwitched.value}));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);

      return NotifificationSettingEnableResponseModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch books: ${response.statusCode}');
    }
  }

  Future<void> logout() async {
    UserStorage().deleteToken();
    Get.offAllNamed("/login");
    isLoading.value = true;
    try {
      var data = await logoutApiCall();
      notificationSetting.value = data;
      notificationSetting.refresh();
      Get.snackbar("Success", "Logout Successfully");
    } catch (e) {
      print("Error profile Detail: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<NotifificationSettingEnableResponseModel> logoutApiCall() async {
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

    // ✅ Correct Base URL (removed extra '}')
    final uri = Uri.parse('${AppConfig.baseUrl}api/user/logout');

    // Call API
    final response = await httpClient.put(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return NotifificationSettingEnableResponseModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to logout: ${response.statusCode}');
    }
  }

  Future<void> delete() async {
    isLoading.value = true;
    try {
      var data = await deleteApiCall();
      notificationSetting.value = data;
      notificationSetting.refresh();
      UserStorage().deleteToken();

      Get.snackbar("Success", "Account Delete Successfully");
      Get.offAllNamed("/login");
    } catch (e) {
      print("Error profile Detail: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<NotifificationSettingEnableResponseModel> deleteApiCall() async {
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

    // ✅ Correct Base URL (removed extra '}')
    final uri = Uri.parse('${AppConfig.baseUrl}api/user/delete-account');

    // Call API
    final response = await httpClient.delete(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return NotifificationSettingEnableResponseModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to logout: ${response.statusCode}');
    }
  }
}
