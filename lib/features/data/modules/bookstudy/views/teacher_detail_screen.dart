import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_more_text/read_more_text.dart';

import '../../../../../app_settings/components/loader.dart';
import '../../../../../app_settings/constants/app_config.dart';
import '../controllers/teacher_detail_controller.dart';

class PgTeacherProfile extends GetView<PgTeacherProfileController> {
  const PgTeacherProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Obx(
            () => controller.isLoading.value == true
                ? Container(
                    height: Get.height,
                    width: Get.width,
                    child: Center(child: LoadingScreen()))
                : Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.background.withOpacity(0.3),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    height: Get.height * 0.4,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: controller.bookStudy.value?.data
                                                    ?.image !=
                                                null
                                            ? NetworkImage(
                                                "${AppConfig.imgBaseUrl}${controller.bookStudy.value?.data?.image}",
                                              )
                                            : AssetImage(
                                                AppAssets.book,
                                              ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // Gradient overlay to create fading effect
                                  Container(
                                    height: Get.height * 0.4,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          AppColors.background.withOpacity(0.0),
                                          // Transparent at top
                                          AppColors.background.withOpacity(0.3),
                                          // Subtle fade
                                          AppColors.background.withOpacity(0.8),
                                          // Stronger fade
                                          AppColors.background,
                                          // Fully match background
                                        ],
                                        stops: const [0.0, 0.5, 0.8, 1.0],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).padding.top + 15,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back_ios,
                                        color: Colors.white),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  Obx(() => Label(
                                        txt: controller.getBookTitle(
                                            name: controller
                                                .bookStudy.value?.data?.name),
                                        type: TextTypes.f_20_500,
                                        forceColor: AppColors.whiteColor,
                                      )),
                                  IconButton(
                                    icon: const Icon(Icons.file_upload_outlined,
                                        color: Colors.white),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height / 3,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 120,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.white.withOpacity(0.9),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        AppColors.background.withOpacity(0.0),
                                        // Transparent at top
                                        AppColors.background.withOpacity(0.2),
                                        // Gradual fade
                                        AppColors.background.withOpacity(0.5),
                                        // Mid-point fade
                                        AppColors.background,
                                        // Full background color
                                      ],
                                      stops: const [0.0, 0.3, 0.7, 1.0],
                                    )),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        padVertical(8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Label(
                                                    txt:
                                                        controller.getBookTitle(
                                                            name: controller
                                                                .bookStudy
                                                                .value
                                                                ?.data
                                                                ?.name),
                                                    type: TextTypes.f_22_700),
                                                Wrap(
                                                  spacing: 2,
                                                  // Optional: controls spacing between children
                                                  children: controller
                                                          .bookStudy
                                                          .value
                                                          ?.data
                                                          ?.profession
                                                          ?.asMap()
                                                          .entries
                                                          .map((entry) {
                                                            return Text(
                                                              entry.value ?? '',
                                                              // Fallback for null values
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily: AppConst
                                                                    .fontFamily,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                color: AppColors
                                                                    .resnd,
                                                              ),
                                                            );
                                                          })
                                                          .toList()
                                                          ?.asMap()
                                                          .entries
                                                          .expand((entry) => [
                                                                entry.value,
                                                                if (entry.key <
                                                                    (controller.bookStudy.value?.data?.profession?.length ??
                                                                            0) -
                                                                        1)
                                                                  const Text(
                                                                    ',',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontFamily:
                                                                          AppConst
                                                                              .fontFamily,
                                                                      color: AppColors
                                                                          .resnd,
                                                                    ),
                                                                  ).marginSymmetric(
                                                                      horizontal:
                                                                          5),
                                                              ])
                                                          .toList() ??
                                                      [], // Fallback for null list
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        padVertical(8),
                                        Label(
                                          txt: AppLocalization.of(context)
                                              .translate('country'),
                                          type: TextTypes.f_13_500,
                                          forceColor: AppColors.resnd,
                                        ),
                                        Label(
                                          txt: controller.bookStudy.value?.data
                                                  ?.country ??
                                              "",
                                          type: TextTypes.f_17_500,
                                        ),
                                        padVertical(10),
                                        ReadMoreText(
                                          controller.getBookTitle(
                                              name: controller.bookStudy.value
                                                  ?.data?.description),
                                          numLines: 3,
                                          readMoreTextStyle: TextStyle(
                                            color: AppColors.resnd,
                                            // Match the forceColor from Label
                                            fontFamily: AppConst.fontFamily,
                                            // From Label's fontStyle
                                            fontWeight: FontWeight.w500,
                                            // From TextTypes.f_16_500
                                            fontSize:
                                                16, // From TextTypes.f_16_500
                                          ),
                                          readMoreAlign: Alignment.center,
                                          readMoreText: 'Read more',
                                          readLessText: 'Read less',
                                          readMoreIconColor: Colors.grey,
                                          style: TextStyle(
                                            color: AppColors.resnd,
                                            // Match the forceColor from Label
                                            fontFamily: AppConst.fontFamily,
                                            // From Label's fontStyle
                                            fontWeight: FontWeight.w500,
                                            // From TextTypes.f_16_500
                                            fontSize:
                                                16, // From TextTypes.f_16_500
                                          ), // Content text style to match Label
                                        ),
                                        padVertical(10),
                                        Label(
                                          txt: AppLocalization.of(context)
                                              .translate('Categories'),
                                          type: TextTypes.f_15_500,
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: List.generate(
                                                controller.bookStudy.value?.data
                                                        ?.genres?.length ??
                                                    0, (index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 12.0,
                                                    top: 10,
                                                    bottom: 10),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.black12,
                                                        blurRadius: 4,
                                                        offset: Offset(0, 2),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Label(
                                                    txt:
                                                        "🔍 ${controller.bookStudy.value?.data?.genres?[index] ?? ""}",
                                                    type: TextTypes.f_18_400,
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                        padVertical(20),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Label(
                                                txt: AppLocalization.of(context)
                                                    .translate(
                                                        'lecturecourses'),
                                                type: TextTypes.f_15_500,
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 18,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: List.generate(
                                              controller.bookStudy.value
                                                      ?.authorBooks?.length ??
                                                  0, (index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12.0, top: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 144,
                                                    width: Get.width,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        child: controller
                                                                    .bookStudy
                                                                    .value
                                                                    ?.authorBooks?[
                                                                        index]
                                                                    ?.image !=
                                                                null
                                                            ? Image.network(
                                                                "${AppConfig.imgBaseUrl}${controller.bookStudy.value?.authorBooks?[index]?.image}",
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorBuilder: (context,
                                                                        error,
                                                                        stackTrace) =>
                                                                    Image.asset(
                                                                        AppAssets
                                                                            .book,
                                                                        fit: BoxFit
                                                                            .contain),
                                                              )
                                                            : Image.asset(
                                                                AppAssets.book,
                                                                fit: BoxFit
                                                                    .contain),
                                                      ),
                                                    ),
                                                  ),
                                                  padVertical(5),
                                                  Label(
                                                    txt: controller.getBookTitle(
                                                        name: controller
                                                                .bookStudy
                                                                .value
                                                                ?.authorBooks?[
                                                                    index]
                                                                ?.name ??
                                                            'Unknown'),
                                                    type: TextTypes.f_13_500,
                                                  ),
                                                  SizedBox(
                                                    width: 240,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.star,
                                                              size: 16,
                                                              color: AppColors
                                                                  .primaryColor,
                                                            ),
                                                            Label(
                                                              txt: (controller
                                                                          .bookStudy
                                                                          .value
                                                                          ?.authorBooks?[
                                                                              index]
                                                                          ?.averageRating ??
                                                                      0.0)
                                                                  .toString(),
                                                              type: TextTypes
                                                                  .f_11_500,
                                                            ),
                                                            padHorizontal(8),
                                                            Container(
                                                              height: 12,
                                                              width: 1,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColors
                                                                    .buttongroupBorder,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                              ),
                                                            ),
                                                            padHorizontal(8),
                                                            SizedBox(
                                                              width: 120,
                                                              child: Label(
                                                                txt: controller.getBookTitle(
                                                                    name: controller
                                                                        .bookStudy
                                                                        .value
                                                                        ?.data
                                                                        ?.name),
                                                                type: TextTypes
                                                                    .f_13_400,
                                                                forceColor:
                                                                    AppColors
                                                                        .resnd,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            if (controller
                                                                    .bookStudy
                                                                    .value
                                                                    ?.authorBooks?[
                                                                        index]
                                                                    ?.isDiscounted ==
                                                                true)
                                                              Text(
                                                                controller
                                                                        .bookStudy
                                                                        .value
                                                                        ?.authorBooks?[
                                                                            index]
                                                                        ?.price
                                                                        ?.toString() ??
                                                                    '0',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      AppConst
                                                                          .fontFamily,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  decorationThickness:
                                                                      2,
                                                                  decorationColor:
                                                                      AppColors
                                                                          .blackColor,
                                                                  color: AppColors
                                                                      .blackColor,
                                                                ),
                                                              ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              controller
                                                                          .bookStudy
                                                                          .value
                                                                          ?.authorBooks?[
                                                                              index]
                                                                          ?.isDiscounted ==
                                                                      true
                                                                  ? (controller.bookStudy.value?.authorBooks?[index]?.price !=
                                                                              null
                                                                          ? (controller.bookStudy.value?.authorBooks?[index]?.price) ??
                                                                              0 *
                                                                                  (1 -
                                                                                      (controller.bookStudy.value?.authorBooks?[index]?.discountPercentage ?? 0) /
                                                                                          100)
                                                                          : 0)
                                                                      .toStringAsFixed(
                                                                          2)
                                                                  : (controller
                                                                              .bookStudy
                                                                              .value
                                                                              ?.authorBooks?[
                                                                                  index]
                                                                              ?.price ??
                                                                          0)
                                                                      .toStringAsFixed(
                                                                          2),
                                                              style: TextStyle(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily: AppConst
                                                                    .fontFamily,
                                                                color: AppColors
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ).marginSymmetric(vertical: 20),
                                      ],
                                    ).marginSymmetric(
                                        horizontal: 20, vertical: 20))
                                .marginOnly(top: Get.height * 0.25),
                          ],
                        ),
                      ],
                    )),
          ),
        ));
  }
}
