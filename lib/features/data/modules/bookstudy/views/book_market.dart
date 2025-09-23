import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';

import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../app_settings/components/loader.dart';
import '../../../../../app_settings/constants/app_config.dart';
import '../../home_module/controller/searchcontroller.dart';
import '../../home_module/models/CollectionDataModel.dart';
import '../controllers/book_market_controller.dart';

class PgBookmarket extends GetView<PgBookmarketController> {
  const PgBookmarket({super.key});

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
                      Image.asset(
                        AppAssets.bookmarkett,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 15,
                        left: 10,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.black),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 4.1,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Label(
                          txt: AppLocalization.of(context)
                              .translate('boundlessbooks'),
                          type: TextTypes.f_34_700,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                height: 20,
                                width: 20,
                                AppAssets.search,
                                fit: BoxFit.contain,
                              ),
                              padHorizontal(10),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: AppLocalization.of(context)
                                        .translate('search'),
                                    hintStyle: const TextStyle(
                                      color: AppColors.inputBorder,
                                      fontFamily: AppConst.fontFamily,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: AppColors.blackColor,
                                    fontFamily: AppConst.fontFamily,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  keyboardType: TextInputType.text,
                                  onChanged: controller.onSearchChanged,
                                ),
                              ),
                            ],
                          ),
                        ),
                        padVertical(15),
                        GestureDetector(
                          onTap: controller.navigateToCategory,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        padVertical(15),
                        Obx(() => _buildButtonGrid(context)
                            .marginSymmetric(vertical: 20)),
                        padVertical(20),

                        // Add the collections tab
                        _buildCollectionsTab(context),
                        controller.bookMarket.value?.data?.bestSellers
                                    ?.length !=
                                0
                            ? padVertical(20)
                            : SizedBox(),

                        controller.bookMarket.value?.data?.bestSellers
                                    ?.length !=
                                0
                            ? GestureDetector(
                                onTap: () {
                                  Get.toNamed("/allcollections", arguments: {
                                    "title":
                                        '${AppLocalization.of(context).translate('bestsellers')}🔥',
                                    "id": ""
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Label(
                                        txt:
                                            '${AppLocalization.of(context).translate('bestsellers')}🔥',
                                        type: TextTypes.f_20_500),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 18,
                                    )
                                  ],
                                ))
                            : SizedBox(),
                        controller.bookMarket.value?.data?.bestSellers
                                    ?.length !=
                                0
                            ? padVertical(20)
                            : SizedBox(),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                controller.bookMarket.value?.data?.bestSellers
                                        ?.length ??
                                    0, (index) {
                              return GestureDetector(
                                onTap: () {
                                  if (controller.bookMarket.value?.data
                                          ?.bestSellers?[index]?.book?.type ==
                                      "course") {
                                    Get.toNamed('/Course-detail', arguments: {
                                      "id": controller.bookMarket.value?.data
                                          ?.bestSellers?[index]?.book?.sId,
                                    });
                                  } else {
                                    Get.toNamed('/book-detail', arguments: {
                                      "id": controller.bookMarket.value?.data
                                          ?.bestSellers?[index]?.book?.sId,
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 144,
                                          width: 144,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: controller
                                                        .bookMarket
                                                        .value
                                                        ?.data
                                                        ?.bestSellers?[index]
                                                        ?.book
                                                        ?.image !=
                                                    null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.network(
                                                      "${AppConfig.imgBaseUrl}${controller.bookMarket.value?.data?.bestSellers?[index]?.book?.image}",
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Image.asset(
                                                        AppAssets.book,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  )
                                                : Image.asset(
                                                    AppAssets.book,
                                                    fit: BoxFit.contain,
                                                  ),
                                          ),
                                        ),
                                        padVertical(5),
                                        Label(
                                            txt: controller.getBookTitle(
                                                name: controller
                                                    .bookMarket
                                                    .value
                                                    ?.data
                                                    ?.bestSellers?[index]
                                                    ?.book
                                                    ?.name),
                                            type: TextTypes.f_13_500),
                                        Label(
                                          txt: controller.getBookTitle(
                                              name: controller
                                                  .bookMarket
                                                  .value
                                                  ?.data
                                                  ?.bestSellers?[index]
                                                  ?.book
                                                  ?.authors
                                                  ?.name),
                                          type: TextTypes.f_13_400,
                                          forceColor: AppColors.resnd,
                                        ),
                                        Label(
                                          txt: controller
                                                  .bookMarket
                                                  .value
                                                  ?.data
                                                  ?.bestSellers?[index]
                                                  ?.book
                                                  ?.genre
                                                  ?.first ??
                                              "",
                                          type: TextTypes.f_12_400,
                                          forceColor: AppColors.resnd,
                                        )
                                      ]),
                                ),
                              );
                            }),
                          ),
                        ),
                        controller.bookMarket.value?.data?.bestSellers
                                    ?.length !=
                                0
                            ? padVertical(20)
                            : SizedBox(),

                        controller.bookMarket.value?.data?.readProgress
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
                        padVertical(10),
                        controller.bookMarket.value?.data?.readProgress
                                    ?.length !=
                                0
                            ? SizedBox(
                                height: 160,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.bookMarket.value?.data
                                          ?.readProgress?.length ??
                                      0, // Adjust based on your data
                                  itemBuilder: (context, index) {
                                    final book = controller.bookMarket.value
                                        ?.data?.readProgress?[index];
                                    return Container(
                                      width: ScreenUtils.screenWidth(context) *
                                          0.9,
                                      // Set a fixed width (e.g., 80% of screen width)
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      // Space between items
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: AppColors.border,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            child: book?.bookId?.image != null
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Label(
                                                  txt: controller.getBookTitle(
                                                      name: book?.bookId?.name),
                                                  type: TextTypes.f_15_500,
                                                ),
                                                Label(
                                                  txt: controller.getBookTitle(
                                                      name: book
                                                          ?.bookId
                                                          ?.authorId
                                                          ?.first
                                                          ?.name),
                                                  type: TextTypes.f_15_400,
                                                  forceColor: AppColors.resnd,
                                                ),
                                                Label(
                                                  txt: book?.bookId?.type ?? "",
                                                  type: TextTypes.f_13_400,
                                                  forceColor: AppColors.resnd,
                                                ),
                                                const SizedBox(
                                                    height:
                                                        5), // Replaced padVertical(5)
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child:
                                                            LinearProgressIndicator(
                                                          value:
                                                              (book?.progress ??
                                                                      0) /
                                                                  100,
                                                          backgroundColor:
                                                              AppColors
                                                                  .inputBorder,
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  AppColors
                                                                      .primaryColor),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Label(
                                                      txt:
                                                          "${book?.progress?.toString()}%",
                                                      // Replace with dynamic value like "${(book.progress * 100).toInt()}%"
                                                      type: TextTypes.f_12_400,
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
                                                      if (book?.bookId?.type ==
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
                                                      backgroundColor: AppColors
                                                          .primaryColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    child: Label(
                                                      txt: AppLocalization.of(
                                                              context)
                                                          .translate(
                                                              'continue'),
                                                      type: TextTypes.f_13_400,
                                                      forceColor:
                                                          AppColors.whiteColor,
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
                            : SizedBox(),
                        padVertical(30),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(2, (index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed("/Collection_Summary",
                                      arguments: {
                                        "title": index == 0
                                            ? '${AppLocalization.of(context).translate('strAllCollections')}'
                                            : '${AppLocalization.of(context).translate('strSummary')}'
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Stack(children: [
                                    index == 1
                                        ? Container(
                                            width: ScreenUtils.screenWidth(
                                                    context) /
                                                1.4,
                                            height: 80,
                                            decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                            child: Image.asset(
                                              AppAssets.MarketSlider,
                                              width: ScreenUtils.screenWidth(
                                                      context) /
                                                  1.4,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            )),
                                    Label(
                                      txt: index == 0
                                          ? '${AppLocalization.of(context).translate('strAllCollections')}'
                                          : '${AppLocalization.of(context).translate('strSummary')}',
                                      type: TextTypes.f_18_700,
                                      forceColor: AppColors.whiteColor,
                                      forceAlignment: TextAlign.center,
                                    ).marginSymmetric(
                                        horizontal: 30, vertical: 20)
                                  ]),
                                ),
                              );
                            }),
                          ),
                        ),
                        padVertical(25),
                        GestureDetector(
                            onTap: () {
                              Get.toNamed("/allcollections", arguments: {
                                "title":
                                    '${AppLocalization.of(context).translate('Audiobooks')}🎧',
                                "id": ""
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Label(
                                    txt:
                                        '${AppLocalization.of(context).translate('Audiobooks')}🎧',
                                    type: TextTypes.f_20_500),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                )
                              ],
                            )),
                        padVertical(15),
                        Obx(() => Column(
                              children: List.generate(
                                  controller.bookMarket?.value?.data?.audiobooks
                                          ?.length ??
                                      0, (index) {
                                final publisher = controller.bookMarket?.value
                                    ?.data?.audiobooks?[index];
                                return GestureDetector(
                                    onTap: () =>
                                        {controller.navigateToAudioBook(index)},
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 12.0, top: 10),
                                      child: Row(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  child: publisher?.file != null
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: Image.network(
                                                            "${AppConfig.imgBaseUrl}${publisher?.productId?.image}",
                                                            fit: BoxFit.cover,
                                                            errorBuilder: (context,
                                                                    error,
                                                                    stackTrace) =>
                                                                Image.asset(
                                                                    AppAssets
                                                                        .book,
                                                                    fit: BoxFit
                                                                        .contain),
                                                          ),
                                                        )
                                                      : Image.asset(
                                                          AppAssets.book,
                                                          fit: BoxFit.contain),
                                                ),
                                              ),
                                              const Positioned(
                                                top: 40,
                                                left: 35,
                                                child: Icon(
                                                  Icons.play_circle_filled,
                                                  size: 28,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          padHorizontal(10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              padVertical(5),
                                              Label(
                                                  txt: controller.getBookTitle(
                                                          name: publisher
                                                              ?.productId
                                                              ?.name) ??
                                                      'Unknown',
                                                  type: TextTypes.f_13_500),
                                              Label(
                                                txt: controller.getBookTitle(
                                                        name: publisher
                                                            ?.productId
                                                            ?.authorId
                                                            ?.first
                                                            .name) ??
                                                    'Unknown',
                                                type: TextTypes.f_12_400,
                                                forceColor: AppColors.resnd,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                              }),
                            )),
                        padVertical(20),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed("/allcollections", arguments: {
                              "title":
                                  '${AppLocalization.of(context).translate('newbooks')}💌',
                              "id": ""
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Label(
                                  txt:
                                      '${AppLocalization.of(context).translate('newbooks')}💌',
                                  type: TextTypes.f_20_500),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                        padVertical(20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Obx(() => Row(
                                children: List.generate(
                                    controller.bookMarket.value?.data?.newBooks
                                            ?.length ??
                                        0, (index) {
                                  final publisher = controller
                                      .bookMarket.value?.data?.newBooks?[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (controller.bookMarket.value?.data
                                                ?.newBooks?[index]?.type ==
                                            "course") {
                                          Get.toNamed('/Course-detail',
                                              arguments: {
                                                "id": controller
                                                    .bookMarket
                                                    .value
                                                    ?.data
                                                    ?.newBooks?[index]
                                                    ?.sId,
                                              });
                                        } else {
                                          Get.toNamed('/book-detail',
                                              arguments: {
                                                "id": controller
                                                    .bookMarket
                                                    .value
                                                    ?.data
                                                    ?.newBooks?[index]
                                                    ?.sId,
                                              });
                                        }
                                      },
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 144,
                                              width: 144,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: publisher?.image != null
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.network(
                                                          "${AppConfig.imgBaseUrl}${publisher?.image}",
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) =>
                                                              Image.asset(
                                                                  AppAssets
                                                                      .book,
                                                                  fit: BoxFit
                                                                      .contain),
                                                        ),
                                                      )
                                                    : Image.asset(
                                                        AppAssets.book,
                                                        fit: BoxFit.contain),
                                              ),
                                            ),
                                            padVertical(5),
                                            Label(
                                                txt: controller.getBookTitle(
                                                        name:
                                                            publisher?.name) ??
                                                    'Unknown',
                                                type: TextTypes.f_13_500),
                                            Label(
                                                txt: controller.getBookTitle(
                                                        name: publisher
                                                                ?.authorId
                                                                ?.first
                                                                .name ??
                                                            "") ??
                                                    'Unknown',
                                                type: TextTypes.f_13_500),
                                            Label(
                                                txt: publisher?.genre?.first ??
                                                    "Unknown",
                                                type: TextTypes.f_13_500),
                                          ]),
                                    ),
                                  );
                                }),
                              )),
                        ),
                        padVertical(30),
                        GestureDetector(
                          onTap: controller.navigateToTeachers,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Label(
                                txt: AppLocalization.of(context)
                                    .translate('Authors'),
                                type: TextTypes.f_20_500,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: screenWidth * 0.045,
                              ),
                            ],
                          ),
                        ),
                        padVertical(10),
                        Obx(() => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    controller.bookMarket.value?.data?.author
                                            ?.length ??
                                        0, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      final teacherId = controller.bookMarket
                                          .value?.data?.author?[index].sId;
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
                                                            .bookMarket
                                                            .value
                                                            ?.data
                                                            ?.author?[index]
                                                            .image !=
                                                        null
                                                    ? Image.network(
                                                        height: 100,
                                                        width: 100,
                                                        "${AppConfig.imgBaseUrl}${controller.bookMarket.value?.data?.author?[index].image}",
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            Image.asset(
                                                                height: 100,
                                                                width: 100,
                                                                AppAssets.book,
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
                                          SizedBox(height: screenHeight * 0.01),
                                          Label(
                                            txt: controller.getBookTitle(
                                                name: controller
                                                    .bookMarket
                                                    .value
                                                    ?.data
                                                    ?.author?[index]
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
                            )),
                        padVertical(30),
                        GestureDetector(
                            onTap: controller.navigateToPublishers,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Label(
                                    txt: AppLocalization.of(context)
                                        .translate('Publishers'),
                                    type: TextTypes.f_20_500),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                )
                              ],
                            )),
                        padVertical(15),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Obx(() => Row(
                                children: List.generate(
                                    controller.bookMarket.value?.data?.publisher
                                            ?.length ??
                                        0, (index) {
                                  final publisher = controller.bookMarket.value
                                      ?.data?.publisher?[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        final teacherId = controller.bookMarket
                                            .value?.data?.publisher?[index].sId;
                                        if (teacherId != null) {
                                          print(
                                              "Navigating to teacher profile: $teacherId");
                                          Get.toNamed('/publisherDetail',
                                              arguments: {
                                                "teacherId": teacherId
                                              });
                                        }
                                      },
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 144,
                                              width: 144,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: publisher?.image != null
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.network(
                                                          "${AppConfig.imgBaseUrl}${publisher?.image}",
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) =>
                                                              Image.asset(
                                                                  AppAssets
                                                                      .book,
                                                                  fit: BoxFit
                                                                      .contain),
                                                        ),
                                                      )
                                                    : Image.asset(
                                                        AppAssets.book,
                                                        fit: BoxFit.contain),
                                              ),
                                            ),
                                            padVertical(5),
                                            Label(
                                                txt: controller.getBookTitle(
                                                        name:
                                                            publisher?.name) ??
                                                    'Unknown',
                                                type: TextTypes.f_13_500),
                                          ]),
                                    ),
                                  );
                                }),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
      ),
    );
  }

  Widget _buildCollectionsTab(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        controller.bookMarket.value?.data?.collections?.data?.mindBlowing
                    ?.isEmpty ==
                true
            ? SizedBox()
            : controller.bookMarket.value?.data?.collections?.data?.mindBlowing
                        ?.first.booksId?.isEmpty !=
                    true
                ? _buildSectionHeader(
                    context,
                    id: controller.bookMarket.value?.data?.collections?.data
                        ?.mindBlowing?.first.sId,
                    controller.getBookTitle(
                      name: controller.bookMarket.value?.data?.collections?.data
                          ?.mindBlowing?.first.name,
                    ))
                : SizedBox(),
        padVertical(15),
        Obx(() {
          final popularCollections =
              controller.bookMarket.value?.data?.collections?.data?.mindBlowing;

          if (popularCollections == null || popularCollections.isEmpty) {
            return const SizedBox();
          }
          final books = popularCollections.first.booksId ?? [];
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return _builCollectioinRow(books);
        }),
        padVertical(15),
        controller.bookMarket.value?.data?.collections?.data?.popularCollections
                    ?.isEmpty ==
                true
            ? SizedBox()
            : controller.bookMarket.value?.data?.collections?.data
                        ?.popularCollections?.first.booksId?.isEmpty !=
                    true
                ? _buildSectionHeader(
                    context,
                    id: controller.bookMarket.value?.data?.collections?.data
                        ?.popularCollections?.first.sId,
                    controller.getBookTitle(
                        name: controller.bookMarket.value?.data?.collections
                            ?.data?.popularCollections?.first.name))
                : SizedBox(),
        padVertical(15),
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final popularCollections = controller
              .bookMarket.value?.data?.collections?.data?.popularCollections;

          if (popularCollections == null || popularCollections.isEmpty) {
            return const SizedBox();
          }
          final books = popularCollections.first.booksId ?? [];

          return _builCollectioinRow(books);
        }),
        padVertical(15)
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String titleKey,
      {String emoji = '', String? id}) {
    String title = emoji.isEmpty
        ? AppLocalization.of(context).translate(titleKey)
        : '${emoji}${AppLocalization.of(context).translate(titleKey)}';

    return id != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Label(txt: title, type: TextTypes.f_20_500),
              GestureDetector(
                  onTap: () {
                    print("$id");

                    Get.toNamed("/allcollections",
                        arguments: {"title": title, "id": id});
                  },
                  child: const Icon(Icons.arrow_forward_ios_rounded, size: 18))
            ],
          )
        : SizedBox();
  }

  Widget _buildButtonGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Wrap(
      spacing: screenWidth * 0.015, // Horizontal spacing between items
      runSpacing: screenWidth * 0.025, // Vertical spacing between rows
      children: controller.bookMarket.value?.data?.categories
              ?.asMap()
              .entries
              .map((entry) {
            final index = entry.key;
            final item = entry.value;
            return IntrinsicWidth(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed("/categoryById", arguments: {
                    "teacherId": controller
                        .bookMarket.value?.data?.categories?[index].sId
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
                                "${AppConfig.imgBaseUrl}${controller.bookMarket.value?.data?.categories?[index].image}",
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

  // Add the missing collection row builder
  Widget _builCollectioinRow(List<BooksId> books) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: books.map((book) {
          return GestureDetector(
            onTap: () {
              // Get.toNamed('/book-detail', arguments: {
              //   "id": book?.sId,
              // });

              if (book?.type == "course") {
                Get.toNamed('/Course-detail', arguments: {
                  "id": book?.sId,
                });
              } else {
                Get.toNamed('/book-detail', arguments: {
                  "id": book?.sId,
                });
              }
              // if (book.sId != null) {
              //   controller.navigateToCollection(book.sId!,
              //       controller.getBookTitle(name: book.name) ?? 'Unknown');
              // }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 144,
                    width: 144,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: book.image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                "${AppConfig.imgBaseUrl}${book.image}",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  AppAssets.book,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          : Image.asset(
                              AppAssets.book,
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                  padVertical(5),
                  Label(
                    txt: controller.getBookTitle(name: book.name) ?? 'Unknown',
                    type: TextTypes.f_13_500,
                  ),
                  Label(
                    txt: controller.getBookTitle(
                            name: book.authorId?.isNotEmpty == true
                                ? book.authorId?.first.name
                                : null) ??
                        'Unknown',
                    type: TextTypes.f_13_400,
                    forceColor: AppColors.resnd,
                  ),
                  if (book.genre?.isNotEmpty == true)
                    Label(
                      txt: book.genre!.first,
                      type: TextTypes.f_12_400,
                      forceColor: AppColors.resnd,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
