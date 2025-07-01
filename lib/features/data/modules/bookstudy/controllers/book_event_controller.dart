import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../../../../../localization/app_localization.dart';
import '../models/BookEventResponseModel.dart';

class PgBookEventController extends GetxController {
  // Reactive list of events
  final RxList<Map<String, dynamic>> events = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = true.obs;
  final Rx<BookEventsResponseModel?> bookevent =
      Rx<BookEventsResponseModel?>(null);
  var filter = "default".obs;

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

  Future<void> fetchBookStudy() async {
    isLoading.value = true;
    try {
      var data = await getListBooks();
      bookevent.value = data;

      bookevent.refresh();
      print("Books found: ${bookevent.value?.data?.length ?? 0}");
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<BookEventsResponseModel> getListBooks() async {
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
          '${AppConfig.baseUrl}${AppConfig.getEventHome}?page=1&limit=100&sorting=${filter.value == AppLocalization.of(Get.context!).translate('alphabetically') ? "alphabetically" : filter.value == AppLocalization.of(Get.context!).translate('byrating') ? "rating" : filter.value == AppLocalization.of(Get.context!).translate('bynovelty') ? "newest" : "default"}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return BookEventsResponseModel.fromJson(jsonBody);
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
