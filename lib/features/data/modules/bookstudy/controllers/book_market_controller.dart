import 'dart:convert';

import 'package:bookstagram/features/presentation/Pages/AudioBook/pg_audio_book.dart';
import 'package:bookstagram/features/presentation/Pages/Authors/pg_authors.dart';
import 'package:bookstagram/features/presentation/Pages/Publishers/pg_publishers.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../../../../presentation/Pages/CourseDetail/pg_coursedetail.dart';
import '../models/BookStudyModel.dart';
import '../models/book_market_response_Model.dart';
import '../../home_module/models/CollectionDataModel.dart';
import 'debouncer.dart';

class PgBookmarketController extends GetxController {
  // Reactive variable for search input (if needed)
  final Rx<BookMarketResponseModel?> bookMarket =
      Rx<BookMarketResponseModel?>(null);

  // Add the missing collectiondata property
  final Rx<CollectionDataModel?> collectiondata =
      Rx<CollectionDataModel?>(null);

  final Debouncer debouncer =
      Debouncer(delay: const Duration(milliseconds: 500));

  final RxBool isLoading = true.obs;
  var searchQuery = "".obs;

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

      bookMarket.value = data;
      bookMarket.refresh();
      print("Books found: ${bookMarket.value?.data?.categories?.length ?? 0}");
    } catch (e) {
      print("Error fetching books: $e");
    }
  }

  Future<void> fetchBookStudy() async {
    isLoading.value = true;
    try {
      var data = await getListBooks();
      bookMarket.value = data;

      // Also fetch collection data
      if (bookMarket.value?.data?.collections != null) {
        try {
          // Convert the collections data to CollectionDataModel
          collectiondata.value = CollectionDataModel(
            success: bookMarket.value?.data?.collections?.success,
            message: bookMarket.value?.data?.collections?.message,
            data: CollectionMetaData(
              page: bookMarket.value?.data?.collections?.page,
              limit: bookMarket.value?.data?.collections?.limit,
              success: bookMarket.value?.data?.collections?.success,
              message: bookMarket.value?.data?.collections?.message,
              total: bookMarket.value?.data?.collections?.total,
              data: CollectionData(
                mindBlowing:
                    bookMarket.value?.data?.collections?.data?.mindBlowing,
                popularCollections: bookMarket
                    .value?.data?.collections?.data?.popularCollections,
                newCollections:
                    bookMarket.value?.data?.collections?.data?.newCollections,
              ),
            ),
          );
          collectiondata.refresh();
        } catch (e) {
          print("Error processing collections data: $e");
        }
      }

      bookMarket.refresh();
      print("Books found: ${bookMarket.value?.data?.categories?.length ?? 0}");
      print("Collections found: ${collectiondata.value?.data?.data != null}");
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

  Future<BookMarketResponseModel> getListBooks() async {
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
          '${AppConfig.baseUrl}${AppConfig.getBookMarketHome}?lang=${Uri.encodeComponent(selectedLanguage == "en" ? "eng" : selectedLanguage == "ru" ? "rus" : "kaz")}';

      if (searchQuery.value.trim().isNotEmpty) {
        uri += '&description=${Uri.encodeComponent(searchQuery.value.trim())}';
      }
      // String uri = '${AppConfig.baseUrl}${AppConfig.getBookMasterHome}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return BookMarketResponseModel.fromJson(jsonBody);
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
    Get.to(() => const PgCoursedetail());
  }

  // Placeholder for continue button action
  void onContinuePressed() {
    // Add logic for continuing course
    print('Continue button pressed');
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
    // Add search logic here if needed (e.g., filter books)
  }

  void navigateToCategories() {
    // Uncomment and implement when PgCatergory is available
    // Get.to(() => const PgCatergory());
  }

  void navigateToMindchanging() {
    // Uncomment and implement when PgCollections is available
    // Get.to(() => PgCollections(label: 'Mindchanging 🤯'));
  }

  void navigateToSoulfulBooks() {
    // Uncomment and implement when PgCollections is available
    // Get.to(() => PgCollections(label: 'soulfulbooks 💔'));
  }

  void navigateToBestsellers() {
    // Uncomment and implement when PgCollections is available
    // Get.to(() => PgCollections(label: 'bestsellers 🔥'));
  }

  void navigateToAudiobooks() {
    // Uncomment and implement when PgCollections is available
    // Get.to(() => PgCollections(label: 'Audiobooks 🎧'));
  }

  void navigateToAudioBook(index) {
    Get.toNamed("/AudioPlayer", arguments: {
      "artist": getBookTitle(
          name: bookMarket?.value?.data?.audiobooks?[index].productId?.authorId
              ?.first.name),
      "image": bookMarket?.value?.data?.audiobooks?[index].productId?.image,
      "name":
          getBookTitle(name: bookMarket?.value?.data?.audiobooks?[index].name),
      "id": bookMarket?.value?.data?.audiobooks?[index].sId,
      "audio": bookMarket?.value?.data?.audiobooks?[index].file
    });
  }

  void navigateToAuthors() {
    Get.to(() => const PgAuthors());
  }

  void navigateToPublishers() {
    Get.to(() => const PgPublishers());
  }

  void continueReading() {
    // Implement continue reading logic here
  }

  // Add the missing method to navigate to collection details
  void navigateToCollection(String collectionId, String collectionName) {
    if (collectionId.isNotEmpty) {
      print("Navigating to collection: $collectionId - $collectionName");
      Get.toNamed("/collectionDetail", arguments: {
        "collectionId": collectionId,
        "collectionName": collectionName
      });
    }
  }
}
