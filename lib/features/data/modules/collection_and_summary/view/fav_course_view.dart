import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/features/data/models/stock_model.dart';
import 'package:bookstagram/features/data/modules/collection_and_summary/controller/fav_courses_controller.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app_settings/components/loader.dart';
import '../../../../../app_settings/constants/app_config.dart' show AppConfig;
import '../../home_module/models/homeProductModel.dart';

class FavCourseView extends GetView<FavCoursesController> {
  const FavCourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: WidgetGlobalMargin(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      padVertical(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.black),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          Label(
                            txt: AppLocalization.of(context)
                                .translate('yourcourses'),
                            type: TextTypes.f_20_500,
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                backgroundColor: AppColors.whiteColor,
                                builder: (BuildContext context) {
                                  return FilterBottomSheet();
                                },
                              );
                            },
                            child: Image.asset(
                              width: 16,
                              height: 20,
                              AppAssets.categoryfil,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                      padVertical(15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final screenWidth = constraints.maxWidth;
                              const tabCount = 4; // Number of tabs
                              const tabWidth =
                                  120.0; // Fixed width for each tab
                              final RxDouble scrollOffset =
                                  0.0.obs; // Track scroll offset
                              final ScrollController scrollController =
                                  ScrollController();

                              // Update scroll offset when the ListView scrolls
                              scrollController.addListener(() {
                                scrollOffset.value = scrollController.offset;
                              });

                              // Scroll to the selected tab when it changes
                              void scrollToSelectedTab(int index) {
                                if (scrollController.hasClients) {
                                  final targetOffset = index * tabWidth;
                                  final maxScrollExtent =
                                      scrollController.position.maxScrollExtent;
                                  final adjustedOffset =
                                      targetOffset > maxScrollExtent
                                          ? maxScrollExtent
                                          : targetOffset;
                                  scrollController.animateTo(
                                    adjustedOffset,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              }

                              // Listen to selectedIndex changes and scroll to the selected tab
                              ever(controller.selectedIndex, (int index) {
                                scrollToSelectedTab(index);
                              });

                              return Column(
                                children: [
                                  SizedBox(
                                    height: 40, // Height for the tab bar
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      controller: scrollController,
                                      itemCount: tabCount,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller
                                                .updateSelectedIndex(index);
                                          },
                                          child: Container(
                                            width: tabWidth,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 10,
                                            ),
                                            alignment: Alignment.center,
                                            child: Obx(
                                              () => Text(
                                                AppLocalization.of(context)
                                                    .translate([
                                                  'favorites',
                                                  'studyingnow',
                                                  'completedcourses',
                                                  'certificates'
                                                ][index]),
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppConst.fontFamily,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: controller
                                                              .selectedIndex
                                                              .value ==
                                                          index
                                                      ? AppColors.primaryColor
                                                      : AppColors.blackColor,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        width: screenWidth,
                                        height: 2,
                                        color: Colors.grey.shade300,
                                      ),
                                      Obx(
                                        () => AnimatedPositioned(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          left:
                                              (controller.selectedIndex.value *
                                                      tabWidth) -
                                                  scrollOffset.value,
                                          width: tabWidth,
                                          height: 2,
                                          child: Container(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                      padVertical(10),
                      Obx(
                        () => controller.isLoading.value == true
                            ? Container(
                                height: Get.height * 0.5,
                                width: Get.width,
                                child: Center(child: LoadingScreen()))
                            : Column(children: [
                                controller.selectedIndex.value == 0
                                    ? (controller.collectiondata.value!.data !=
                                                null &&
                                            controller.collectiondata.value!
                                                .data!.isNotEmpty)
                                        ? Column(
                                            children: [
                                              Obx(() {
                                                final courses = controller
                                                        .collectiondata
                                                        .value
                                                        ?.data ??
                                                    [];
                                                print(
                                                    "${courses?.length}>>>>>>>>>>>>>>>{courses.length}>>>>>>>");

                                                return _buildCoursesRow(
                                                        courses, controller)
                                                    .marginSymmetric(
                                                        vertical: 10);
                                              }),
                                            ],
                                          )
                                        : Container(
                                            height: Get.height * 0.8,
                                            width: Get.width,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  AppAssets.noData,
                                                  height: 100,
                                                  width: 100,
                                                ),
                                                padVertical(10),
                                                Label(
                                                  txt:
                                                      "Nothing found on this request",
                                                  type: TextTypes.f_13_500,
                                                ),
                                              ],
                                            ),
                                          )
                                    : controller.selectedIndex.value == 1
                                        ? (controller.collectiondata.value!
                                                        .data !=
                                                    null &&
                                                controller.collectiondata.value!
                                                    .data!.isNotEmpty)
                                            ? Column(
                                                children: List.generate(
                                                    controller
                                                            .collectiondata
                                                            ?.value
                                                            ?.data
                                                            ?.length ??
                                                        0, (index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(
                                                          '/Course-detail',
                                                          arguments: {
                                                            "id": controller
                                                                .collectiondata
                                                                ?.value
                                                                ?.data?[index]
                                                                ?.bookId
                                                                ?.sId
                                                          });
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      child: Container(
                                                        width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10,
                                                                horizontal: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              AppColors.border,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                        ),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          10)),
                                                              child: controller
                                                                          .collectiondata
                                                                          ?.value
                                                                          ?.data?[
                                                                              index]
                                                                          ?.bookId
                                                                          ?.image !=
                                                                      null
                                                                  ? Image
                                                                      .network(
                                                                      height:
                                                                          80,
                                                                      width: 80,
                                                                      "${AppConfig.imgBaseUrl}${controller.collectiondata?.value?.data?[index]?.bookId?.image}",
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    )
                                                                  : Image.asset(
                                                                      AppAssets
                                                                          .book,
                                                                      fit: BoxFit
                                                                          .cover),
                                                            ),
                                                            padHorizontal(10),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                padVertical(10),
                                                                Label(
                                                                  txt:
                                                                      "${controller.getBookTitle(name: controller.collectiondata?.value?.data?[index]?.bookId?.name)}",
                                                                  type: TextTypes
                                                                      .f_15_500,
                                                                ),
                                                                Label(
                                                                  txt:
                                                                      "${controller.getBookTitle(name: controller.collectiondata?.value?.data?[index]?.bookId?.categoryId?.first?.name)}",
                                                                  type: TextTypes
                                                                      .f_15_400,
                                                                  forceColor:
                                                                      AppColors
                                                                          .resnd,
                                                                ),
                                                                padVertical(5),
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: ScreenUtils.screenWidth(
                                                                              context) /
                                                                          2.5,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        child: Obx(() =>
                                                                            LinearProgressIndicator(
                                                                              value: ((controller?.collectiondata?.value?.data?[index]?.progress ?? 0) / 100)?.toDouble(),
                                                                              backgroundColor: AppColors.inputBorder,
                                                                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                                                                            )),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            10),
                                                                    Label(
                                                                      txt:
                                                                          "${controller?.collectiondata?.value?.data?[index]?.progress?.toStringAsFixed(0)}%",
                                                                      type: TextTypes
                                                                          .f_12_400,
                                                                    ),
                                                                  ],
                                                                ),
                                                                padVertical(5),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              )
                                            : Container(
                                                height: Get.height * 0.8,
                                                width: Get.width,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      AppAssets.noData,
                                                      height: 100,
                                                      width: 100,
                                                    ),
                                                    padVertical(10),
                                                    Label(
                                                      txt:
                                                          "Nothing found on this request",
                                                      type: TextTypes.f_13_500,
                                                    ),
                                                  ],
                                                ),
                                              )
                                        : controller.selectedIndex.value == 2
                                            ? (controller.collectiondata.value!
                                                            .data !=
                                                        null &&
                                                    controller
                                                        .collectiondata
                                                        .value!
                                                        .data!
                                                        .isNotEmpty)
                                                ? Column(
                                                    children: List.generate(
                                                        controller
                                                                .collectiondata
                                                                ?.value
                                                                ?.data
                                                                ?.length ??
                                                            0, (index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Get.toNamed(
                                                              '/Course-detail',
                                                              arguments: {
                                                                "id": controller
                                                                    .collectiondata
                                                                    ?.value
                                                                    ?.data?[
                                                                        index]
                                                                    ?.bookId
                                                                    ?.sId
                                                              });
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 15),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .border,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18),
                                                            ),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              10)),
                                                                  child: controller
                                                                              .collectiondata
                                                                              ?.value
                                                                              ?.data?[
                                                                                  index]
                                                                              ?.bookId
                                                                              ?.image !=
                                                                          null
                                                                      ? Image
                                                                          .network(
                                                                          height:
                                                                              80,
                                                                          width:
                                                                              80,
                                                                          "${AppConfig.imgBaseUrl}${controller.collectiondata?.value?.data?[index]?.bookId?.image}",
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        )
                                                                      : Image.asset(
                                                                          AppAssets
                                                                              .book,
                                                                          fit: BoxFit
                                                                              .cover),
                                                                ),
                                                                padHorizontal(
                                                                    10),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    padVertical(
                                                                        10),
                                                                    Label(
                                                                      txt:
                                                                          "${controller.getBookTitle(name: controller.collectiondata?.value?.data?[index]?.bookId?.name)}",
                                                                      type: TextTypes
                                                                          .f_15_500,
                                                                    ),
                                                                    Label(
                                                                      txt:
                                                                          "${controller.getBookTitle(name: controller.collectiondata?.value?.data?[index]?.bookId?.categoryId?.first?.name)}",
                                                                      type: TextTypes
                                                                          .f_15_400,
                                                                      forceColor:
                                                                          AppColors
                                                                              .resnd,
                                                                    ),
                                                                    padVertical(
                                                                        5),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              ScreenUtils.screenWidth(context) / 2.5,
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            child: Obx(() =>
                                                                                LinearProgressIndicator(
                                                                                  value: ((controller?.collectiondata?.value?.data?[index]?.progress ?? 0) / 100)?.toDouble(),
                                                                                  backgroundColor: AppColors.inputBorder,
                                                                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                                                                                )),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                10),
                                                                        Label(
                                                                          txt:
                                                                              "${controller?.collectiondata?.value?.data?[index]?.progress?.toStringAsFixed(0)}%",
                                                                          type:
                                                                              TextTypes.f_12_400,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    padVertical(
                                                                        5),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  )
                                                : Container(
                                                    height: Get.height * 0.8,
                                                    width: Get.width,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          AppAssets.noData,
                                                          height: 100,
                                                          width: 100,
                                                        ),
                                                        padVertical(10),
                                                        Label(
                                                          txt:
                                                              "Nothing found on this request",
                                                          type: TextTypes
                                                              .f_13_500,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                            : (controller.collectiondata.value!
                                                            .data !=
                                                        null &&
                                                    controller
                                                        .collectiondata
                                                        .value!
                                                        .data!
                                                        .isNotEmpty)
                                                ? Column(
                                                    children: List.generate(
                                                        controller
                                                                .collectiondata
                                                                ?.value
                                                                ?.data
                                                                ?.length ??
                                                            0, (index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Get.toNamed(
                                                              "certificate",
                                                              arguments: {
                                                                "CourseID": controller
                                                                    .collectiondata
                                                                    ?.value
                                                                    ?.data?[
                                                                        index]
                                                                    ?.bookId
                                                                    ?.sId
                                                              });
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 15),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        20,
                                                                    horizontal:
                                                                        15),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .border,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                padVertical(10),
                                                                Label(
                                                                  txt:
                                                                      "${controller.getBookTitle(name: controller.collectiondata?.value?.data?[index]?.bookId?.name)}",
                                                                  type: TextTypes
                                                                      .f_15_500,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  )
                                                : Container(
                                                    height: Get.height * 0.8,
                                                    width: Get.width,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          AppAssets.noData,
                                                          height: 100,
                                                          width: 100,
                                                        ),
                                                        padVertical(10),
                                                        Label(
                                                          txt:
                                                              "Nothing found on this request",
                                                          type: TextTypes
                                                              .f_13_500,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                              ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCoursesRow(List<Course> courses, controller) {
  return SizedBox(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: courses.length, // Number of items to display
      itemBuilder: (context, index) {
        final course = courses[index]; // Get course at the current index
        print(
            "${course?.productId?.image}>>>>>>>>>>>>>>>{courses.length}>>>>>>>");
        return Padding(
          padding: const EdgeInsets.only(right: 12.0, bottom: 12.0),
          child: GestureDetector(
            onTap: () {
              Get.toNamed('/Course-detail',
                  arguments: {"id": course?.productId?.sId});
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Course image container
                Container(
                  height: 144,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: course.productId?.image != null
                          ? Image.network(
                              "${AppConfig.imgBaseUrl}${course.productId?.image}",
                              fit: BoxFit.cover,
                            )
                          : Image.asset(AppAssets.book, fit: BoxFit.cover),
                    ),
                  ),
                ),
                // Vertical padding
                padVertical(5),
                // Course title
                Label(
                  txt: controller.getBookTitle(name: course.productId?.name),
                  type: TextTypes.f_13_500,
                ),
                // Course info section
                SizedBox(
                  width: Get.width, // Use full width for alignment
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left side: Rating, divider, and author
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: AppColors.primaryColor,
                          ),
                          Label(
                            txt: course.productId?.averageRating?.toString() ??
                                'N/A',
                            type: TextTypes.f_11_500,
                          ),
                          padHorizontal(8),
                          // Divider line
                          Container(
                            height: 12,
                            width: 1,
                            decoration: BoxDecoration(
                              color: AppColors.buttongroupBorder,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          padHorizontal(8),
                          SizedBox(
                            width: 120,
                            child: Label(
                              txt: course.productId?.authorId != null &&
                                      course.productId!.authorId!.isNotEmpty
                                  ? controller.getBookTitle(
                                      name: course.productId!.authorId![0].name)
                                  : 'Unknown Author',
                              type: TextTypes.f_13_400,
                              forceColor: AppColors.resnd,
                            ),
                          ),
                        ],
                      ),
                      // Right side: Price row
                      Row(
                        children: [
                          course.productId?.isDiscounted == true
                              ? Text(
                                  "${course.productId?.price?.toString() ?? 'N/A'} ₸",
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: AppConst.fontFamily,
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 2,
                                    decorationColor: AppColors.blackColor,
                                    color: AppColors.blackColor,
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(width: 10),
                          Text(
                            course.productId?.isDiscounted == true
                                ? "${(((course.productId?.price ?? 0) - ((course.productId?.price ?? 0) * (course.productId?.discountPercentage ?? 0) / 100)).toStringAsFixed(0))} ₸"
                                : "${course.productId?.price?.toString() ?? 'N/A'} ₸",
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppConst.fontFamily,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
