import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../app_settings/components/loader.dart';
import '../../../../../app_settings/constants/app_config.dart';
import '../../../../../app_settings/constants/app_dim.dart';
import '../../../../../app_settings/constants/helpers.dart';
import '../../home_module/models/homeProductModel.dart';
import '../controllers/bookstudy_home_controller.dart';
import '../models/BookStudyModel.dart';

class PgBookstudy extends GetView<PgBookstudyController> {
  const PgBookstudy({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Set status bar color
        statusBarIconBrightness:
            Brightness.dark, // Ensure icons are visible on white
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(() => controller.isLoading.value == true
            ? Container(
                height: Get.height,
                width: Get.width,
                child: Center(child: LoadingScreen()))
            : SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          AppAssets.bookstudy,
                          fit: BoxFit.cover,
                          width: screenWidth,
                          // 30% of screen height
                        ),
                        Positioned(
                          top: MediaQuery.of(context).padding.top +
                              screenHeight * 0.02,
                          left: screenWidth * 0.03,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: screenWidth * 0.06, // Scaled icon size
                            ),
                            onPressed: controller.goBack,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Label(
                                txt: AppLocalization.of(context)
                                    .translate('boundlessbooks'),
                                type: TextTypes.f_34_700,
                                // Scaled font size
                              ).marginOnly(bottom: 10),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04),
                                height:
                                    screenHeight * 0.06, // 6% of screen height
                                decoration: BoxDecoration(
                                  color: AppColors.border,
                                  borderRadius: BorderRadius.circular(
                                      screenWidth * 0.025),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      height: screenWidth * 0.05,
                                      width: screenWidth * 0.05,
                                      AppAssets.search,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(width: screenWidth * 0.025),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: AppLocalization.of(context)
                                              .translate('search'),
                                          hintStyle: TextStyle(
                                            color: AppColors.inputBorder,
                                            fontFamily: AppConst.fontFamily,
                                            fontSize: screenWidth * 0.04,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: AppColors.blackColor,
                                          fontFamily: AppConst.fontFamily,
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              GestureDetector(
                                onTap: controller.navigateToCategory,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Label(
                                      txt: AppLocalization.of(context)
                                          .translate('Categories'),
                                      type: TextTypes.f_20_500,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: screenWidth * 0.045,
                                    ),
                                  ],
                                ),
                              ),
                              Obx(() => _buildButtonGrid(context)
                                  .marginSymmetric(vertical: 20)),
                              GestureDetector(
                                onTap: controller.navigateToTeachers,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Label(
                                      txt: AppLocalization.of(context)
                                          .translate('teachers'),
                                      type: TextTypes.f_20_500,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: screenWidth * 0.045,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      controller.bookStudy.value?.data?.teachers
                                              ?.length ??
                                          0, (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        final teacherId = controller.bookStudy
                                            .value?.data?.teachers?[index].sId;
                                        if (teacherId != null) {
                                          print(
                                              "Navigating to teacher profile: $teacherId");
                                          Get.toNamed("/teacherDetail",
                                              arguments: {
                                                "teacherId": teacherId
                                              });
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: screenWidth * 0.03),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      screenWidth * 0.14)),
                                              child: Center(
                                                child: ClipOval(
                                                  child: controller
                                                              .bookStudy
                                                              .value
                                                              ?.data
                                                              ?.teachers?[index]
                                                              .image !=
                                                          null
                                                      ? Image.network(
                                                          height: 100,
                                                          width: 100,
                                                          "${AppConfig.imgBaseUrl}${controller.bookStudy.value?.data?.teachers?[index].image}",
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) =>
                                                              Image.asset(
                                                                  height: 100,
                                                                  width: 100,
                                                                  AppAssets
                                                                      .book,
                                                                  fit: BoxFit
                                                                      .contain),
                                                        )
                                                      : Image.asset(
                                                          height: 100,
                                                          width: 100,
                                                          AppAssets.book,
                                                          fit: BoxFit.contain),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height: screenHeight * 0.01),
                                            Label(
                                              txt: controller.getBookTitle(
                                                  name: controller
                                                      .bookStudy
                                                      .value
                                                      ?.data
                                                      ?.teachers?[index]
                                                      .name),
                                              type: TextTypes.f_13_500,
                                              forceAlignment: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.025),
                              (controller.bookStudy.value?.data?.popularCourses
                                              ?.length ??
                                          0) >
                                      0
                                  ? Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Label(
                                              txt: AppLocalization.of(context)
                                                  .translate('popularcourses'),
                                              type: TextTypes.f_20_500,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: screenWidth * 0.045,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: screenHeight * 0.02),
                                        _buildCoursesRow(controller.bookStudy
                                                .value?.data?.popularCourses ??
                                            []),
                                        SizedBox(height: screenHeight * 0.025),
                                      ],
                                    )
                                  : SizedBox(),
                              controller.bookStudy.value?.data?.readBooks
                                          ?.length !=
                                      0
                                  ? GestureDetector(
                                      onTap: controller.navigateToCourses,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Label(
                                              txt:
                                                  '${AppLocalization.of(context).translate('continuereading')} 💌',
                                              type: TextTypes.f_20_500),
                                          const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 18,
                                          )
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(height: 30),
                              Obx(() => controller.bookStudy.value?.data
                                          ?.readBooks?.length !=
                                      0
                                  ? SizedBox(
                                      height: 160,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: controller.bookStudy.value
                                                ?.data?.readBooks?.length ??
                                            0, // Adjust based on your data
                                        itemBuilder: (context, index) {
                                          final book = controller.bookStudy
                                              .value?.data?.readBooks?[index];
                                          return Container(
                                            width: ScreenUtils.screenWidth(
                                                    context) *
                                                0.9,
                                            // Set a fixed width (e.g., 80% of screen width)
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            // Space between items
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 15),
                                            decoration: BoxDecoration(
                                              color: AppColors.border,
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  child: book?.bookId?.image !=
                                                          null
                                                      ? Image.network(
                                                          width: 113,
                                                          height: 144,
                                                          "${AppConfig.imgBaseUrl}${book?.bookId?.image}",
                                                          fit: BoxFit.fill,
                                                          errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) =>
                                                              Image.asset(
                                                            AppAssets.book,
                                                            width: 113,
                                                            height: 144,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        )
                                                      : Image.asset(
                                                          width: 113,
                                                          height: 144,
                                                          AppAssets.book,
                                                          fit: BoxFit.fill,
                                                        ),
                                                ),

                                                const SizedBox(
                                                    width:
                                                        10), // Replaced padHorizontal(10)
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Label(
                                                        txt: controller
                                                            .getBookTitle(
                                                                name: book
                                                                    ?.bookId
                                                                    ?.name),
                                                        type:
                                                            TextTypes.f_15_500,
                                                      ),
                                                      Label(
                                                        txt: controller
                                                            .getBookTitle(
                                                                name: book
                                                                    ?.bookId
                                                                    ?.authorId
                                                                    ?.first
                                                                    ?.name),
                                                        type:
                                                            TextTypes.f_15_400,
                                                        forceColor:
                                                            AppColors.resnd,
                                                      ),
                                                      Label(
                                                        txt: book?.bookId
                                                                ?.type ??
                                                            "",
                                                        type:
                                                            TextTypes.f_13_400,
                                                        forceColor:
                                                            AppColors.resnd,
                                                      ),
                                                      const SizedBox(
                                                          height:
                                                              5), // Replaced padVertical(5)
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.3,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              child:
                                                                  LinearProgressIndicator(
                                                                value:
                                                                    (book?.progress ??
                                                                            0) /
                                                                        100,
                                                                backgroundColor:
                                                                    AppColors
                                                                        .inputBorder,
                                                                valueColor: AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    AppColors
                                                                        .primaryColor),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Label(
                                                            txt:
                                                                "${book?.progress?.toString()}%",
                                                            // Replace with dynamic value like "${(book.progress * 100).toInt()}%"
                                                            type: TextTypes
                                                                .f_12_400,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height:
                                                              2), // Replaced padVertical(2)
                                                      SizedBox(
                                                        height: 38,
                                                        child: ElevatedButton(
                                                          onPressed: () => {
                                                            if (book?.bookId
                                                                    ?.type ==
                                                                "course")
                                                              {
                                                                Get.toNamed(
                                                                    '/Course-detail',
                                                                    arguments: {
                                                                      "id": book
                                                                          ?.bookId
                                                                          ?.sId,
                                                                    })
                                                              }
                                                            else
                                                              {
                                                                Get.toNamed(
                                                                    '/book-detail',
                                                                    arguments: {
                                                                      "id": book
                                                                          ?.bookId
                                                                          ?.sId,
                                                                    })
                                                              }
                                                          }, // Pass index if needed
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            elevation: 0.0,
                                                            backgroundColor:
                                                                AppColors
                                                                    .primaryColor,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                          child: Label(
                                                            txt: AppLocalization
                                                                    .of(context)
                                                                .translate(
                                                                    'continue'),
                                                            type: TextTypes
                                                                .f_13_400,
                                                            forceColor:
                                                                AppColors
                                                                    .whiteColor,
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
                                    )
                                  : SizedBox()),
                              SizedBox(height: 30),
                              (controller.bookStudy.value?.data?.newBooks
                                              ?.length ??
                                          0) >
                                      0
                                  ? Column(
                                      children: [
                                        GestureDetector(
                                          onTap: controller.navigateToCourses,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Label(
                                                txt: AppLocalization.of(context)
                                                    .translate('newcourses'),
                                                type: TextTypes.f_20_500,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: screenWidth * 0.045,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.02),
                                        _buildCoursesRow(controller.bookStudy
                                                .value?.data?.newBooks ??
                                            []),
                                        SizedBox(height: screenHeight * 0.025),
                                      ],
                                    )
                                  : SizedBox(),
                            ],
                          ).marginSymmetric(horizontal: 20, vertical: 20),
                        ).marginOnly(top: screenHeight * 0.22),
                      ],
                    ),
                  ],
                ),
              )),
      ),
    );
  }

  Widget _buildButtonGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Wrap(
      spacing: screenWidth * 0.015, // Horizontal spacing between items
      runSpacing: screenWidth * 0.025, // Vertical spacing between rows
      children: controller.bookStudy.value?.data?.categories
              ?.asMap()
              .entries
              .map((entry) {
            final index = entry.key;
            final item = entry.value;
            return IntrinsicWidth(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed("/categoryById", arguments: {
                    "teacherId":
                        controller.bookStudy.value?.data?.categories?[index].sId
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.02,
                    horizontal: screenWidth * 0.04,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min, // Ensure Row takes minimum width
                    children: [
                      ClipRRect(
                        child: item.image != null
                            ? Image.network(
                                height: 20,
                                width: 20,
                                "${AppConfig.imgBaseUrl}${controller.bookStudy.value?.data?.categories?[index].image}",
                                errorBuilder: (context, error, stackTrace) =>
                                    Label(
                                  txt: "📋",
                                  type: TextTypes.f_18_400,
                                ),
                              )
                            : Label(
                                txt: "📋",
                                type: TextTypes.f_18_400,
                              ),
                      ),
                      Flexible(
                        child: Label(
                          maxLines: 3,
                          txt: controller.getBookTitle(name: item.name) ??
                              'Unknown',
                          type: TextTypes.f_18_400,
                        ).marginSymmetric(horizontal: 8),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList() ??
          [],
    );
  }

  Widget _buildCoursesRow(List<NewBooks> courses) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                if (controller.bookStudy.value?.data?.newBooks?[index]
                        ?.productsId?.type ==
                    "course") {
                  Get.toNamed('/Course-detail', arguments: {
                    "id": controller.bookStudy.value?.data?.newBooks?[index]
                        ?.productsId?.sId,
                  });
                } else {
                  Get.toNamed('/book-detail', arguments: {
                    "id": controller.bookStudy.value?.data?.newBooks?[index]
                        ?.productsId?.sId,
                  });
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 144,
                    width: 246,
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
                        child: course.productsId?.image != null
                            ? Image.network(
                                "${AppConfig.imgBaseUrl}${course.productsId?.image}",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(AppAssets.book,
                                        fit: BoxFit.contain),
                              )
                            : Image.asset(AppAssets.book, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  padVertical(5),
                  Label(
                    txt: controller.getBookTitle(
                        name: course.productsId?.name ?? 'Unknown'),
                    type: TextTypes.f_13_500,
                  ),
                  SizedBox(
                    width: 240,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: AppColors.primaryColor,
                            ),
                            Label(
                              txt: (course.productsId?.averageRating ?? 0.0)
                                  .toString(),
                              type: TextTypes.f_11_500,
                            ),
                            padHorizontal(8),
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
                                txt: controller.getBookTitle(
                                    name: course.productsId?.authorId
                                                ?.isNotEmpty ==
                                            true
                                        ? course.productsId?.authorId![0].name
                                        : 'Unknown'),
                                type: TextTypes.f_13_400,
                                forceColor: AppColors.resnd,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            if (course.productsId?.isDiscounted == true)
                              Text(
                                course.productsId?.price?.toString() ?? '0',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: AppConst.fontFamily,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 2,
                                  decorationColor: AppColors.blackColor,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            SizedBox(width: 10),
                            Text(
                              course.productsId?.isDiscounted == true
                                  ? (course.productsId?.price != null
                                          ? course.productsId?.price! ??
                                              0 *
                                                  (1 -
                                                      (course.productsId
                                                                  ?.discountPercentage ??
                                                              0) /
                                                          100)
                                          : 0)
                                      .toStringAsFixed(2)
                                  : (course.productsId?.price ?? 0)
                                      .toStringAsFixed(2),
                              style: TextStyle(
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
}
