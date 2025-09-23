import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../../../../app_settings/constants/app_config.dart';
import '../models/getAllPublishersModel.dart';

class PublishersController extends GetxController {
  var selectedIndex = 0.obs;
  var likeUnlike = false.obs;
  final Rx<allPublisherResponseModel?> allPublishers =
      Rx<allPublisherResponseModel?>(null);
  final RxBool isLoading = true.obs;

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  Future<allPublisherResponseModel> getAllNewBooks() async {
    try {
      final token = await getToken();
      if (token.isEmpty) {
        throw Exception('No token found');
      }

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'role': 'admin',
        'x-client-type': 'mobile',
      };

      HttpWithMiddleware httpClient = HttpWithMiddleware.build(
        middlewares: [HttpLogger(logLevel: LogLevel.BODY)],
      );

      String uri = '${AppConfig.baseUrl}${AppConfig.getAllPublishers}';
      print('Fetching publishers from: $uri');

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return allPublisherResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch publishers: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<void> fetchAllNewBooks() async {
    isLoading.value = true;
    try {
      var data = await getAllNewBooks();
      allPublishers.value = data;
      allPublishers.refresh();
      print('Fetched ${allPublishers.value?.data?.length ?? 0} publishers');
    } catch (e) {
      print("Error fetching publishers: $e");
      Get.snackbar('Error', 'Failed to load publishers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchAllNewBooks(); // Call the async function to fetch data
    super.onInit();
  }

  void showFilterSheet(BuildContext context) {
    Get.bottomSheet(
      FilterBottomSheet(),
      isScrollControlled: true,
      backgroundColor: AppColors.whiteColor,
    );
  }
}
