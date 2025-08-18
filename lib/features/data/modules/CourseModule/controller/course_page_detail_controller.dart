import 'dart:convert';

import 'package:bookstagram/features/presentation/Pages/AuthorDetail/pg_authordetail.dart';
import 'package:bookstagram/features/presentation/Pages/Cart/pg_cartscreen.dart';
import 'package:bookstagram/features/presentation/Pages/Certificate/pg_certificate.dart';
import 'package:bookstagram/app_settings/components/review_sheet.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../../../../../app_settings/constants/common_button.dart';
import '../../../../../localization/app_localization.dart';
import '../../book_detail/Models/postOrderResponseModel.dart';
import '../../book_detail/WebviewWidget.dart';
import '../../home_module/Players/controllers/cart_controller.dart';
import '../models/AddToCartResponseModel.dart';
import '../models/CourseDetailModel.dart';
import '../models/CourseLessons_model.dart';
import '../models/GernateCerificateResponse.dart';
import '../models/ReviewsModel.dart';

class PgCoursedetailController extends GetxController {
  var selLike = false.obs;
  var selLike2 = false.obs;
  var listView = false.obs;
  var selectedIndex = 0.obs;
  var expandedStates = <int, bool>{}.obs; // Tracks expanded state per index
  final RxBool isLoading = true.obs;
  RxDouble rating = 0.0.obs;
  final TextEditingController _reviewController = TextEditingController();

  // final Rx<PostOrderResponseModel?> postOrderResponseModel =
  //     Rx<PostOrderResponseModel?>(null);
  final Rx<AddToCartResponseModel?> postOrderResponseModel =
      Rx<AddToCartResponseModel?>(null);
  final Rx<CourseDetailModel?> CourseDetail = Rx<CourseDetailModel?>(null);
  final Rx<CourseLessonsModel?> CourseLessonDetail =
      Rx<CourseLessonsModel?>(null);
  final Rx<ReviewResponseModel?> ReviewResponse =
      Rx<ReviewResponseModel?>(null);
  final Rx<GernateCrtifcateResponse?> gernateCrtifcateResponse =
      Rx<GernateCrtifcateResponse?>(null);
  final Rx<Ratings?> Rating = Rx<Ratings?>(null);
  var Id = "";

  @override
  void onInit() {
    if (Get.arguments != null) {
      Id = Get.arguments["id"];
      print(">>>>>>>>>>>>>>>>>>>.$Id>>>>>>>>>>>>>>>>>>>>>");
      fetchBookStudy(Id);
      fetchCourseLessons(Id);
    }
    super.onInit();
  }

  @override
  void onReady() {
    if (Get.arguments != null) {
      Id = Get.arguments["id"];
      print(">>>>>>>>>>>>>>>>>>>.$Id>>>>>>>>>>>>>>>>>>>>>");
      fetchBookStudy(Id);
      fetchCourseLessons(Id);
    }
    super.onReady();
  }

  Future<void> fetchBookStudy(String? id) async {
    isLoading.value = true;
    try {
      var data = await getCourseDetail(id);
      CourseDetail.value = data;
      CourseDetail.refresh();
      selLike.value = CourseDetail.value?.data?.favorite ?? false;
      Id = id ?? "";
      print(">>>>>>>>>>>ids>>>>>>>>.$Id>>>>>>>>>>>>>>>>>>>>>");
      fetchCourseLessons(CourseDetail.value?.data?.course?.sId);
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCourseLessons(String? id) async {
    isLoading.value = true;
    try {
      var data = await getLessonsDetail(id);
      CourseLessonDetail.value = data;
      CourseLessonDetail.refresh();
      fetchReviews(Id);
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
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

  Future<void> handelGernateCertificate(String? id) async {
    isLoading.value = true;
    try {
      var data = await GernateCertificate(id);
      gernateCrtifcateResponse.value = data;
      gernateCrtifcateResponse.refresh();
      CourseLessonDetail.value?.data?.courseCompleted == true;
      CourseLessonDetail.refresh();
      fetchCourseLessons(Id);
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  Future<CourseDetailModel> getCourseDetail(String? id) async {
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

      String uri = '${AppConfig.baseUrl}${AppConfig.getCourseById}/$id';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return CourseDetailModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<GernateCrtifcateResponse> GernateCertificate(String? id) async {
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

      String uri = '${AppConfig.baseUrl}${AppConfig.GernateCertificate}';

      final response = await httpClient.post(Uri.parse(uri),
          headers: headers,
          body: jsonEncode({
            "courseId": CourseDetail.value?.data?.course?.sId,
          }));

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return GernateCrtifcateResponse.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<CourseLessonsModel> getLessonsDetail(String? id) async {
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

      String uri =
          '${AppConfig.baseUrl}${AppConfig.getCourseLessons}/$id?lang=${Uri.encodeComponent(selectedLanguage == "en" ? "eng" : selectedLanguage == "ru" ? "rus" : "kaz")}';

      final response = await httpClient.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return CourseLessonsModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
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
          "productId": Id,
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

  void toggleListView(int index) {
    expandedStates[index] = !(expandedStates[index] ?? false);
    // Close other expanded items (optional: for single expansion)
    expandedStates.forEach((key, value) {
      if (key != index) expandedStates[key] = false;
    });
    expandedStates.refresh(); // Notify UI of changes
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  void navigateToAuthorDetail(String teacherId) {
    Get.toNamed("/teacherDetail", arguments: {"teacherId": teacherId});
  }

  void navigateToCertificate() {
    Get.toNamed("certificate",
        arguments: {"CourseID": CourseDetail.value?.data?.course?.sId});
  }

  void navigateToCart() async {
    if (CourseDetail.value?.data?.isAddedToCart == true) {
      Get.find<CartController>().AddToCartApicall();
      await Get.toNamed(
        '/Add-to-cart',
      );
      fetchBookStudy(Id);
      fetchCourseLessons(Id);
    } else {
      AddToCartApicall();
    }
  }

  Future<void> AddToCartApicall() async {
    if (CourseDetail.value?.data?.isAddedToCart == true) {
      return;
    }
    // isLoading.value = true;
    try {
      var data = await AddToCart();
      postOrderResponseModel.value = data;
      postOrderResponseModel.refresh();

      CourseDetail.value?.data?.isAddedToCart = true;
      CourseDetail.refresh();
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
            "productId": CourseDetail.value?.data?.course?.sId,
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
      fetchReviews(Id);
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
                                handleReviewsSubmit(Id);
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
}
