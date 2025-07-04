import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../Models/bookDetailResponseModel.dart';

class PgBookViewController extends GetxController {
  var selLike = false.obs;
  var selLike2 = false.obs;
  var selectedIndex = 0.obs;
  var bookId = "";
  final RxBool isLoading = true.obs;

  // BookDetailResponseModel bookDetailResponseModel;
  final Rx<BookDetailResponseModel?> bookDetailResponseModel =
      Rx<BookDetailResponseModel?>(null);

  @override
  void onInit() {
    if (Get.arguments != null) {
      bookId = Get.arguments["id"];
      fetchBookStudy();
    }

    super.onInit();
  }

  Future<void> fetchBookStudy() async {
    isLoading.value = true;
    try {
      var data = await getListBooks();
      bookDetailResponseModel.value = data;
      bookDetailResponseModel.refresh();
    } catch (e) {
      print("Error fetching books: $e");
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

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  Future<BookDetailResponseModel> getListBooks() async {
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

      String selectedLanguage = Get.locale?.languageCode ?? "";
      // Build the base URI string
      String uri =
          '${AppConfig.baseUrl}${AppConfig.getBookbyIdEndPoints}/${bookId}?lang=${Uri.encodeComponent(selectedLanguage == "en" ? "eng" : selectedLanguage == "ru" ? "rus" : "kaz")}';

      // String uri = '${AppConfig.baseUrl}${AppConfig.getBookMasterHome}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return BookDetailResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  void toggleLike() {
    selLike.value = !selLike.value;
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
