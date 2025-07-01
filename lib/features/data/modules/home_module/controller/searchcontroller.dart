import 'dart:async';
import 'dart:convert';

import 'package:bookstagram/features/data/modules/home_module/models/author_listmodel.dart';
import 'package:bookstagram/features/data/modules/home_module/models/homeProductModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../models/booksListModel.dart';

class TabSearchController extends GetxController {
  var selectedIndex = 0.obs;
  var searchText = ''.obs;
  final Rx<BooksListModel?> bookList = Rx<BooksListModel?>(null);
  final Rx<AuthorListModel?> authorList = Rx<AuthorListModel?>(null);
  Timer? _debounce;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Add listener to selectedIndex to trigger search when tab changes
    ever(selectedIndex, (_) => fetchBooks());
  }

  void onSearchChanged(String query) {
    searchText.value = query;

    // Cancel previous timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Start new timer
    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchBooks();
    });
  }

  @override
  void onReady() {
    fetchBooks();
    super.onReady();
  }

  @override
  void onClose() {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    super.onClose();
  }

  Future<void> fetchBooks() async {
    isLoading.value = true;

    try {
      if (selectedIndex.value == 2) {
        bookList.value?.data = [];
        authorList.value?.data?.authors = [];
        var data = await getAutors();
        authorList.value = data;
        authorList.refresh();
        print("Books found: ${authorList.value?.data?.authors?.length ?? 0}");
      } else {
        authorList.value?.data?.authors = [];

        var data = await getListBooks();
        bookList.value = data;
        bookList.refresh();
        print("Books found: ${bookList.value?.data?.length ?? 0}");
      }
    } catch (e) {
      print("Error fetching books: $e");
      // Initialize with empty data to avoid null errors
      bookList.value = BooksListModel(data: []);
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  getBookTitle({required dynamic name}) {
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

  Future<BooksListModel> getListBooks() async {
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

      final type = selectedIndex.value == 0
          ? "e-book"
          : selectedIndex.value == 1
              ? "audiobook"
              : selectedIndex.value == 2
                  ? "author"
                  : "course";

      // Build the base URI string
      String uri =
          '${AppConfig.baseUrl}${AppConfig.getBooksEndPoints}?page=1&limit=20&type=$type';

      // Append `description` only if searchText is not null or empty
      if (searchText.value.trim().isNotEmpty) {
        uri += '&description=${Uri.encodeComponent(searchText.value.trim())}';
      }

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return BooksListModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<AuthorListModel> getAutors() async {
    try {
      isLoading.value = true;
      isLoading.refresh();
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
      String uri =
          '${AppConfig.baseUrl}${AppConfig.getAuthorsEndPoints}?page=1&limit=20';

      // Append `description` only if searchText is not null or empty
      if (searchText.value.trim().isNotEmpty) {
        uri += '&description=${Uri.encodeComponent(searchText.value.trim())}';
      }

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        final jsonBody = json.decode(response.body);
        return AuthorListModel.fromJson(jsonBody);
      } else {
        isLoading.value = false;
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      print("API Error: $e");
      throw e;
    }
  }
}
