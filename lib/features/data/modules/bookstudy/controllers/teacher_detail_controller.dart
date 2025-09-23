import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../../CourseModule/models/ReviewsModel.dart';
import '../models/teacher_detail_model.dart';
import '../models/teacher_model.dart';

class PgTeacherProfileController extends GetxController {
  // var selLike = false.obs;
  // var selLike2 = false.obs;
  final Rx<TeacherProfileModel?> bookStudy = Rx<TeacherProfileModel?>(null);
  var selLike = false.obs;
  var selLike2 = false.obs;
  final RxBool isLoading = true.obs;

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
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
      selLike.value = bookStudy.value?.isFavorite ?? false;
      selLike.refresh();
      bookStudy.refresh();
      print("Books found: ${bookStudy.value?.data?.name?.eng ?? ""}");
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

  void toggleLike() {
    selLike.value = !selLike.value;
    handleFavorite();
  }

  Future<void> handleFavorite() async {
    try {
      var data = await postlike();
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<Ratings> postlike() async {
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
          "authorId": bookStudy.value?.data?.sId,
          "favorite": selLike.value,
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

  Future<TeacherProfileModel> getTeacherId(String? id) async {
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
      String uri = '${AppConfig.baseUrl}${AppConfig.getTeacherById}/${id}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return TeacherProfileModel.fromJson(jsonBody);
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
