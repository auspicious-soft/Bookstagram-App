import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../../../../../localization/app_localization.dart';
import '../../splash/models/Collection_Detail_Model.dart';
import '../models/SubCategories_Books_ResponseModel.dart';

class Collectionsummarybookscontroller extends GetxController {
  // Reactive list to track like status for each item
  // final RxList<bool> likeStatus = RxList<bool>([false, false, false]);
  var title = "".obs;
  var filter = "default".obs;
  var id = "".obs;

  // Add the missing collectiondata property
  final Rx<SubCategoriesBookResponse?> collectiondata =
      Rx<SubCategoriesBookResponse?>(null);

  final RxBool isLoading = true.obs;

  // void toggleLike(int index) {
  //   if (index >= 0 && index < likeStatus.length) {
  //     likeStatus[index] = !likeStatus[index];
  //   }
  // }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  Future<SubCategoriesBookResponse> getCollectionById({String? id}) async {
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
      //
      // String uri = '${AppConfig.baseUrl}api/user/sub-categories/$id';

      String uri =
          '${AppConfig.baseUrl}api/user/collections/$id?sorting=${filter.value == AppLocalization.of(Get.context!).translate('alphabetically') ? "alphabetically" : filter.value == AppLocalization.of(Get.context!).translate('byrating') ? "rating" : filter.value == AppLocalization.of(Get.context!).translate('bynovelty') ? "newest" : "default"}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return SubCategoriesBookResponse.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<void> fetchBookStudy(String? Id) async {
    isLoading.value = true;
    try {
      var data = await getCollectionById(id: Id);
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

  Future<SubCategoriesBookResponse> getSummaryById({String? id}) async {
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
      //
      // String uri = '${AppConfig.baseUrl}api/user/sub-categories/$id';

      String uri =
          '${AppConfig.baseUrl}api/user/summaries/$id?sorting=${filter.value == AppLocalization.of(Get.context!).translate('alphabetically') ? "alphabetically" : filter.value == AppLocalization.of(Get.context!).translate('byrating') ? "rating" : filter.value == AppLocalization.of(Get.context!).translate('bynovelty') ? "newest" : "default"}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return SubCategoriesBookResponse.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<void> fetchSummary(String? Id) async {
    isLoading.value = true;
    try {
      var data = await getSummaryById(id: Id);
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

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      title.value = Get.arguments["title"];
      print(Get.arguments["id"]);

      id.value = Get.arguments["id"];
      if (title ==
          '${AppLocalization.of(Get.context!).translate('strAllCollections')}') {
        fetchBookStudy(id.value);
      } else {
        fetchSummary(id.value);
      }
    }
  }
}
