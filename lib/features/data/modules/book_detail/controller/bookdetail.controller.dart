import 'dart:convert';

import 'package:bookstagram/features/data/modules/book_detail/Models/postOrderResponseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../../../../../app_settings/constants/common_button.dart';
import '../../../../../localization/app_localization.dart';
import '../../../../presentation/Pages/About/Widgets/webview.dart';
import '../../CourseModule/models/AddToCartResponseModel.dart';
import '../../CourseModule/models/ReviewsModel.dart';
import '../../home_module/Players/controllers/cart_controller.dart';
import '../Models/bookDetailResponseModel.dart';
import '../WebviewWidget.dart';

class PgBookViewController extends GetxController {
  var selLike = false.obs;
  var selLike2 = false.obs;
  var selectedIndex = 0.obs;
  var bookId = "";
  RxDouble rating = 0.0.obs;
  final TextEditingController _reviewController = TextEditingController();
  final Rx<Ratings?> Rating = Rx<Ratings?>(null);
  final RxBool isLoading = false.obs;
  final Rx<ReviewResponseModel?> ReviewResponse =
      Rx<ReviewResponseModel?>(null);
  final Rx<AddToCartResponseModel?> addtocartDetail =
      Rx<AddToCartResponseModel?>(null);

  // BookDetailResponseModel bookDetailResponseModel;
  final Rx<BookDetailResponseModel?> bookDetailResponseModel =
      Rx<BookDetailResponseModel?>(null);
  final Rx<PostOrderResponseModel?> postOrderResponseModel =
      Rx<PostOrderResponseModel?>(null);

  @override
  void onInit() {
    if (Get.arguments != null) {
      bookId = Get.arguments["id"];
      fetchBookStudy();
    }

    super.onInit();
  }

  void showReviewSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent, // To allow rounded corners
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 15,
                  top: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Review',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: controller,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Enjoying the book?',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Obx(() => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (index) {
                                    return IconButton(
                                      icon: Icon(
                                        index < rating.value
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: index < rating.value
                                            ? Colors.amber
                                            : Colors.grey,
                                        size: 35,
                                      ),
                                      onPressed: () {
                                        rating.value = index + 1;
                                        rating.refresh();
                                      },
                                    );
                                  }),
                                )),
                            const SizedBox(height: 30),
                            const Text(
                              'Tap to rate',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextField(
                              controller: _reviewController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: 'Write your review',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 20),
                            commonButton(
                              context: context,
                              onPressed: () {
                                handleReviewsSubmit(bookId);
                                Navigator.pop(context);
                              },
                              txt:
                                  AppLocalization.of(context).translate('next'),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void navigateToCart() async {
    if (bookDetailResponseModel.value?.data?.isAddedToCart == true) {
      Get.find<CartController>().AddToCartApicall();
      await Get.toNamed(
        '/Add-to-cart',
      );
      fetchBookStudy();
    } else {
      AddToCartApicall();
    }
  }

  Future<void> AddToCartApicall() async {
    if (bookDetailResponseModel.value?.data?.isAddedToCart == true) {
      return;
    }
    // isLoading.value = true;
    try {
      var data = await AddToCart();
      addtocartDetail.value = data;
      addtocartDetail.refresh();

      bookDetailResponseModel.value?.data?.isAddedToCart = true;
      bookDetailResponseModel.refresh();
      // await Get.to(() => WebView(
      //       title: "Payment",
      //       url: postOrderResponseModel.value?.data?.payment?.redirectUrl ?? "",
      //     ));
      // fetchBookStudy(CourseDetail.value?.data?.course?.sId);
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<AddToCartResponseModel> AddToCart() async {
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
      String uri = '${AppConfig.baseUrl}${AppConfig.AddToCartEndPoints}';
      final response = await httpClient.post(Uri.parse(uri),
          headers: headers,
          body: jsonEncode({
            "productId": bookDetailResponseModel.value?.data?.book?.sId,
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonBody = json.decode(response.body);
        return AddToCartResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<void> handleReviewsSubmit(String? id) async {
    try {
      var data = await postReviewsDetail(id);
      Rating.value = data;
      Rating.refresh();
      fetchReviews(bookId);
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<Ratings> postReviewsDetail(String? id) async {
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

      String uri = '${AppConfig.baseUrl}${AppConfig.ReviewsEndPoints}/$id';

      final response = await httpClient.put(
        Uri.parse(uri),
        headers: headers,
        body: jsonEncode({
          "rating": rating.value,
          "comment": _reviewController.text,
        }),
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return Ratings.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<void> fetchBookStudy() async {
    isLoading.value = true;
    try {
      var data = await getListBooks();
      bookDetailResponseModel.value = data;
      bookDetailResponseModel.refresh();
      selLike.value = bookDetailResponseModel.value?.data?.favorite ?? false;
      fetchReviews(bookId);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
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
          return name.eng?.toString() ??
              name.kaz?.toString() ??
              name.rus?.toString() ??
              defaultTitle;
        case 'kk':
          return name.kaz?.toString() ??
              name.eng?.toString() ??
              name.rus?.toString() ??
              defaultTitle;
        case 'ru':
          return name.rus?.toString() ??
              name.eng?.toString() ??
              name.kaz?.toString() ??
              defaultTitle;
        default:
          return name.eng?.toString() ??
              name.kaz?.toString() ??
              name.rus?.toString() ??
              defaultTitle;
      }
    } catch (e) {
      // Handle case where name is not null but doesn't have the expected properties
      print("Error in getBookTitle: $e");
      return defaultTitle;
    }
  }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  Future<BookDetailResponseModel> getListBooks() async {
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
          '${AppConfig.baseUrl}${AppConfig.getBookbyIdEndPoints}/${bookId}?lang=${Uri.encodeComponent(selectedLanguage == "en" ? "eng" : selectedLanguage == "ru" ? "rus" : "kaz")}';

      // String uri = '${AppConfig.baseUrl}${AppConfig.getBookMasterHome}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return BookDetailResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<void> PostorderApicall() async {
    isLoading.value = true;
    try {
      var data = await postOrderBooks();
      postOrderResponseModel.value = data;
      postOrderResponseModel.refresh();

      await Get.to(() => WebView(
            title: "Payment",
            url: postOrderResponseModel.value?.data?.payment?.redirectUrl ?? "",
          ));
      fetchBookStudy();
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<PostOrderResponseModel> postOrderBooks() async {
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
      String uri = '${AppConfig.baseUrl}${AppConfig.postOrdersEndPoints}';
      final response = await httpClient.post(Uri.parse(uri),
          headers: headers,
          body: jsonEncode({
            "productIds": [bookDetailResponseModel.value?.data?.book?.sId],
            "totalAmount": bookDetailResponseModel.value?.data?.book?.price,
            // "voucherId": "6790d426454c2938059091bc"
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonBody = json.decode(response.body);
        return PostOrderResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<void> fetchReviews(String? id) async {
    isLoading.value = true;
    try {
      var data = await getReviewsDetail(id);
      ReviewResponse.value = data;
      ReviewResponse.refresh();
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<ReviewResponseModel> getReviewsDetail(String? id) async {
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
      // String uri =
      //     '${AppConfig.baseUrl}${AppConfig.getBookMarketHome}?lang=${Uri.encodeComponent(selectedLanguage == "en" ? "eng" : selectedLanguage == "ru" ? "rus" : "kaz")}';

      String uri = '${AppConfig.baseUrl}${AppConfig.ReviewsEndPoints}/$id';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return ReviewResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  void toggleLike() {
    selLike.value = !selLike.value;
    handleFavorite();
  }

  Future<void> handleFavorite() async {
    try {
      var data = await postlike();
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<Ratings> postlike() async {
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

      String uri = '${AppConfig.baseUrl}${AppConfig.postLikeEndPoint}';

      final response = await httpClient.put(
        Uri.parse(uri),
        headers: headers,
        body: jsonEncode({
          "productId": bookId,
          "favorite": selLike.value,
        }),
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return Ratings.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
