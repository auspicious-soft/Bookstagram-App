import 'dart:convert';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:bookstagram/features/data/models/homedata_model.dart';
import 'package:bookstagram/features/data/models/stock_model.dart';
import 'package:bookstagram/features/data/modules/home_module/models/CollectionDataModel.dart';
import 'package:bookstagram/features/data/modules/home_module/models/blog_collection_model.dart';
import 'package:bookstagram/features/data/repositories/remote_ds_impl.dart';
import 'package:bookstagram/features/domain/repositories/remote_repo.dart';

import 'package:bookstagram/features/domain/usecases/usecase_get_homedata.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../datasources/bookstagram_ds.dart';
import '../models/homeProductModel.dart';

class HomeDataController extends GetxController {
  // final RemoteDs repository;
  late final UsecaseGetHomedata _homeUseCase;

  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool isloadlist = false.obs;
  final Rx<HomeDataModel?> homeData = Rx<HomeDataModel?>(null);
  final Rx<ResponseModel?> homeProducts = Rx<ResponseModel?>(null);
  final Rx<CollectionDataModel?> collectiondata =
      Rx<CollectionDataModel?>(null);
  final Rx<BlogCollectionModel?> blogcollectiondata =
      Rx<BlogCollectionModel?>(null);

  final RxString? error = RxString("");
  final RxInt selectedTabIndex = 0.obs;
  final RxList bookList = [].obs;
  final RxList searchResults = [].obs;
  final List<GlobalKey> tabKeys = List.generate(3, (_) => GlobalKey());
  final RxDouble indicatorLeft = 0.0.obs;
  final RxDouble indicatorWidth = 0.0.obs;
  var language = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchBooks("stock");
    _homeUseCase = Get.find<UsecaseGetHomedata>();
    String selectedLanguage = Get.locale?.languageCode ?? "";
    print("Selected language>>>>>>>>>>>: $selectedLanguage");
    language.value = selectedLanguage;
    language.refresh();
  }

  getBookTitle({String? language, required dynamic name}) {
    // Default title if name is null or invalid
    const String defaultTitle = 'No Title';
    String selectedLanguage = Get.locale?.languageCode ?? "";

    if (name == null) return defaultTitle;
    switch (selectedLanguage) {
      case 'en':
        return name.eng?.toString() ?? "";
      case 'kk':
        return name.kaz?.toString() ?? "";
      case 'ru':
        return name.rus?.toString() ?? "";
    }
  }

  Future<String> getStoredLanguage() async {
    const secureStorage = FlutterSecureStorage();
    return await secureStorage.read(key: 'language') ?? "";
  }

  void setSelectedTab(int index) {
    String selectedLanguage = Get.locale?.languageCode ?? "";
    print("Selected language>>>>>>>>>>>: $selectedLanguage");
    language.value = selectedLanguage;
    language.refresh();
    selectedTabIndex.value = index;
  }

  void updateIndicatorPosition(int index) {
    final keyContext = tabKeys[index].currentContext;
    if (keyContext != null) {
      final box = keyContext.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero);
      final size = box.size;

      final screenWidth = MediaQuery.of(Get.context!).size.width;
      final leftOffset = position.dx;

      indicatorLeft.value = leftOffset;
      indicatorWidth.value = size.width;
    }
  }

  // Method to fetch home data
  Future<void> getHomeData({required BuildContext context}) async {
    try {
      isLoading.value = true;

      final data = await _homeUseCase.call();
      data.fold((errorMsg) {
        error?.value = errorMsg.message;
        showErrorToast(context, errorMsg.message);
      }, (fetchedData) {
        homeData.value = fetchedData;
      });
    } catch (e) {
      error?.value = e.toString();
      showErrorToast(context, "Error: $e");
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBooks(String type) async {
    try {
      isloadlist.value = true;
      if (type == "stock") {
        var data = await getProductByType(type: type);
        if (data != null && data.success) {
          // Assuming homeProducts is a list of some other model
          homeProducts.value = data; // Make sure this matches the expected type
          homeProducts.refresh();
        }
      } else if (type == "collections") {
        var data = await getCollections(type: type);

        // First, check if 'data' is not null
        if (data != null) {
          collectiondata.value =
              data; // Make sure this matches the expected type
          collectiondata.refresh();

          print(collectiondata.value?.data?.data?.mindBlowing?.length);
        }
      } else {
        var data = await getBlogType(type: type);

        // First, check if 'data' is not null
        if (data != null) {
          // Assuming 'homeProducts' is a list of some other model
          blogcollectiondata.value =
              data; // Make sure this matches the expected type
          blogcollectiondata.refresh();
          print(blogcollectiondata.value?.data?.data?.blogs?.length);
        }
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isloadlist.value = false;
    }
  }

  String handleError(String jsonString) {
    Map<String, dynamic> responseData = jsonDecode(jsonString);
    final reason = responseData["reason"] as String? ?? "";
    if (reason.isEmpty) {
      return "unable to reach now.";
    }
    return reason;
  }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  Future<ResponseModel> getProductByType({required String type}) async {
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

    final response = await httpClient.get(
      Uri.parse('${AppConfig.baseUrl}${AppConfig.getproductByType}$type'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);

      return ResponseModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch books: ${response.statusCode}');
    }
  }

  Future<BlogCollectionModel> getBlogType({required String type}) async {
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

    final response = await httpClient.get(
      Uri.parse('${AppConfig.baseUrl}${AppConfig.getproductByType}$type'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);

      return BlogCollectionModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch books: ${response.statusCode}');
    }
  }

  Future<CollectionDataModel> getCollections({required String type}) async {
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

    final response = await httpClient.get(
      Uri.parse('${AppConfig.baseUrl}${AppConfig.getproductByType}$type'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);

      return CollectionDataModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch books: ${response.statusCode}');
    }
  }

  // Helper method to show error toast
  void showErrorToast(BuildContext context, String message) {
    MotionToast.error(
      title: const Label(
        txt: "Error",
        type: TextTypes.f_15_500,
        forceColor: AppColors.whiteColor,
      ),
      description: Label(
        txt: message,
        type: TextTypes.f_13_500,
        forceColor: AppColors.whiteColor,
      ),
      width: 300,
      height: 80,
    ).show(context);
  }

  // Helper method to show success toast
  void showSuccessToast(BuildContext context, String message) {
    MotionToast.success(
      title: const Label(
        txt: "Success",
        type: TextTypes.f_15_500,
        forceColor: AppColors.whiteColor,
      ),
      description: Label(
        txt: message,
        type: TextTypes.f_13_500,
        forceColor: AppColors.whiteColor,
      ),
      width: 300,
      height: 80,
    ).show(context);
  }

  // Helper method to show info toast
  void showInfoToast(BuildContext context, String message) {
    MotionToast.info(
      title: const Label(
        txt: "Information",
        type: TextTypes.f_15_500,
        forceColor: AppColors.whiteColor,
      ),
      description: Label(
        txt: message,
        type: TextTypes.f_13_500,
        forceColor: AppColors.whiteColor,
      ),
      width: 300,
      height: 80,
    ).show(context);
  }

  // Method to refresh data
  Future<void> refreshData(BuildContext context) async {
    await getHomeData(context: context);
    await fetchBooks(["stock", "collection", "blog"][selectedTabIndex.value]);
  }

  @override
  void onClose() {
    // Clean up resources if needed
    super.onClose();
  }
}
