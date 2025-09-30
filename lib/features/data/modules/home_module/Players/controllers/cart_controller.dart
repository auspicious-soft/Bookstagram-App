import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../../../../../app_settings/constants/app_config.dart';
import '../../../CourseModule/controller/course_page_detail_controller.dart';
import '../../../CourseModule/models/AddToCartResponseModel.dart';
import '../../../book_detail/Models/postOrderResponseModel.dart';
import '../../../book_detail/WebviewWidget.dart';
import '../../../book_detail/controller/bookdetail.controller.dart';
import '../../models/VoucherResponseModel.dart';
import '../Models/CartDetails.dart';

class CartController extends GetxController {
  var selLike = false.obs;
  var selLike2 = false.obs;
  var appplycoupn = false.obs;
  final RxBool useWallet = false.obs;

// Example static wallet amount; replace with API-fetched value
  TextEditingController CouponCode = TextEditingController();
  var selectedIndex = 0.obs;
  final RxBool isLoading = true.obs;
  final Rx<AddDetailResponseModel?> CartData =
      Rx<AddDetailResponseModel?>(null);
  final Rx<AddToCartResponseModel?> cartDelete =
      Rx<AddToCartResponseModel?>(null);
  final Rx<VoucherResponseModel?> VoucherResponse =
      Rx<VoucherResponseModel?>(null);
  final Rx<PostOrderResponseModel?> postOrderResponseModel =
      Rx<PostOrderResponseModel?>(null);

  @override
  void onInit() {
    AddToCartApicall();
    super.onInit();
  }

  @override
  void onReady() {
    AddToCartApicall();
    super.onReady();
  }

  // Calculate base cart total with individual item discounts
  double getCartTotal() {
    double total = 0.0;
    final cartData = CartData.value?.data?.productId;

    if (cartData != null) {
      for (var item in cartData) {
        num price = item.price ?? 0.0;
        num discount = item.discountPercentage ?? 0.0;

        if (discount > 0) {
          price = price - (price * (discount / 100));
        }

        total += price;
      }
    }

    return total;
  }

  // Calculate final cart total after applying voucher discount and wallet amount
  double getFinalCartTotal() {
    double cartTotal = getCartTotal();

    // Apply voucher discount if applicable
    if (appplycoupn.value && VoucherResponse.value?.data?.percentage != null) {
      num voucherDiscountPercentage =
          VoucherResponse.value?.data?.percentage?.toInt() ?? 0;
      cartTotal = cartTotal - (cartTotal * (voucherDiscountPercentage / 100));
    }

    // Subtract wallet amount if useWallet is true
    if (useWallet.value && (CartData.value?.balance?.wallet ?? 0) > 0) {
      cartTotal -= CartData.value?.balance?.wallet ?? 0;
      if (cartTotal < 0) cartTotal = 0.0; // Ensure total doesn't go negative
    }

    return cartTotal;
  }

  void toggleCoupon() {
    appplycoupn.value = !appplycoupn.value;
    if (!appplycoupn.value) {
      removeCoupon(); // Clear coupon when toggling off
    } else if (CouponCode.text.isNotEmpty) {
      CartVoucherApicall(); // Fetch voucher details when coupon is toggled on
    }
  }

  void removeCoupon() {
    VoucherResponse.value = null;
    CouponCode.clear();
    VoucherResponse.refresh();
  }

  Future<void> AddToCartApicall() async {
    isLoading.value = true;
    try {
      var data = await AddToCart();
      CartData.value = data;
      CartData.refresh();
    } catch (e) {
      print("Error fetching cart: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> DeleteCartApicall({String? id, required int index}) async {
    isLoading.value = true;
    try {
      var data = await DeleteCartId(productId: id);
      cartDelete.value = data;
      CartData.value?.data?.productId?.removeAt(index);
      CartData.refresh();
    } catch (e) {
      print("Error deleting cart item: $e");
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
      print("Error deleting cart: $e");
    } finally {
      isLoading.value = false;
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
      await AddToCartApicall();
      Get.find<PgCoursedetailController>()
          .CourseLessonDetail
          .value
          ?.data
          ?.isPurchased = true;
      Get.find<PgCoursedetailController>().CourseLessonDetail.refresh();
      Get.back();
    } catch (e) {
      print("Error posting order: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> FreePostorderApicall() async {
    isLoading.value = true;
    try {
      var data = await FreepostOrderBooks();
      postOrderResponseModel.value = data;
      postOrderResponseModel.refresh();
      await AddToCartApicall();
      if (Get.previousRoute == "/book-detail") {
        Get.find<PgBookViewController>()
            .bookDetailResponseModel
            .value
            ?.data
            ?.isPurchased = true;
        Get.find<PgBookViewController>().bookDetailResponseModel.refresh();
        Get.back();
      } else {
        Get.put(PgCoursedetailController())
            .CourseLessonDetail
            .value
            ?.data
            ?.isPurchased = true;
        Get.put(PgCoursedetailController()).CourseLessonDetail.refresh();
        Get.back();
      }
    } catch (e) {
      print("Error posting free order: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> CartVoucherApicall() async {
    isLoading.value = true;
    try {
      var data = await CartVoucher(CouponCode.text);
      VoucherResponse.value = data;
      VoucherResponse.refresh();
    } catch (e) {
      print("Error fetching voucher: $e");
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
        throw Exception('Failed to fetch cart: ${response.statusCode}');
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
        throw Exception('Failed to delete cart item: ${response.statusCode}');
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
        throw Exception('Failed to delete cart: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
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
            "productIds": CartData.value?.data?.productId
                ?.map((item) => item.sId)
                .toList(),
            "redeemPoints":
                useWallet.value ? CartData.value?.balance?.wallet ?? 0 : 0,
            "totalAmount": getFinalCartTotal(),
            "voucherId": VoucherResponse?.value != null
                ? VoucherResponse?.value?.data?.sId
                : null,
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonBody = json.decode(response.body);
        return PostOrderResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to post order: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<PostOrderResponseModel> FreepostOrderBooks() async {
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
      String uri = '${AppConfig.baseUrl}api/user/order/free-products';
      final response = await httpClient.post(Uri.parse(uri),
          headers: headers,
          body: jsonEncode({
            "productIds": CartData.value?.data?.productId
                ?.map((item) => item.sId)
                .toList(),
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonBody = json.decode(response.body);
        return PostOrderResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to post free order: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<VoucherResponseModel> CartVoucher(String? voucher) async {
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
      String uri = '${AppConfig.baseUrl}api/user/vouchers/$voucher';
      final response = await httpClient.post(Uri.parse(uri),
          headers: headers,
          body: jsonEncode({
            "productIds": CartData.value?.data?.productId
                ?.map((item) => item.sId)
                .toList(),
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonBody = json.decode(response.body);
        return VoucherResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch voucher: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  void removeFromCart(int index) {
    DeleteCartApicall(
      id: CartData.value?.data?.productId?[index].sId ?? "",
      index: index,
    );
  }

  void proceedToPayment() {
    if (getFinalCartTotal() == 0) {
      FreePostorderApicall();
    } else {
      PostorderApicall();
    }
  }

  void goBack() {
    Get.back();
  }
}
