import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../../../../../localization/app_localization.dart';
import '../models/BookEventResponseModel.dart';
import '../models/bookLivesResponseModel.dart';

class BookLifeController extends GetxController {
  RxInt selectedIndex = 0.obs;

  // Reactive list of events
  final RxList<Map<String, dynamic>> events = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isload = false.obs;
  final Rx<BookLivesResponseModel?> bookevent =
      Rx<BookLivesResponseModel?>(null);
  var filter = "default".obs;
  final RxDouble indicatorLeft = 0.0.obs;
  final RxDouble indicatorWidth = 0.0.obs;
  RxList<GlobalKey> tabKeys = <GlobalKey>[].obs;

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  @override
  void onInit() {
    super.onInit();

    fetchBookStudy();
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

  Future<void> fetchBookStudy() async {
    isLoading.value = true;
    try {
      var data = await getListBooks();
      bookevent.value = data;
      tabKeys.assignAll(List.generate(
          bookevent.value?.data?.categories?.length ?? 0, (_) => GlobalKey()));
      bookevent.refresh();
      // print("Books found: ${bookevent.value?.data?.length ?? 0}");
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setCategory() async {
    isload.value = true;
    try {
      var data = await getListBooks();
      bookevent.value = data;
      tabKeys.assignAll(List.generate(
          bookevent.value?.data?.categories?.length ?? 0, (_) => GlobalKey()));
      bookevent.refresh();
      // print("Books found: ${bookevent.value?.data?.length ?? 0}");
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isload.value = false;
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

  Future<BookLivesResponseModel> getListBooks() async {
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
          '${AppConfig.baseUrl}${AppConfig.getBookLives}?page=1&limit=100&sorting=${filter.value == AppLocalization.of(Get.context!).translate('alphabetically') ? "alphabetically" : filter.value == AppLocalization.of(Get.context!).translate('byrating') ? "rating" : filter.value == AppLocalization.of(Get.context!).translate('bynovelty') ? "newest" : "default"}';

      if (bookevent.value?.data?.categories?.isNotEmpty ?? false) {
        uri +=
            '&categoryId=${Uri.encodeComponent(bookevent.value?.data?.categories?[selectedIndex.value].sId ?? "")}';
      }

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return BookLivesResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  void applyFilter(Map<String, dynamic> filter) {
    // Implement filter logic here (e.g., filter by date, location, etc.)
    // For now, just print the filter
    print('Applying filter: $filter');
    // Example: Filter events based on some criteria
    // events.assignAll(events.where((event) => event['title'].contains(filter['search'] ?? '')).toList());
  }

  // Navigate to event detail
  void goToEventDetail(String? eventId) {
    Get.toNamed('/event-detail', arguments: {"eventId": eventId});
  }
}
