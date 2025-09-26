import 'dart:convert';

import 'package:bookstagram/features/presentation/Pages/SubCategory/pg_subcategory.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/components/common_sheet.dart';
import '../../../../../app_settings/constants/app_colors.dart';
import '../../../../../app_settings/constants/app_config.dart';
import '../models/BookStudyModel.dart';
import '../models/Category_data_model.dart';

class PgCategoryController extends GetxController {
  // Reactive selected index (if needed, currently unused in the UI)
  var selectedIndex = 0.obs;

  final Rx<CategoryModel?> bookStudy = Rx<CategoryModel?>(null);

  final RxBool isLoading = true.obs;

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

  Future<void> fetchBookStudy() async {
    isLoading.value = true;
    try {
      var data = await getAllCategories();
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

  Future<CategoryModel> getAllCategories() async {
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
      String uri = '${AppConfig.baseUrl}${AppConfig.getCategories}';

      // Append `description` only if searchText is not null or empty

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return CategoryModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  // Navigate to subcategory page
  // void navigateToSubcategory(String label) {
  //   Get.to(() => PgSubcategory(label: label));
  // }

  // Show filter bottom sheet
  void showFilterBottomSheet() {
    Get.bottomSheet(
      const FilterBottomSheet(),
      isScrollControlled: true,
      backgroundColor: AppColors.whiteColor,
    );
  }

  // Navigate back
  void goBack() {
    Get.back();
  }
}
