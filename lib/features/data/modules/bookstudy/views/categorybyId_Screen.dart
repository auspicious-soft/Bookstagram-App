import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';

import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app_settings/components/loader.dart';
import '../../../../../app_settings/constants/app_config.dart';
import '../../../../../app_settings/constants/common_button.dart';
import '../../../../../app_settings/constants/helpers.dart';
import '../controllers/categoryById_controller.dart';

class CategorybyidScreen extends StatelessWidget {
  const CategorybyidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive dimensions
    final paddingVertical = screenHeight * 0.015; // 1.5% of screen height
    final paddingHorizontal = screenWidth * 0.03; // 3% of screen width
    final iconSize = screenWidth * 0.06; // 6% of screen width
    final imageHeight = screenHeight * 0.15; // 15% of screen height
    final gridCrossAxisSpacing = screenWidth * 0.05; // 5% of screen width
    final gridMainAxisSpacing = screenHeight * 0.02; // 2% of screen height

    // Determine crossAxisCount based on screen width
    final crossAxisCount =
        screenWidth > 600 ? 3 : 2; // 3 columns for tablets, 2 for phones

    return GetBuilder<CategorybyidController>(
      init: CategorybyidController(), // Initialize the controller
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: WidgetGlobalMargin(
              child: Obx(() => controller.isLoading.value == true
                  ? Container(
                      height: Get.height,
                      width: Get.width,
                      child: Center(child: LoadingScreen()))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: paddingVertical),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: iconSize,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Label(
                              txt: controller.getBookTitle(
                                  name: controller
                                      .bookStudy.value?.data?.category?.name),
                              type: TextTypes.f_20_500,
                              // textScaler: TextScaler.linear(screenWidth * 0.004),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.bottomSheet(
                                  StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      // Define state variables

                                      return SingleChildScrollView(
                                        child: Container(
                                          height: Get.height / 1.2,
                                          decoration: const BoxDecoration(
                                            color: AppColors.whiteColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Header
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text('  '),
                                                    Label(
                                                      txt: AppLocalization.of(
                                                              context)
                                                          .translate('Filter'),
                                                      type: TextTypes.f_17_500,
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        controller.getTeacherId(
                                                          controller
                                                              .bookStudy
                                                              .value
                                                              ?.data
                                                              ?.category
                                                              ?.sId,
                                                        );
                                                        Get.back(); // Close the bottom sheet
                                                      },
                                                      icon: Image.asset(
                                                        width: 30,
                                                        height: 30,
                                                        AppAssets.close,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Sorting Section
                                                Label(
                                                  txt: AppLocalization.of(
                                                          context)
                                                      .translate('sorting'),
                                                  forceColor: AppColors
                                                      .buttongroupBorder,
                                                  type: TextTypes.f_13_400,
                                                ),
                                                padVertical(20),
                                                // Default
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.filter.value =
                                                        AppLocalization.of(
                                                                context)
                                                            .translate(
                                                                'thedefault');
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Label(
                                                        txt: AppLocalization.of(
                                                                context)
                                                            .translate(
                                                                'thedefault'),
                                                        type:
                                                            TextTypes.f_16_500,
                                                      ),
                                                      Obx(() => controller
                                                                  .filter
                                                                  .value !=
                                                              AppLocalization.of(
                                                                      context)
                                                                  .translate(
                                                                      'thedefault')
                                                          ? Icon(
                                                              Icons
                                                                  .radio_button_off_outlined,
                                                              color:
                                                                  Colors.orange,
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .radio_button_checked,
                                                              color:
                                                                  Colors.orange,
                                                            ))
                                                    ],
                                                  ),
                                                ),
                                                padVertical(15),
                                                // Alphabetically
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.filter
                                                        .value = AppLocalization
                                                            .of(context)
                                                        .translate(
                                                            'alphabetically');
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Label(
                                                        txt: AppLocalization.of(
                                                                context)
                                                            .translate(
                                                                'alphabetically'),
                                                        type:
                                                            TextTypes.f_16_500,
                                                      ),
                                                      Obx(() => controller
                                                                  .filter
                                                                  .value !=
                                                              AppLocalization.of(
                                                                      context)
                                                                  .translate(
                                                                      'alphabetically')
                                                          ? Icon(
                                                              Icons
                                                                  .radio_button_off_outlined,
                                                              color:
                                                                  Colors.orange,
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .radio_button_checked,
                                                              color:
                                                                  Colors.orange,
                                                            ))
                                                    ],
                                                  ),
                                                ),
                                                padVertical(15),
                                                // By Rating
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.filter.value =
                                                        AppLocalization.of(
                                                                context)
                                                            .translate(
                                                                'byrating');
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Label(
                                                        txt: AppLocalization.of(
                                                                context)
                                                            .translate(
                                                                'byrating'),
                                                        type:
                                                            TextTypes.f_16_500,
                                                      ),
                                                      Obx(() => controller
                                                                  .filter
                                                                  .value !=
                                                              AppLocalization.of(
                                                                      context)
                                                                  .translate(
                                                                      'byrating')
                                                          ? Icon(
                                                              Icons
                                                                  .radio_button_off_outlined,
                                                              color:
                                                                  Colors.orange,
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .radio_button_checked,
                                                              color:
                                                                  Colors.orange,
                                                            ))
                                                    ],
                                                  ),
                                                ),
                                                padVertical(15),
                                                // By Novelty
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.filter.value =
                                                        AppLocalization.of(
                                                                context)
                                                            .translate(
                                                                'bynovelty');
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Label(
                                                        txt: AppLocalization.of(
                                                                context)
                                                            .translate(
                                                                'bynovelty'),
                                                        type:
                                                            TextTypes.f_16_500,
                                                      ),
                                                      Obx(() => controller
                                                                  .filter
                                                                  .value !=
                                                              AppLocalization.of(
                                                                      context)
                                                                  .translate(
                                                                      'bynovelty')
                                                          ? Icon(
                                                              Icons
                                                                  .radio_button_off_outlined,
                                                              color:
                                                                  Colors.orange,
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .radio_button_checked,
                                                              color:
                                                                  Colors.orange,
                                                            ))
                                                    ],
                                                  ),
                                                ),
                                                padVertical(15),
                                                SizedBox(
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.2),
                                                commonButton(
                                                  context: context,
                                                  onPressed: () {
                                                    controller.fetchBookStudy(
                                                        controller
                                                            .bookStudy
                                                            .value
                                                            ?.data
                                                            ?.category
                                                            ?.sId);
                                                    Get.back();
                                                  },
                                                  txt: AppLocalization.of(
                                                          context)
                                                      .translate('Filter'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  isScrollControlled: true,
                                  backgroundColor: AppColors.whiteColor,
                                );
                              },
                              child: Image.asset(
                                AppAssets.categoryfil,
                                width: iconSize,
                                height: iconSize * 1.25,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: paddingVertical),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: gridCrossAxisSpacing,
                              mainAxisSpacing: gridMainAxisSpacing,
                              childAspectRatio:
                                  0.75, // Adjust aspect ratio for better fit
                            ),
                            itemCount: controller
                                    .bookStudy.value?.data?.books?.length ??
                                0,
                            // Replace with controller.data.length if dynamic
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Example: Use controller to handle navigation
                                  // controller.navigateToCourseDetail(context);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height:
                                          imageHeight + (screenHeight * 0.08),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            screenWidth * 0.03),
                                      ),
                                      child: Column(
                                        children: [
                                          controller.bookStudy.value?.data
                                                      ?.books?[index]?.image !=
                                                  null
                                              ? Image.network(
                                                  height: 118,
                                                  "${AppConfig.imgBaseUrl}${controller.bookStudy.value?.data?.books?[index]?.image}",
                                                  fit: BoxFit.fill,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Image.asset(
                                                          height: 118,
                                                          AppAssets.book,
                                                          fit: BoxFit.contain),
                                                )
                                              : Image.asset(
                                                  height: 118,
                                                  AppAssets.book,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                          SizedBox(
                                              height: paddingVertical * 0.5),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      paddingHorizontal),
                                              child: Column(
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
                                                                ?.books?[index]
                                                                ?.name),
                                                    type: TextTypes.f_10_500,
                                                    // textScaler: TextScaler.linear(screenWidth * 0.003),
                                                    forceAlignment:
                                                        TextAlign.left,
                                                  ),
                                                  SizedBox(
                                                      height: paddingVertical *
                                                          0.5),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        size: iconSize * 0.8,
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                      Label(
                                                        txt: controller
                                                                .bookStudy
                                                                .value
                                                                ?.data
                                                                ?.books?[index]
                                                                ?.averageRating
                                                                .toString() ??
                                                            "",
                                                        type:
                                                            TextTypes.f_11_500,
                                                        // textScaler: TextScaler.linear(screenWidth * 0.003),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              paddingHorizontal),
                                                      Container(
                                                        height: iconSize * 0.6,
                                                        width: 1,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors
                                                              .buttongroupBorder,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              paddingHorizontal),
                                                      Label(
                                                        maxWidth: 50,
                                                        maxLines: 1,
                                                        txt: controller.getBookTitle(
                                                                name: controller
                                                                    .bookStudy
                                                                    .value
                                                                    ?.data
                                                                    ?.category
                                                                    ?.name) ??
                                                            "",
                                                        type:
                                                            TextTypes.f_11_500,
                                                        // textScaler: TextScaler.linear(screenWidth * 0.003),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )),
            ),
          ),
        );
      },
    );
  }
}
