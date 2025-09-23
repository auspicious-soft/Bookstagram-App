import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../../bookstudy/models/teacher_detail_model.dart';
import '../models/Publisher_detail_model.dart';

class PublisherDetailController extends GetxController {
  // var selLike = false.obs;
  final RxList<bool> likeStatus = RxList<bool>([false, false, false]);
  final Rx<PublisherDetailResponseModel?> bookStudy =
      Rx<PublisherDetailResponseModel?>(null);

  final RxBool isLoading = true.obs;
  var likeUnlike = false.obs;
  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  void toggleLike(int index) {
    if (index >= 0 && index < likeStatus.length) {
      likeStatus[index] = !likeStatus[index];
    }
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      var TeacherId = Get.arguments['teacherId'];
      fetchBookStudy(TeacherId);
    }
    super.onInit();
  }

  Future<void> fetchBookStudy(String? TeacherId) async {
    isLoading.value = true;
    try {
      print(">>>>>>>>>>>TeacherId>>>>>>>>>>>>>${TeacherId}");
      var data = await getTeacherId(TeacherId);
      bookStudy.value = data;
      bookStudy.refresh();
      print("Books found: ${bookStudy.value?.data?.booksCount ?? ""}");
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

  Future<PublisherDetailResponseModel> getTeacherId(String? id) async {
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
      String uri = '${AppConfig.baseUrl}${AppConfig.getAllPublishers}/${id}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return PublisherDetailResponseModel.fromJson(jsonBody);
      } else {
        throw Exception(
            'Failed to fetch Teacher Detail: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }
}
