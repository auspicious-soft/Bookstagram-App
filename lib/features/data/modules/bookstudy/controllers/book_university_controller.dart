import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../models/BookStudyModel.dart';
import 'debouncer.dart';

class BookUniversityController extends GetxController {
  final Rx<BookStudyModel?> bookStudy = Rx<BookStudyModel?>(null);

  final Debouncer debouncer =
      Debouncer(delay: const Duration(milliseconds: 500));

  final RxBool isLoading = true.obs;
  var search = "".obs;

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  @override
  void onInit() {
    fetchBookStudy();
    super.onInit();
  }

  Future<void> searchBookStudy() async {
    try {
      var data = await getListBooks();

      bookStudy.value = data;
      bookStudy.refresh();
      print("Books found: ${bookStudy.value?.data?.categories?.length ?? 0}");
    } catch (e) {
      print("Error fetching books: $e");
    }
  }

  Future<void> fetchBookStudy() async {
    isLoading.value = true;
    try {
      var data = await getListBooks();
      bookStudy.value = data;
      bookStudy.refresh();
      print("Books found: ${bookStudy.value?.data?.categories?.length ?? 0}");
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

  Future<BookStudyModel> getListBooks() async {
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
          '${AppConfig.baseUrl}${AppConfig.getBookUniHome}?language=${Uri.encodeComponent(selectedLanguage == "en" ? "eng" : selectedLanguage == "ru" ? "rus" : "kaz")}';

      if (search.value.trim().isNotEmpty) {
        uri += '&description=${Uri.encodeComponent(search.value.trim())}';
      }
      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return BookStudyModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  void goBack() {
    Get.back();
  }

  void navigateToCategory() {
    Get.toNamed('/categoreies');
  }

  void navigateToTeachers() {
    Get.toNamed('/teacherScreen');
  }

  void navigateToCourses() {
    // Get.to(() => const PgCoursesPage());
  }

  void navigateToCourseDetail() {
    // Get.to(() => const PgCoursedetail());
  }

  // Placeholder for continue button action
  void onContinuePressed() {
    // Add logic for continuing course
    print('Continue button pressed');
  }
}
