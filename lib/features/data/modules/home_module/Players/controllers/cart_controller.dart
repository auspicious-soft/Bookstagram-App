import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../../app_settings/constants/app_config.dart';
import '../../../CourseModule/controller/course_page_detail_controller.dart';
import '../../../CourseModule/models/AddToCartResponseModel.dart';
import '../../../book_detail/Models/postOrderResponseModel.dart';
import '../../../book_detail/WebviewWidget.dart';
import '../Models/CartDetails.dart';

class CartController extends GetxController {
  var selLike = false.obs;
  var selLike2 = false.obs;
  var appplycoupn = false.obs;

  var selectedIndex = 0.obs;
  final RxBool isLoading = true.obs;
  final Rx<AddDetailResponseModel?> CartData =
      Rx<AddDetailResponseModel?>(null);
  final Rx<AddToCartResponseModel?> cartDelete =
      Rx<AddToCartResponseModel?>(null);

  final Rx<PostOrderResponseModel?> postOrderResponseModel =
      Rx<PostOrderResponseModel?>(null);

  // Sample cart items data
  final cartItems = [
    {
      'title': 'Carrie',
      'author': 'Stephen King',
      'publisher': 'Happy Life Publisher',
      'price': '1000 ₸',
      'image': 'assets/images/book.png', // Replace with actual asset path
    },
    {
      'title': 'The Shining',
      'author': 'Stephen King',
      'publisher': 'Happy Life Publisher',
      'price': '1000 ₸',
      'image': 'assets/images/book.png', // Replace with actual asset path
    },
  ].obs;

  @override
  void onReady() {
    AddToCartApicall();
    super.onReady();
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
      Get.find<PgCoursedetailController>()
          .CourseLessonDetail
          .value
          ?.data
          ?.isPurchased = true;
      Get.find<PgCoursedetailController>().CourseLessonDetail.refresh();
      Get.back();
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
            "productIds": CartData.value?.data?.productId,
            "totalAmount": getCartTotal(),
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

  // double getCartTotal() {
  //   double total = 0.0;
  //   final cartData = CartData.value?.data?.productId;
  //   if (cartData != null) {
  //     for (var item in cartData) {
  //       total += item.price ?? 0.0;
  //     }
  //   }
  //   return total;
  // }
  double getCartTotal() {
    double total = 0.0;
    final cartData = CartData.value?.data?.productId;

    if (cartData != null) {
      for (var item in cartData) {
        num price = item.price ?? 0.0;
        num discount = item.discountPercentage ?? 0.0;

        // Apply discount if available
        if (discount > 0) {
          price = price - (price * (discount / 100));
        }

        total += price;
      }
    }

    return total;
  }

  @override
  void onInit() {
    AddToCartApicall();
    super.onInit();
  }

  void toggleCoupon() {
    appplycoupn.value = !appplycoupn.value;
  }

  Future<void> AddToCartApicall() async {
    isLoading.value = true;
    try {
      var data = await AddToCart();
      CartData.value = data;
      CartData.refresh();
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> DeleteCartApicall({String? id, index}) async {
    isLoading.value = true;
    try {
      var data = await DeleteCartId(productId: id);
      cartDelete.value = data;
      CartData.value?.data?.productId?.removeAt(index);
      CartData.refresh();
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> DeleteWholeCartApicall() async {
    isLoading.value = true;
    try {
      var data = await DeleteCart();
      cartDelete.value = data;
      CartData.value?.data?.productId?.clear();
      CartData.refresh();
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

  Future<AddDetailResponseModel> AddToCart() async {
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
      final response = await httpClient.get(Uri.parse(uri), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonBody = json.decode(response.body);
        return AddDetailResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<AddToCartResponseModel> DeleteCartId({String? productId}) async {
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
          '${AppConfig.baseUrl}${AppConfig.AddToCartEndPoints}/${CartData.value?.data?.sId}';
      final response = await httpClient.patch(Uri.parse(uri),
          headers: headers, body: jsonEncode({"productId": productId}));
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

  Future<AddToCartResponseModel> DeleteCart() async {
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
      final response =
          await httpClient.delete(Uri.parse(uri), headers: headers);
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

  void removeFromCart(int index) {
    DeleteCartApicall(
        id: CartData.value?.data?.productId?[index]?.sId ?? "", index: index);
  }

  void proceedToPayment() {
    PostorderApicall();
    // Get.snackbar('Payment', 'Proceeding to payment with total: 2000 ₸');
  }

  void goBack() {
    Get.back();
  }
}
