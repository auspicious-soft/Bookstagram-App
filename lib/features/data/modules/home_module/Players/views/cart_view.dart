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

import '../controllers/cart_controller.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) {
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

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
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
                            txt: AppLocalization.of(context).translate('cart'),
                            type: TextTypes.f_20_500,
                          ),
                        ],
                      ),
                      GestureDetector(
                          onTap: () {
                            controller.DeleteWholeCartApicall();
                          },
                          child: const Icon(Icons.delete)),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: Obx(
                      () => controller.CartData.value?.data == null
                          ? Center(
                              child: Label(
                                txt: "No Item Found" ?? "",
                                type: TextTypes.f_17_500,
                              ),
                            )
                          : ListView.builder(
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
                                                            "assets/images/book.png")),
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
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Obx(() => controller.CartData.value?.data !=
                      null ||
                  controller.CartData.value?.data?.productId?.length == 0
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
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
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalization.of(context)
                                                    .translate('entercopan'),
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 12.0),
                                            hintStyle: const TextStyle(
                                              color: AppColors.inputBorder,
                                              fontFamily: AppConst.fontFamily,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        decoration: const BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0),
                                          ),
                                        ),
                                        child: IconButton(
                                          icon: Image.asset(
                                            AppAssets.applycoup,
                                            fit: BoxFit.contain,
                                            width: 21,
                                            height: 21,
                                          ),
                                          onPressed: controller.toggleCoupon,
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
                                    decorationColor: AppColors.primaryColor,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
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
                                txt: "${controller.getCartTotal()} ₸",
                                type: TextTypes.f_17_500,
                                forceColor: AppColors.whiteColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
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
                )
              : SizedBox()),
        );
      },
    );
  }
}
