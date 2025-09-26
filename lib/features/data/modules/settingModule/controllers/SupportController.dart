import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../../../../app_settings/constants/app_config.dart';
import '../models/FAQResponseModel.dart';

class SupportController extends GetxController {
  var selectedIndex = 0.obs; // FAQ or Contacts
  var faqs = <FAQData>[].obs;
  var expanded = <bool>[].obs; // Initialize as empty reactive list
  var selectedType = ''.obs;

  var page = 1;
  final int limit = 7;
  var hasMore = true.obs;
  var openIndex = 0.obs;
  var isLoading = true.obs;
  var isLoadingMore = false.obs;

  // late ScrollController scrollController;
  final Rx<FAQResponseModel?> walletHistory = Rx<FAQResponseModel?>(null);

  TextEditingController faqsearchController = TextEditingController();
  Timer? debounce;

  @override
  void onInit() {
    // scrollController = ScrollController();
    //
    // /// Listener for pagination
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels >=
    //           scrollController.position.maxScrollExtent &&
    //       !isLoadingMore.value &&
    //       hasMore.value) {
    //     // fetchFAQs(loadMore: true, type: selectedType.value);
    //   }
    // });
    fetchFAQs();

    super.onInit();
  }

  @override
  void onClose() {
    debounce?.cancel();
    super.onClose();
  }

  void setInitialTab(int index) {
    selectedIndex.value = index;
  }

  void setTab(int index) {
    selectedIndex.value = index;
    if (index == 0) {
      fetchFAQs(); // Fetch FAQs when switching to FAQ tab
    }
  }

  void toggleItem(int index) {
    if (index < expanded.length) {
      expanded[index] = !expanded[index];
      expanded.refresh();
      openIndex.value = index;
      openIndex.refresh(); // Ensure UI updates
    }
  }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    return await secureStorage.read(key: 'token') ?? "";
  }

  Future<void> fetchFAQs(
      {bool loadMore = false, String? search, String? type}) async {
    if (loadMore && !hasMore.value) return;

    if (loadMore) {
      page++;
      isLoadingMore.value = true;
    } else {
      page = 1;
      faqs.clear();
      expanded.clear(); // Clear expanded state for fresh fetch
      hasMore.value = true;
      isLoading.value = true;
    }

    try {
      final data = await getHistory(
          page: page, limit: limit, search: search, type: type);
      if (data.data != null && data.data!.isNotEmpty) {
        faqs.addAll(data.data!);
        // Update expanded list to match new FAQs length

        expanded.addAll(List.generate(data.data!.length, (_) => false));
        walletHistory.value = data;
        selectedType.value = walletHistory.value?.selectedType ?? "";
        selectedType.refresh();
        walletHistory.refresh();
      } else {
        hasMore.value = false;
      }
    } catch (e) {
      print("Error fetching FAQs: $e");
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<FAQResponseModel> getHistory(
      {int page = 1, int limit = 7, String? search, String? type}) async {
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

    final uri = Uri.parse('${AppConfig.baseUrl}${AppConfig.FAQEndPoints}');
    final queryParams = {
      if (search != null && search.isNotEmpty) 'search': search,
      if (type != null && type.isNotEmpty) 'type': type,
    };
    final finalUri = uri.replace(queryParameters: queryParams);

    final response = await httpClient.get(finalUri, headers: headers);
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return FAQResponseModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch FAQs: ${response.statusCode}');
    }
  }

  /// Search debounce handler
  void onSearchChanged(String value) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 600), () {
      fetchFAQs(search: value);
    });
  }
}
