import 'dart:convert';

import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../models/level_Response_Model.dart';

class PgAchievementsController extends GetxController {
  final Rx<AcheivementResponseModel?> achievementsResponse =
      Rx<AcheivementResponseModel?>(null);
  final RxList<Map<String, dynamic>> achievements = [
    {"title": "Achievement 1", "image": AppAssets.grade, "achieved": false},
  ].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getProfileApiCall();
    super.onInit();
  }

  Future<void> getProfileApiCall() async {
    isLoading.value = true;
    try {
      var data = await getAchievementApi();
      achievementsResponse.value = data;

      achievementsResponse.refresh();
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

  Future<AcheivementResponseModel> getAchievementApi() async {
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
      Uri.parse('${AppConfig.baseUrl}${AppConfig.getAchievementsEndPoint}'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return AcheivementResponseModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch books: ${response.statusCode}');
    }
  }
}
