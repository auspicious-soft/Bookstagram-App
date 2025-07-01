import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../models/bookEventDetailModel.dart';
import '../models/teacher_detail_model.dart';
import '../models/teacher_model.dart';

class PgEventDetailController extends GetxController {
  var selLike = false.obs;
  var selLike2 = false.obs;
  final Rx<BookEventsDetailModel?> eventdetail =
      Rx<BookEventsDetailModel?>(null);

  final RxBool isLoading = false.obs;

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      var TeacherId = Get.arguments['eventId'];

      fetchBookStudy(TeacherId);
    }
    super.onInit();
  }

  Future<void> fetchBookStudy(String? TeacherId) async {
    isLoading.value = true;
    try {
      print(">>>>>>>>>>>TeacherId>>>>>>>>>>>>>${TeacherId}");
      var data = await getTeacherId(TeacherId);
      eventdetail.value = data;
      eventdetail.refresh();
      print("Books found: ${eventdetail.value?.name ?? ""}");
    } finally {
      isLoading.value = false;
    }
  }

  getBookTitle({required dynamic name}) {
    // Default title if name is null or invalid
    const String defaultTitle = 'No Title';
    String selectedLanguage = Get.locale?.languageCode ?? "";

    if (name == null) return defaultTitle;

    try {
      switch (selectedLanguage) {
        case 'en':
          return name.eng?.toString() ??
              name.kaz?.toString() ??
              name.rus?.toString() ??
              defaultTitle;
        case 'kk':
          return name.kaz?.toString() ??
              name.eng?.toString() ??
              name.rus?.toString() ??
              defaultTitle;
        case 'ru':
          return name.rus?.toString() ??
              name.eng?.toString() ??
              name.kaz?.toString() ??
              defaultTitle;
        default:
          return name.eng?.toString() ??
              name.kaz?.toString() ??
              name.rus?.toString() ??
              defaultTitle;
      }
    } catch (e) {
      // Handle case where name is not null but doesn't have the expected properties
      print("Error in getBookTitle: $e");
      return defaultTitle;
    }
  }

  Future<BookEventsDetailModel> getTeacherId(String? id) async {
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

      // Build the base URI string
      String uri =
          '${AppConfig.baseUrl}${Get.previousRoute == "/bookevent" ? AppConfig.getEventHome : AppConfig.getBookLives}/${id}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return BookEventsDetailModel.fromJson(jsonBody);
      } else {
        throw Exception(
            'Failed to fetch Teacher Detail: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  void toggleLike() {
    selLike.value = !selLike.value;
  }

  void toggleLike2() {
    selLike2.value = !selLike2.value;
  }
}
