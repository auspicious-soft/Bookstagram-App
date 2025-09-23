import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:flutter/material.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../models/reading_now_model.dart';

class PgReadingBooksController extends GetxController {
  final Rx<ReadingNowModel?> collectiondata = Rx<ReadingNowModel?>(null);

  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    GetAllReadBooks();
    super.onInit();
  }

  // Navigate back
  void goBack() {
    Get.back();
  }

  Future<void> GetAllReadBooks() async {
    isLoading.value = true;
    try {
      var data = await getCollectionById();
      if (data.data != null) {
        collectiondata.value = data;
        collectiondata.refresh();
      }
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
          return name.eng ?? name.kaz ?? name.rus ?? defaultTitle;
        case 'kk':
          return name.kaz ?? name.eng ?? name.rus ?? defaultTitle;
        case 'ru':
          return name.rus ?? name.eng ?? name.kaz ?? defaultTitle;
        default:
          return name.eng ?? name.kaz ?? name.rus ?? defaultTitle;
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

  Future<ReadingNowModel> getCollectionById() async {
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

      String uri = '${AppConfig.baseUrl}${AppConfig.getReadingNowEndPoint}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return ReadingNowModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  // Show filter bottom sheet
  void showFilterBottomSheet(BuildContext context) {
    Get.bottomSheet(
      const FilterBottomSheet(),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }
}
