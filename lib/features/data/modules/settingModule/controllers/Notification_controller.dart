import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../models/GetNotificationsResponseModel.dart';

class PgNotificationController extends GetxController {
  final RxBool isLoading = true.obs;
  final Rx<GetNotificationResponseModel?> proileData =
      Rx<GetNotificationResponseModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getNoticationApiCall();
  }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  Future<void> getNoticationApiCall() async {
    try {
      var data = await getNotificationApi();
      proileData.value = data;
      proileData.refresh();
    } catch (e) {
      print("Error profile Detail: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<GetNotificationResponseModel> getNotificationApi() async {
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
      Uri.parse('${AppConfig.baseUrl}${AppConfig.getAllNotifications}'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return GetNotificationResponseModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch books: ${response.statusCode}');
    }
  }

  Future<void> MarkAllApiCall() async {
    try {
      var data = await MarkAllApi();
      proileData.value = data;
      proileData.refresh();
      getNoticationApiCall();
    } catch (e) {
      print("Error profile Detail: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<GetNotificationResponseModel> MarkAllApi() async {
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

    final response = await httpClient.put(
      Uri.parse('${AppConfig.baseUrl}${AppConfig.getAllNotifications}'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return GetNotificationResponseModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch books: ${response.statusCode}');
    }
  }
}
