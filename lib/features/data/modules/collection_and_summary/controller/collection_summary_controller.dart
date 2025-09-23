import 'dart:convert';

import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart' show AppConfig;
import '../../../../../localization/app_localization.dart';
import '../models/GetAllCollectionsModel.dart';

class CollectionSummaryController extends GetxController {
  final selectedIndex = 0.obs;
  var title = ''.obs;
  final Rx<AllCollectionsModel?> collectiondata =
      Rx<AllCollectionsModel?>(null);

  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      title.value = Get.arguments['title'];
    }
    if (title ==
        '${AppLocalization.of(Get.context!).translate('strAllCollections')}') {
      fetchAllCollections();
    } else {
      fetchAllSummaries();
    }

    super.onInit();
  }

  Future<void> fetchAllCollections() async {
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

  Future<void> fetchAllSummaries() async {
    isLoading.value = true;
    try {
      var data = await getAllSummeries();
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

  Future<AllCollectionsModel> getCollectionById() async {
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

      String uri =
          '${AppConfig.baseUrl}${AppConfig.getCollectionDetailEndPoint}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return AllCollectionsModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<AllCollectionsModel> getAllSummeries() async {
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

      String uri = '${AppConfig.baseUrl}${AppConfig.getAllSummariesEndPoint}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return AllCollectionsModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  void showFilterBottomSheet() {
    Get.bottomSheet(
      FilterBottomSheet(),
      isScrollControlled: true,
      backgroundColor: AppColors.whiteColor,
    );
  }
}
