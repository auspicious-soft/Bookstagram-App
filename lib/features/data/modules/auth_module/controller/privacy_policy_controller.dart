import 'dart:convert';
import 'package:bookstagram/features/data/modules/auth_module/models/StaticResponseModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../../../../app_settings/constants/app_config.dart';

class PrivacyPolicyController extends GetxController {
  var title = 'privacyPolicy'.obs; // Title for the screen
  var profileData = Rx<StaticReponseModel?>(null); // Reactive profile data
  var isLoading = true.obs; // Loading state

  @override
  void onInit() {
    fetchPrivacyPolicy();
    super.onInit();
  }

  Future<void> fetchPrivacyPolicy() async {
    isLoading.value = true;
    try {
      final data = await getPrivacyPolicyData();
      profileData.value = data;
      profileData?.refresh();
    } catch (e) {
      print("Error fetching privacy policy: $e");
      profileData.value = null; // Ensure profileData is null on error
    } finally {
      isLoading.value = false;
    }
  }

  Future<StaticReponseModel> getPrivacyPolicyData() async {
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
        '${AppConfig.baseUrl}${AppConfig.StaticData}?type=${title.value == "privacyPolicy" ? "privacyPolicy" : "terms"}');
    final response = await httpClient.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return StaticReponseModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch privacy policy: ${response.statusCode}');
    }
  }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    return await secureStorage.read(key: 'token') ?? "";
  }
}
