import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/dashboard_controller.dart';
import '../controllers/cart_controller.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) {
        getBookTitle({required dynamic name}) {
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

        return Scaffold(
          backgroundColor: AppColors.background,
          resizeToAvoidBottomInset:
              true, // Allow resizing when keyboard appears
          body: SafeArea(
            child: SingleChildScrollView(
              // Wrap content in SingleChildScrollView
              child: WidgetGlobalMargin(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: controller.goBack,
                            ),
                            padVertical(10),
                            Label(
                              txt:
                                  AppLocalization.of(context).translate('cart'),
                              type: TextTypes.f_20_500,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.DeleteWholeCartApicall();
                          },
                          child: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                    const Divider(),
                    Obx(
                      () => controller.CartData.value?.data == null
                          ? Center(
                              child: Label(
                                txt: "No Item Found" ?? "",
                                type: TextTypes.f_17_500,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              // Ensure ListView fits content
                              physics: const NeverScrollableScrollPhysics(),
                              // Disable ListView scrolling
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: controller.CartData.value?.data
                                      ?.productId?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                final item = controller
                                    .CartData.value?.data?.productId?[index];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: item?.image != null
                                                    ? Image.network(
                                                        "${AppConfig.imgBaseUrl}${item?.image}",
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Center(
                                                        child: Image.asset(
                                                            "assets/images/book.png"),
                                                      ),
                                              ),
                                            ),
                                          ),
                                          padHorizontal(10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              padVertical(5),
                                              Label(
                                                txt: getBookTitle(
                                                        name: item?.name) ??
                                                    "",
                                                type: TextTypes.f_17_500,
                                              ),
                                              Text(
                                                getBookTitle(
                                                        name: item?.authorId
                                                                ?.first.name ??
                                                            "") ??
                                                    "",
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppConst.fontFamily,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor:
                                                      AppColors.resnd,
                                                  color: AppColors.resnd,
                                                ),
                                              ),
                                              Label(
                                                txt: item?.genre?.first ?? "",
                                                type: TextTypes.f_13_400,
                                                forceColor: AppColors.resnd,
                                              ),
                                              padVertical(10),
                                              Label(
                                                txt:
                                                    " ${item?.price?.toString()} ₸" ??
                                                        "",
                                                type: TextTypes.f_13_600,
                                                textDecoration:
                                                    item?.isDiscounted == true
                                                        ? TextDecoration
                                                            .lineThrough
                                                        : TextDecoration.none,
                                                forceColor: AppColors.resnd,
                                              ),
                                              item?.isDiscounted == true
                                                  ? Label(
                                                      txt:
                                                          "${(((item?.price ?? 0) - ((item?.price ?? 0) * ((item?.discountPercentage ?? 0)) / 100)).toStringAsFixed(0))} ₸",
                                                      type: TextTypes.f_13_600,
                                                      forceColor: AppColors.red,
                                                      textDecoration:
                                                          TextDecoration.none,
                                                    )
                                                  : SizedBox(),
                                              padVertical(10),
                                            ],
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () =>
                                            controller.removeFromCart(index),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                    // Add padding to ensure content is not obscured by keyboard
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Obx(
            () => controller.CartData.value?.data != null &&
                    controller.CartData.value?.data?.productId?.isNotEmpty ==
                        true
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(
                              () => controller.appplycoupn.value
                                  ? Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Row(
                                          children: [
                                            controller.VoucherResponse.value !=
                                                    null
                                                ? Image.asset(
                                                    AppAssets.greentick,
                                                    fit: BoxFit.contain,
                                                    width: 21,
                                                    height: 21,
                                                  ).marginOnly(left: 10)
                                                : SizedBox(),
                                            Expanded(
                                              child: TextField(
                                                controller:
                                                    controller.CouponCode,
                                                decoration: InputDecoration(
                                                  hintText: AppLocalization.of(
                                                          context)
                                                      .translate('entercopan'),
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 12.0),
                                                  hintStyle: const TextStyle(
                                                    color:
                                                        AppColors.inputBorder,
                                                    fontFamily:
                                                        AppConst.fontFamily,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              decoration: BoxDecoration(
                                                color: controller
                                                            .VoucherResponse
                                                            .value !=
                                                        null
                                                    ? AppColors.green
                                                    : AppColors.primaryColor,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(8.0),
                                                  bottomRight:
                                                      Radius.circular(8.0),
                                                ),
                                              ),
                                              child: IconButton(
                                                icon: Image.asset(
                                                  controller.VoucherResponse
                                                              .value !=
                                                          null
                                                      ? AppAssets.deletewhite
                                                      : AppAssets.applycoup,
                                                  fit: BoxFit.contain,
                                                  width: 21,
                                                  height: 21,
                                                ),
                                                onPressed: () {
                                                  if (controller.VoucherResponse
                                                          .value !=
                                                      null) {
                                                    controller.removeCoupon();
                                                  } else if (controller
                                                      .CouponCode
                                                      .text
                                                      .isNotEmpty) {
                                                    controller
                                                        .CartVoucherApicall();
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: controller.toggleCoupon,
                                      child: Text(
                                        AppLocalization.of(context)
                                            .translate('havecoupn'),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: AppConst.fontFamily,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              AppColors.primaryColor,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                            ),
                            padVertical(5),
                            // Add Checkbox for Wallet
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Obx(
                                  () => Checkbox(
                                    value: controller.useWallet.value,
                                    onChanged: (bool? value) {
                                      controller.useWallet.value =
                                          value ?? false;
                                      controller
                                          .update(); // Update UI if needed
                                    },
                                    activeColor: AppColors.primaryColor,
                                  ),
                                ),
                                Label(
                                  txt: AppLocalization.of(context)
                                          .translate('use_wallet_amount') ??
                                      'Do you want to use wallet amount?',
                                  type: TextTypes.f_15_400,
                                  forceColor: AppColors.blackColor,
                                ),
                              ],
                            ),
                            padVertical(5),
                            SizedBox(
                              width: ScreenUtils.screenWidth(context) / 1.2,
                              child: ElevatedButton(
                                onPressed: controller.proceedToPayment,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Label(
                                      txt: AppLocalization.of(context)
                                          .translate('paynow'),
                                      type: TextTypes.f_17_500,
                                      forceColor: AppColors.whiteColor,
                                    ),
                                    padHorizontal(15),
                                    Label(
                                      txt:
                                          "${controller.getFinalCartTotal()} ₸",
                                      type: TextTypes.f_17_500,
                                      forceColor: AppColors.whiteColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (Get.previousRoute == "/Course-detail" ||
                                    Get.previousRoute == "/book-detail") {
                                  Get.back();
                                } else {
                                  final dashboardController =
                                      Get.find<DashboardController>();
                                  dashboardController.changeTab(1);
                                }
                              },
                              child: Label(
                                txt: AppLocalization.of(context)
                                    .translate('morecatalog'),
                                type: TextTypes.f_17_500,
                                forceColor: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ),
        );
      },
    );
  }
}
