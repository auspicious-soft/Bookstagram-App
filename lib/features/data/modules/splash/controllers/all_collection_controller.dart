import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../../../../../localization/app_localization.dart';
import '../models/AllAudioBooks.dart';
import '../models/AllNewBooksModel.dart';
import '../models/BestSellerResponseModel.dart';
import '../models/Collection_Detail_Model.dart';

class PgCollectionsController extends GetxController {
  // Reactive list to track like status for each item
  // final RxList<bool> likeStatus = RxList<bool>([false, false, false]);
  var title = "".obs;

  // Add the missing collectiondata property
  final Rx<CollectionDetailModel?> collectiondata =
      Rx<CollectionDetailModel?>(null);
  final Rx<BestSellerResponseModel?> bestSellerData =
      Rx<BestSellerResponseModel?>(null);
  final Rx<AllaudiobooksResponseModel?> allAudioBooks =
      Rx<AllaudiobooksResponseModel?>(null);
  final Rx<AllNewbooksResponseModel?> allNewBooks =
      Rx<AllNewbooksResponseModel?>(null);

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

  Future<CollectionDetailModel> getCollectionById({String? id}) async {
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
          '${AppConfig.baseUrl}${AppConfig.getCollectionDetailEndPoint}/$id';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return CollectionDetailModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<BestSellerResponseModel> getBestSeller() async {
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

      String uri = '${AppConfig.baseUrl}${AppConfig.getBestSellers}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return BestSellerResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<void> fetchBestSeller() async {
    isLoading.value = true;
    try {
      var data = await getBestSeller();
      if (data.data != null) {
        bestSellerData.value = data;
        bestSellerData.refresh();
      }
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
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

  Future<AllaudiobooksResponseModel> getAllAudioBooks() async {
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

      String uri = '${AppConfig.baseUrl}${AppConfig.getAllAudioBooksEndPoints}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return AllaudiobooksResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<void> fetchAudioBooks() async {
    isLoading.value = true;
    try {
      var data = await getAllAudioBooks();
      if (data.data != null) {
        allAudioBooks.value = data;
        allAudioBooks.refresh();
        print(allAudioBooks?.value?.data?.audioBooks?.length);
      }
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<AllNewbooksResponseModel> getAllNewBooks() async {
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

      String uri = '${AppConfig.baseUrl}${AppConfig.getAllNewBooks}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return AllNewbooksResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
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
      if (data.data != null) {
        allNewBooks.value = data;
        allNewBooks.refresh();
        print(allNewBooks?.value?.data?.newBooks?.length);
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

      String id = Get.arguments["id"];
      if (id != null && id.isNotEmpty) {
        fetchBookStudy(id);
      } else {
        if (title.value ==
            '${AppLocalization.of(Get.context!).translate('bestsellers')}🔥') {
          fetchBestSeller();
        } else if (title.value ==
            '${AppLocalization.of(Get.context!).translate('newbooks')}💌') {
          fetchAllNewBooks();
        } else {
          fetchAudioBooks();
        }
      }
    }
  }
}
