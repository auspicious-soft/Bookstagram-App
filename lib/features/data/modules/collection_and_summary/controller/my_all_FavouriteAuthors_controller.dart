import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../../CourseModule/models/ReviewsModel.dart';
import '../models/My_Favourite_Authors_ResponseModel.dart'
    show MyFavouriteAuthorsResponseModel;

class MyFavoriteAuthorController extends GetxController {
  final Rx<MyFavouriteAuthorsResponseModel?> collectiondata =
      Rx<MyFavouriteAuthorsResponseModel?>(null);

  final RxBool isLoading = true.obs;

  // Track the index of the currently slid item
  var resetSlideIndex = 0.obs;

  // Handle delete action
  void deleteAuthor(int index) {
    handleFavorite(index);
  }

  Future<void> handleFavorite(int index) async {
    try {
      var data = await postlike(index);
      if (data != null) {
        collectiondata.value?.data?.removeAt(index);
        collectiondata.refresh();
      }
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<Ratings> postlike(int index) async {
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
          '${AppConfig.baseUrl}${AppConfig.AddAuthorFavouriteEndPoint}';

      final response = await httpClient.put(
        Uri.parse(uri),
        headers: headers,
        body: jsonEncode({
          "authorId": collectiondata.value?.data?[index]?.authorId?.sId,
          "favorite": false,
        }),
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return Ratings.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  @override
  void onInit() {
    GetAllReadBooks();
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> GetAllReadBooks() async {
    isLoading.value = true;
    try {
      var data = await getMyFavourite();
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

  Future<MyFavouriteAuthorsResponseModel> getMyFavourite() async {
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
          '${AppConfig.baseUrl}${AppConfig.getAllFavouriteAuthorsEndPoint}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return MyFavouriteAuthorsResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  // Update resetSlideIndex to close other slid items
  void updateSlideIndex(int index) {
    resetSlideIndex.value = index;
  }
}
