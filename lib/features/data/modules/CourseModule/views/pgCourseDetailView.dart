import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/loader.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/features/data/modules/CourseModule/models/CourseDetailModel.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:read_more_text/read_more_text.dart';

import '../controller/course_page_detail_controller.dart';

class PgCoursedetail extends GetView<PgCoursedetailController> {
  const PgCoursedetail({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Set status bar color
        statusBarIconBrightness:
            Brightness.dark, // Ensure icons are visible on white
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Obx(() => controller.isLoading.value == true
            ? Container(
                height: Get.height,
                width: Get.width,
                child: Center(child: LoadingScreen()))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.network(
                        "${AppConfig.imgBaseUrl}${controller.CourseDetail.value?.data?.course?.image ?? ""}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: ScreenUtils.screenHeight(context) / 2.3,
                      ),
                      Positioned(
                          top: MediaQuery.of(context).padding.top + 15,
                          left: 0,
                          right: 0,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    color: AppColors.whiteColor,
                                    Icons.arrow_back_ios,
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                SizedBox(
                                  width: Get.width * 0.7,
                                  child: Center(
                                    child: Label(
                                      txt: controller.getBookTitle(
                                          name: controller.CourseDetail.value
                                              ?.data?.course?.name),
                                      type: TextTypes.f_20_500,
                                      forceColor: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                                // IconButton(
                                //   icon: Image.asset(
                                //     AppAssets.dots,
                                //     fit: BoxFit.contain,
                                //     width: 18,
                                //     height: 4,
                                //   ),
                                //   onPressed: () {
                                //     Get.back();
                                //   },
                                // ),
                              ])),
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
                    ],
                  ),
                  WidgetGlobalMargin(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      padVertical(10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Label(
                                      txt: controller.getBookTitle(
                                          name: controller.CourseDetail.value
                                              ?.data?.course?.name),
                                      type: TextTypes.f_22_700),
                                  Text(
                                    controller.getBookTitle(
                                        name: controller.CourseDetail.value
                                            ?.data?.course?.authorId?[0].name),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppConst.fontFamily,
                                        decoration: TextDecoration.underline,
                                        color: AppColors.resnd),
                                  ),
                                  Text(
                                    "${controller.CourseDetail.value?.data?.course?.genre}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppConst.fontFamily,
                                        decoration: TextDecoration.underline,
                                        color: AppColors.resnd),
                                  ),
                                ]),
                            Obx(() => IconButton(
                                  onPressed: controller.toggleLike,
                                  icon: Image.asset(
                                    controller.selLike.value
                                        ? AppAssets.liked
                                        : AppAssets.unliked,
                                    fit: BoxFit.contain,
                                    width: 52,
                                    height: 55,
                                  ),
                                )),
                          ]),
                      padVertical(25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final screenWidth = constraints.maxWidth;
                              final tabWidth = screenWidth / 3;
                              return Column(
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        for (int index = 0; index < 3; index++)
                                          GestureDetector(
                                            onTap: () => controller
                                                .setSelectedIndex(index),
                                            child: Container(
                                              width: tabWidth,
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              alignment: Alignment.center,
                                              child: Obx(() => Text(
                                                    AppLocalization.of(context)
                                                        .translate([
                                                      AppLocalization.of(
                                                              context)
                                                          .translate(
                                                              'information'),
                                                      AppLocalization.of(
                                                              context)
                                                          .translate('lessons'),
                                                      "${AppLocalization.of(context).translate('reviews')}(${controller.ReviewResponse.value?.data?.ratings?.length ?? 0})",
                                                    ][index]),
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppConst.fontFamily,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: controller
                                                                  .selectedIndex
                                                                  .value ==
                                                              index
                                                          ? AppColors
                                                              .primaryColor
                                                          : AppColors
                                                              .inputBorder,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        width: screenWidth,
                                        height: 2,
                                        color: Colors.grey.shade300,
                                      ),
                                      Obx(() => AnimatedPositioned(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            left:
                                                controller.selectedIndex.value *
                                                    tabWidth,
                                            width: tabWidth,
                                            height: 2,
                                            child: Container(
                                                color: AppColors.primaryColor),
                                          )),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                      padVertical(20),
                      Obx(() => controller.selectedIndex.value == 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          height: 75,
                                          width: 75,
                                          decoration: BoxDecoration(
                                            color: AppColors.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  height: 30,
                                                  width: 30,
                                                  AppAssets.lessons,
                                                  fit: BoxFit.contain,
                                                ),
                                                padVertical(3),
                                                Label(
                                                    txt:
                                                        '${controller.CourseDetail.value?.data?.course?.lessons} ${AppLocalization.of(context).translate('lessons')}',
                                                    type: TextTypes.f_12_400)
                                              ])),
                                      GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                              height: 75,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                color: AppColors.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      height: 30,
                                                      width: 30,
                                                      AppAssets.category,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    padVertical(3),
                                                    Label(
                                                        txt:
                                                            '${controller.CourseDetail.value?.data?.course?.genre}',
                                                        type:
                                                            TextTypes.f_12_400)
                                                  ]))),
                                      Container(
                                          height: 75,
                                          width: 75,
                                          decoration: BoxDecoration(
                                            color: AppColors.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  height: 30,
                                                  width: 30,
                                                  AppAssets.language,
                                                  fit: BoxFit.contain,
                                                ),
                                                padVertical(3),
                                                Label(
                                                    txt:
                                                        '[${controller.CourseLessonDetail.value?.data?.courseLessons?.first?.lang ?? ""}]',
                                                    type: TextTypes.f_12_400)
                                              ])),
                                      GestureDetector(
                                          // onTap:
                                          //     controller.navigateToCertificate,
                                          child: Container(
                                              height: 75,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                color: AppColors.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      height: 30,
                                                      width: 30,
                                                      AppAssets.certificate,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    padVertical(3),
                                                    Label(
                                                        txt: AppLocalization.of(
                                                                context)
                                                            .translate(
                                                                'certificate'),
                                                        type:
                                                            TextTypes.f_12_400)
                                                  ]))),
                                    ],
                                  ),
                                  padVertical(20),
                                  ReadMoreText(
                                    controller.getBookTitle(
                                        name: controller.CourseDetail.value
                                            ?.data?.course?.description),
                                    numLines: 3,
                                    readMoreTextStyle: TextStyle(
                                      color: AppColors.resnd,
                                      // Match the forceColor from Label
                                      fontFamily: AppConst.fontFamily,
                                      // From Label's fontStyle
                                      fontWeight: FontWeight.w500,
                                      // From TextTypes.f_16_500
                                      fontSize: 16, // From TextTypes.f_16_500
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
                                      fontSize: 16, // From TextTypes.f_16_500
                                    ), // Content text style to match Label
                                  ),
                                  padVertical(20),
                                  Label(
                                    txt: AppLocalization.of(context)
                                        .translate('author'),
                                    type: TextTypes.f_15_500,
                                  ),
                                  padVertical(10),
                                  Column(
                                    children: List.generate(
                                        controller.CourseDetail.value?.data
                                                ?.course?.authorId?.length ??
                                            0, (index) {
                                      return GestureDetector(
                                          onTap: () => controller
                                              .navigateToAuthorDetail(controller
                                                      .CourseDetail
                                                      .value
                                                      ?.data
                                                      ?.course
                                                      ?.authorId?[index]
                                                      .sId ??
                                                  ""),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(children: [
                                                ClipOval(
                                                  child: Image.network(
                                                    "${AppConfig.imgBaseUrl}${controller.CourseDetail.value?.data?.course?.authorId?[index]?.image}",
                                                    width: 85,
                                                    height: 85,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                padHorizontal(15),
                                                Label(
                                                  txt:
                                                      "${controller.getBookTitle(name: controller.CourseDetail.value?.data?.course?.authorId?[index]?.name)}",
                                                  type: TextTypes.f_15_500,
                                                ),
                                              ]),
                                              const Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 18,
                                              )
                                            ],
                                          ));
                                    }),
                                  ),
                                  padVertical(10),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                          controller.CourseDetail.value?.data
                                                  ?.course?.genre?.length ??
                                              0, (index) {
                                        return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12.0,
                                                top: 10,
                                                bottom: 10),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: AppColors.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                                                    "${controller.CourseDetail.value?.data?.course?.genre?[index]}",
                                                type: TextTypes.f_15_400,
                                              ),
                                            ));
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
                                                  .translate('relatedcourses'),
                                              type: TextTypes.f_15_500),
                                          const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 18,
                                          )
                                        ],
                                      )),
                                  padVertical(10),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                          controller.CourseDetail.value?.data
                                                  ?.relatedCourses?.length ??
                                              0, (index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              print("hello>>>>>");
                                              controller.fetchBookStudy(
                                                  controller
                                                          .CourseDetail
                                                          .value
                                                          ?.data
                                                          ?.relatedCourses?[
                                                              index]
                                                          .sId ??
                                                      "");
                                              controller.fetchCourseLessons(
                                                  controller
                                                      .CourseDetail
                                                      .value
                                                      ?.data
                                                      ?.relatedCourses?[index]
                                                      .sId);
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 150,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        15),
                                                                topRight: Radius
                                                                    .circular(
                                                                        15)),
                                                        child: Image.network(
                                                          "${AppConfig.imgBaseUrl}${controller.CourseDetail.value?.data?.relatedCourses?[index]?.image ?? ""}",
                                                          width: 150,
                                                          height: 100,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      padVertical(5),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Label(
                                                                txt: controller.getBookTitle(
                                                                    name: controller
                                                                        .CourseDetail
                                                                        .value
                                                                        ?.data
                                                                        ?.relatedCourses?[
                                                                            index]
                                                                        .name),
                                                                type: TextTypes
                                                                    .f_10_500,
                                                                forceAlignment:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                              padVertical(5),
                                                              Row(
                                                                children: [
                                                                  const Icon(
                                                                    Icons.star,
                                                                    size: 16,
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                  ),
                                                                  Label(
                                                                    txt:
                                                                        "${controller.CourseDetail.value?.data?.relatedCourses?[index].averageRating}",
                                                                    type: TextTypes
                                                                        .f_11_500,
                                                                  ),
                                                                  padHorizontal(
                                                                      8),
                                                                  Container(
                                                                    height: 12,
                                                                    width: 1,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColors
                                                                          .buttongroupBorder,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                    ),
                                                                  ),
                                                                  padHorizontal(
                                                                      8),
                                                                  Label(
                                                                    txt:
                                                                        "${controller.CourseDetail.value?.data?.relatedCourses?[index].genre?.first ?? ""}",
                                                                    type: TextTypes
                                                                        .f_11_500,
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
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  padVertical(10),
                                ])
                          : controller.selectedIndex.value == 1
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Obx(() {
                                        final lessons = controller
                                                .CourseLessonDetail
                                                .value
                                                ?.data
                                                ?.courseLessons ??
                                            [];
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: lessons.length,
                                          itemBuilder: (context, index) {
                                            final course = lessons[index];
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 20),
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () => controller
                                                        .toggleListView(index),
                                                    child: Container(
                                                      width: double.infinity,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10,
                                                          horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.border,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft: const Radius
                                                              .circular(8),
                                                          topRight: const Radius
                                                              .circular(8),
                                                          bottomLeft:
                                                              Radius.circular(
                                                            controller.expandedStates[
                                                                        index] ??
                                                                    false
                                                                ? 0
                                                                : 8,
                                                          ),
                                                          bottomRight:
                                                              Radius.circular(
                                                            controller.expandedStates[
                                                                        index] ??
                                                                    false
                                                                ? 0
                                                                : 8,
                                                          ),
                                                        ),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black12,
                                                            blurRadius: 3,
                                                            offset:
                                                                Offset(0, 2),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Label(
                                                                  txt: course
                                                                          ?.name ??
                                                                      "",
                                                                  type: TextTypes
                                                                      .f_17_500),
                                                              Obx(() => Icon(
                                                                    (controller.expandedStates[index] ??
                                                                            false)
                                                                        ? Icons
                                                                            .arrow_drop_up_outlined
                                                                        : Icons
                                                                            .arrow_drop_down_outlined,
                                                                    size: 30,
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                  )),
                                                            ],
                                                          ),
                                                          Obx(() => controller
                                                                          .expandedStates[
                                                                      index] ??
                                                                  false
                                                              ? const Divider()
                                                              : const SizedBox
                                                                  .shrink()),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Obx(() =>
                                                      controller.expandedStates[
                                                                  index] ??
                                                              false
                                                          ? Container(
                                                              width: double
                                                                  .infinity,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: AppColors
                                                                    .border,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          8),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          8),
                                                                ),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black12,
                                                                    blurRadius:
                                                                        3,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            2),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Column(
                                                                children: List.generate(
                                                                    course.subLessons
                                                                            ?.length ??
                                                                        0,
                                                                    (subIndex) {
                                                                  final subLesson =
                                                                      course.subLessons?[
                                                                          subIndex];
                                                                  return Obx(() =>
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          print(
                                                                              "${controller.CourseLessonDetail.value?.data?.courseLessons?[index]?.subLessons?[subIndex]?.file}");
                                                                          if (controller.CourseLessonDetail.value?.data?.isPurchased ==
                                                                              true) {
                                                                            print(index);
                                                                            if (controller.CourseLessonDetail.value?.data?.courseLessons?[index].isOpen ==
                                                                                true) {
                                                                              Get.toNamed("/VideoPlayer", arguments: {
                                                                                "id": controller.Id,
                                                                                "index": index,
                                                                                "subindex": subIndex,
                                                                                "url": controller.CourseLessonDetail.value?.data?.courseLessons?[index]?.subLessons?[subIndex]?.file == null ? "no_video" : "${AppConfig.imgBaseUrl}${controller.CourseLessonDetail.value?.data?.courseLessons?[index]?.subLessons?[subIndex]?.file}"
                                                                              });
                                                                            }
                                                                          }
                                                                        },
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            padVertical(5),
                                                                            Row(
                                                                              children: [
                                                                                Obx(() => controller.CourseLessonDetail.value?.data?.courseLessons?[index]?.subLessons?[subIndex].isDone == true
                                                                                    ? Image.asset(
                                                                                        AppAssets.iconCourseTick,
                                                                                        height: 20,
                                                                                        width: 20,
                                                                                      )
                                                                                    : Icon(
                                                                                        controller.CourseLessonDetail.value?.data?.isPurchased == false || controller.CourseLessonDetail.value?.data?.courseLessons?[index].isOpen == false ? Icons.lock_outline : Icons.play_circle_outline,
                                                                                        size: 21,
                                                                                        color: controller.CourseLessonDetail.value?.data?.isPurchased == false || controller.CourseLessonDetail.value?.data?.courseLessons?[index].isOpen == false ? AppColors.border2 : Colors.deepOrange,
                                                                                      )),
                                                                                padHorizontal(6),
                                                                                Label(
                                                                                  txt: subLesson?.name ?? "",
                                                                                  type: TextTypes.f_15_400,
                                                                                  forceColor: controller.CourseLessonDetail.value?.data?.courseLessons?[index].isOpen == true ? Colors.black : Colors.grey,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            padVertical(10),
                                                                          ],
                                                                        ),
                                                                      ));
                                                                }),
                                                              ),
                                                            )
                                                          : const SizedBox
                                                              .shrink()),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      })
                                    ])
                              : controller.ReviewResponse.value?.data?.ratings
                                          ?.length ==
                                      0
                                  ? Center(
                                      child: Container(
                                        height: Get.height * 0.2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            controller
                                                        .CourseLessonDetail
                                                        .value
                                                        ?.data
                                                        ?.certificateAvailable ==
                                                    true
                                                ? GestureDetector(
                                                    onTap: () => controller
                                                        .showReviewSheet(
                                                            context),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: AppColors
                                                              .primaryColor,
                                                          width: 0.6,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Label(
                                                          txt: AppLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'leavereview'),
                                                          forceColor: AppColors
                                                              .primaryColor,
                                                          type: TextTypes
                                                              .f_17_400,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(),
                                            Image.asset(
                                              AppAssets.iconNoReviews,
                                              height: 50,
                                              width: 50,
                                            ),
                                            Label(
                                                txt:
                                                    "${AppLocalization.of(context).translate('NoReviewsHeading')}",
                                                type: TextTypes.f_15_500),
                                            Label(
                                                txt:
                                                    "${AppLocalization.of(context).translate('NoReviewsSubHeading')}",
                                                type: TextTypes.f_12_400)
                                          ],
                                        ),
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        controller
                                                    .CourseLessonDetail
                                                    .value
                                                    ?.data
                                                    ?.certificateAvailable ==
                                                true
                                            ? GestureDetector(
                                                onTap: () => controller
                                                    .showReviewSheet(context),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                      color: AppColors
                                                          .primaryColor,
                                                      width: 0.6,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Label(
                                                      txt: AppLocalization.of(
                                                              context)
                                                          .translate(
                                                              'leavereview'),
                                                      forceColor: AppColors
                                                          .primaryColor,
                                                      type: TextTypes.f_17_400,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                        padVertical(20),
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: AppColors.background,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children:
                                                    List.generate(5, (index) {
                                                  final rating = 5 - index;
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 4.0),
                                                    child: Row(
                                                      children: [
                                                        Label(
                                                          txt: '$rating',
                                                          type: TextTypes
                                                              .f_15_400,
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        const Icon(Icons.star,
                                                            color: Colors.amber,
                                                            size: 16),
                                                        const SizedBox(
                                                            width: 8),
                                                        SizedBox(
                                                          width: 100,
                                                          child:
                                                              LinearProgressIndicator(
                                                            value: (5 - index) *
                                                                0.2,
                                                            color: AppColors
                                                                .starprogress,
                                                            backgroundColor:
                                                                AppColors
                                                                    .background,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Label(
                                                      txt:
                                                          '${controller.ReviewResponse.value?.data?.averageRating?.toStringAsFixed(1)}',
                                                      type: TextTypes.f_34_700),
                                                  Obx(() => Row(
                                                        children: List.generate(
                                                          5,
                                                          (index) => Icon(
                                                            index <
                                                                    int.parse(controller
                                                                            .ReviewResponse
                                                                            .value
                                                                            ?.data
                                                                            ?.averageRating
                                                                            ?.toInt()
                                                                            ?.toString() ??
                                                                        "0")
                                                                ? Icons.star
                                                                : Icons
                                                                    .star_border,
                                                            color: Colors.amber,
                                                            size: 16,
                                                          ),
                                                        ),
                                                      )),
                                                  const SizedBox(height: 4),
                                                  Label(
                                                    txt:
                                                        '${controller.ReviewResponse.value?.data?.ratings?.length} ${AppLocalization.of(context).translate('reviews')}',
                                                    type: TextTypes.f_15_400,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: List.generate(
                                              controller.ReviewResponse.value
                                                      ?.data?.ratings?.length ??
                                                  0, (index) {
                                            return Padding(
                                                padding: EdgeInsets.only(
                                                    right: 12.0, top: 10),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(children: [
                                                            ClipOval(
                                                              child: controller
                                                                              .ReviewResponse
                                                                              .value
                                                                              ?.data
                                                                              ?.ratings?[
                                                                                  index]
                                                                              .userId
                                                                              ?.profilePic !=
                                                                          null ||
                                                                      controller
                                                                              .ReviewResponse
                                                                              .value
                                                                              ?.data
                                                                              ?.ratings?[
                                                                                  index]
                                                                              .userId
                                                                              ?.profilePic
                                                                              ?.isNotEmpty ==
                                                                          true
                                                                  ? Image.network(
                                                                      height:
                                                                          30,
                                                                      width: 30,
                                                                      controller.ReviewResponse.value?.data?.ratings?[index].userId?.profilePic!.startsWith('https') ==
                                                                              true
                                                                          ? "${controller.ReviewResponse.value?.data?.ratings?[index].userId?.profilePic}"
                                                                          : "${AppConfig.imgBaseUrl}${controller.ReviewResponse.value?.data?.ratings?[index].userId?.profilePic}")
                                                                  : Container(
                                                                      height:
                                                                          30,
                                                                      width: 30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(30),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child: Icon(
                                                                            Icons.person),
                                                                      ),
                                                                    ),
                                                            ),
                                                            padHorizontal(10),
                                                            Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Label(
                                                                    txt:
                                                                        "${controller.ReviewResponse.value?.data?.ratings?[index].userId?.fullName == null ? controller.getBookTitle(name: controller.ReviewResponse.value?.data?.ratings?[index].userId?.firstName) : controller.getBookTitle(name: controller.ReviewResponse.value?.data?.ratings?[index].userId?.fullName)}",
                                                                    type: TextTypes
                                                                        .f_16_500,
                                                                  ),
                                                                  Row(
                                                                    children: List
                                                                        .generate(
                                                                      5,
                                                                      (Index) =>
                                                                          Icon(
                                                                        Index < int.parse(controller.ReviewResponse.value?.data?.ratings?[index].rating?.toString() ?? "0")
                                                                            ? Icons.star
                                                                            : Icons.star_border,
                                                                        color: Colors
                                                                            .amber,
                                                                        size:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ]),
                                                          // Image.asset(
                                                          //   AppAssets.dots2,
                                                          //   width: 4,
                                                          //   height: 16,
                                                          //   fit: BoxFit.contain,
                                                          // ),
                                                        ],
                                                      ),
                                                      padVertical(10),
                                                      Label(
                                                        txt:
                                                            "${controller.ReviewResponse.value?.data?.ratings?[index]?.comment ?? ""}",
                                                        type:
                                                            TextTypes.f_13_400,
                                                      ),
                                                      padVertical(10),
                                                      const Divider()
                                                    ]));
                                          }),
                                        ),
                                      ],
                                    )),
                    ],
                  ))
                ],
              )),
      ),
      bottomNavigationBar: Obx(() => controller
                  .CourseLessonDetail.value?.data?.isPurchased ==
              false
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Label(
                        txt: AppLocalization.of(context).translate('price'),
                        type: TextTypes.f_15_400,
                        forceColor: AppColors.resnd,
                      ),
                      Label(
                        txt:
                            "${controller.CourseDetail.value?.data?.course?.price} ₸",
                        type: TextTypes.f_20_500,
                        textDecoration: controller.CourseDetail.value?.data
                                    ?.course?.isDiscounted ==
                                true
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                      controller.CourseDetail.value?.data?.course
                                  ?.isDiscounted ==
                              true
                          ? Label(
                              txt:
                                  "${(((controller.CourseDetail.value?.data?.course?.price ?? 0) - ((controller.CourseDetail.value?.data?.course?.price ?? 0) * ((controller.CourseDetail.value?.data?.course?.discountPercentage ?? 0)) / 100)).toStringAsFixed(0))} ₸",
                              type: TextTypes.f_20_500,
                              forceColor: AppColors.red,
                              textDecoration: TextDecoration.none,
                            )
                          : SizedBox(),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: controller.navigateToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: controller.CourseDetail.value?.data?.isAddedToCart ==
                            true
                        ? Label(
                            txt: AppLocalization.of(context)
                                .translate('GoToCart'),
                            type: TextTypes.f_17_500,
                            forceColor: AppColors.whiteColor,
                          )
                        : Label(
                            txt:
                                AppLocalization.of(context).translate('buynow'),
                            type: TextTypes.f_17_500,
                            forceColor: AppColors.whiteColor,
                          ),
                  ),
                ],
              ),
            )
          : controller.isLoading == false
              ? controller.CourseLessonDetail.value?.data
                          ?.certificateAvailable ==
                      true
                  ? controller.CourseLessonDetail.value?.data
                              ?.courseCompleted ==
                          true
                      ? Container(
                          height: 150,
                          width: Get.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(
                                width: Get.width,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    controller.navigateToCertificate();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.whiteColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    side: const BorderSide(
                                      color: AppColors.primaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Label(
                                        txt: AppLocalization.of(context)
                                            .translate('certificate'),
                                        type: TextTypes.f_17_500,
                                        forceColor: AppColors.primaryColor,
                                      ),
                                      const SizedBox(
                                          width:
                                              8), // Adds spacing between text and icon
                                      Image.asset(
                                        AppAssets.certificatemark,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: Get.width,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Label(
                                        txt: AppLocalization.of(context)
                                            .translate(
                                                'CompleteCourseSuceessfully'),
                                        type: TextTypes.f_17_500,
                                        forceColor: AppColors.whiteColor,
                                      ),
                                      const SizedBox(
                                          width:
                                              8), // Adds spacing between text and icon
                                      Image.asset(
                                        AppAssets.success,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(
                          width: Get.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          color: Colors.white,
                          child: ElevatedButton(
                            onPressed: () {
                              controller
                                  .handelGernateCertificate(controller.Id);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Label(
                              txt: AppLocalization.of(context)
                                  .translate('CompleteCourse'),
                              type: TextTypes.f_17_500,
                              forceColor: AppColors.whiteColor,
                            ),
                          ),
                        )
                  : Container(
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      color: Colors.white,
                      child: ElevatedButton(
                        onPressed: () async {
                          Get.toNamed("/VideoPlayer", arguments: {
                            "id": controller.Id,
                            "index": 0,
                            "subindex": 0,
                            "url": controller
                                        .CourseLessonDetail
                                        .value
                                        ?.data
                                        ?.courseLessons?[0]
                                        ?.subLessons?[0]
                                        ?.file ==
                                    null
                                ? "no_video"
                                : "${AppConfig.imgBaseUrl}${controller.CourseLessonDetail.value?.data?.courseLessons?[0]?.subLessons?[0]?.file}"
                          });
                          controller.fetchCourseLessons(controller.Id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Label(
                          txt: AppLocalization.of(context)
                              .translate('StartCourse'),
                          type: TextTypes.f_17_500,
                          forceColor: AppColors.whiteColor,
                        ),
                      ),
                    )
              : SizedBox()),
    );
  }
}
