import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app_settings/components/loader.dart';
import '../../../../../app_settings/constants/app_config.dart';
import '../../../../../localization/app_localization.dart';
import '../controllers/all_collection_controller.dart';

class PgCollections extends GetView<PgCollectionsController> {
  const PgCollections({Key? key}) : super(key: key);

  getBookTitle({required dynamic name}) {
    // Default title if name is null or invalid
    const String defaultTitle = 'No Title';
    String selectedLanguage = Get.locale?.languageCode ?? "";

    if (name == null) return defaultTitle;

    try {
      switch (selectedLanguage) {
        case 'en':
          return name.eng != null ? name.eng : defaultTitle;
        case 'kk':
          return name.kaz != null ? name.kaz : defaultTitle;
        case 'ru':
          return name.rus != null ? name.rus : defaultTitle;
        default:
          return name.eng ?? name.kaz ?? name.rus ?? defaultTitle;
      }
    } catch (e) {
      // Handle case where name is not null but doesn't have the expected properties
      print("Error in getBookTitle: $e");
      return defaultTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: WidgetGlobalMargin(
          child: Obx(
            () => controller.isLoading.value == true
                ? Container(
                    height: Get.height,
                    width: Get.width,
                    child: Center(child: LoadingScreen()))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back_ios,
                                        color: Colors.black),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  Label(
                                      txt: controller.title.value,
                                      maxWidth: Get.width * 0.4,
                                      forceAlignment: TextAlign.center,
                                      type: TextTypes.f_20_500),
                                  GestureDetector(
                                    onTap: () {
                                      Get.bottomSheet(
                                        FilterBottomSheet(),
                                        isScrollControlled: true,
                                        backgroundColor: AppColors.whiteColor,
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
                              controller.title ==
                                      '${AppLocalization.of(context).translate('bestsellers')}🔥'
                                  ? Obx(
                                      () => Column(
                                        children: List.generate(
                                            controller.bestSellerData.value
                                                    ?.data?.length ??
                                                0, (index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12.0, top: 10),
                                            child: Column(
                                              children: [
                                                padVertical(5),
                                                Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: controller
                                                                  .bestSellerData
                                                                  .value
                                                                  ?.data?[index]
                                                                  ?.book
                                                                  ?.image !=
                                                              null
                                                          ? Image.network(
                                                              height: 100,
                                                              width: 100,
                                                              fit: BoxFit.cover,
                                                              "${AppConfig.imgBaseUrl}${controller.bestSellerData.value?.data?[index]?.book?.image}",
                                                              errorBuilder:
                                                                  (context,
                                                                          error,
                                                                          stackTrace) =>
                                                                      Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16),
                                                                ),
                                                                child: Center(
                                                                  child: Image
                                                                      .asset(
                                                                    AppAssets
                                                                        .book,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                              ),
                                                              child: Center(
                                                                child:
                                                                    Image.asset(
                                                                  AppAssets
                                                                      .book,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                    padHorizontal(10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        padVertical(5),
                                                        Label(
                                                          txt: getBookTitle(
                                                              name: controller
                                                                  .bestSellerData
                                                                  .value
                                                                  ?.data?[index]
                                                                  ?.book
                                                                  ?.name),
                                                          type: TextTypes
                                                              .f_17_500,
                                                        ),
                                                        Label(
                                                          txt: getBookTitle(
                                                              name: controller
                                                                  .bestSellerData
                                                                  .value
                                                                  ?.data?[index]
                                                                  ?.book
                                                                  ?.name),
                                                          type: TextTypes
                                                              .f_13_400,
                                                          forceColor:
                                                              AppColors.resnd,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                padVertical(10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(Icons.star),
                                                        Label(
                                                          txt:
                                                              "${controller.bestSellerData.value?.data?[index]?.book?.averageRating}.0",
                                                          type: TextTypes
                                                              .f_11_500,
                                                        ),
                                                        padHorizontal(8),
                                                        Container(
                                                          height: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            border: Border.all(
                                                              color: AppColors
                                                                  .buttongroupBorder,
                                                              width: 0.6,
                                                            ),
                                                          ),
                                                        ),
                                                        padHorizontal(8),
                                                        Label(
                                                          txt: controller
                                                                  .bestSellerData
                                                                  .value
                                                                  ?.data?[index]
                                                                  ?.book
                                                                  ?.genre
                                                                  ?.first ??
                                                              "",
                                                          type: TextTypes
                                                              .f_11_500,
                                                        ),
                                                      ],
                                                    ),
                                                    // GestureDetector(
                                                    //   onTap: () {
                                                    //     // controller
                                                    //     //     .toggleLike(index);
                                                    //   },
                                                    //   child: Image.asset(
                                                    //     width: 17,
                                                    //     height: 17,
                                                    //     controller.likeStatus[
                                                    //             index]
                                                    //         ? AppAssets.like
                                                    //         : AppAssets.unlike,
                                                    //     fit: BoxFit.contain,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                                padVertical(5),
                                                if (controller.bestSellerData
                                                        .value?.data?.length !=
                                                    (index + 1))
                                                  Divider(),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    )
                                  : controller.title ==
                                          '${AppLocalization.of(context).translate('Audiobooks')}🎧'
                                      ? Obx(
                                          () => Column(
                                            children: List.generate(
                                                controller
                                                        .allAudioBooks
                                                        ?.value
                                                        ?.data
                                                        ?.audioBooks
                                                        ?.length ??
                                                    0, (index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 12.0, top: 10),
                                                child: Column(
                                                  children: [
                                                    padVertical(5),
                                                    Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child: controller
                                                                      .allAudioBooks
                                                                      ?.value
                                                                      ?.data
                                                                      ?.audioBooks?[
                                                                          index]
                                                                      ?.image !=
                                                                  null
                                                              ? Image.network(
                                                                  height: 100,
                                                                  width: 100,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  "${AppConfig.imgBaseUrl}${controller.allAudioBooks?.value?.data?.audioBooks?[index].image}",
                                                                  errorBuilder: (context,
                                                                          error,
                                                                          stackTrace) =>
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child: Image
                                                                          .asset(
                                                                        AppAssets
                                                                            .book,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                  ),
                                                                  child: Center(
                                                                    child: Image
                                                                        .asset(
                                                                      AppAssets
                                                                          .book,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                  ),
                                                                ),
                                                        ),
                                                        padHorizontal(10),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            padVertical(5),
                                                            Label(
                                                              txt: getBookTitle(
                                                                  name: controller
                                                                      .allAudioBooks
                                                                      ?.value
                                                                      ?.data
                                                                      ?.audioBooks?[
                                                                          index]
                                                                      ?.name),
                                                              type: TextTypes
                                                                  .f_17_500,
                                                            ),
                                                            Label(
                                                              txt: getBookTitle(
                                                                  name: controller
                                                                      .allAudioBooks
                                                                      ?.value
                                                                      ?.data
                                                                      ?.audioBooks?[
                                                                          index]
                                                                      ?.authorId
                                                                      ?.first
                                                                      ?.name),
                                                              type: TextTypes
                                                                  .f_13_400,
                                                              forceColor:
                                                                  AppColors
                                                                      .resnd,
                                                            ),
                                                            // Label(
                                                            //   txt: getBookTitle(
                                                            //       name: controller.allAudioBooks?.value?.data?.audioBooks?[
                                                            //       index]
                                                            //           ?.publisherId
                                                            //           ?. ??
                                                            //           ""),
                                                            //   type: TextTypes
                                                            //       .f_13_400,
                                                            //   forceColor:
                                                            //   AppColors
                                                            //       .resnd,
                                                            // ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    padVertical(10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                                Icons.star),
                                                            Label(
                                                              txt:
                                                                  "${controller.allAudioBooks?.value?.data?.audioBooks?[index].averageRating?.toString()}.0",
                                                              type: TextTypes
                                                                  .f_11_500,
                                                            ),
                                                            padHorizontal(8),
                                                            Container(
                                                              height: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                border:
                                                                    Border.all(
                                                                  color: AppColors
                                                                      .buttongroupBorder,
                                                                  width: 0.6,
                                                                ),
                                                              ),
                                                            ),
                                                            padHorizontal(8),
                                                            Label(
                                                              txt: getBookTitle(
                                                                  name: controller
                                                                          .allAudioBooks
                                                                          ?.value
                                                                          ?.data
                                                                          ?.audioBooks?[
                                                                              index]
                                                                          ?.categoryId
                                                                          ?.first
                                                                          ?.name ??
                                                                      ""),
                                                              type: TextTypes
                                                                  .f_11_500,
                                                            ),
                                                          ],
                                                        ),
                                                        // GestureDetector(
                                                        //   onTap: () {
                                                        //     controller
                                                        //         .toggleLike(
                                                        //             index);
                                                        //   },
                                                        //   child: Image.asset(
                                                        //     width: 17,
                                                        //     height: 17,
                                                        //     controller.likeStatus[
                                                        //             index]
                                                        //         ? AppAssets.like
                                                        //         : AppAssets
                                                        //             .unlike,
                                                        //     fit: BoxFit.contain,
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                    padVertical(5),
                                                    if (controller
                                                            .allAudioBooks
                                                            ?.value
                                                            ?.data
                                                            ?.audioBooks
                                                            ?.length !=
                                                        (index + 1))
                                                      Divider(),
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                        )
                                      : controller.title ==
                                              '${AppLocalization.of(context).translate('newbooks')}💌'
                                          ? Obx(
                                              () => Column(
                                                children: List.generate(
                                                    controller
                                                            .allNewBooks
                                                            ?.value
                                                            ?.data
                                                            ?.newBooks
                                                            ?.length ??
                                                        0, (index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 12.0,
                                                            top: 10),
                                                    child: Column(
                                                      children: [
                                                        padVertical(5),
                                                        Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              child: controller
                                                                          .allNewBooks
                                                                          ?.value
                                                                          ?.data
                                                                          ?.newBooks?[
                                                                              index]
                                                                          ?.image !=
                                                                      null
                                                                  ? Image
                                                                      .network(
                                                                      height:
                                                                          100,
                                                                      width:
                                                                          100,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      "${AppConfig.imgBaseUrl}${controller.allNewBooks?.value?.data?.newBooks?[index].image}",
                                                                      errorBuilder: (context,
                                                                              error,
                                                                              stackTrace) =>
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(16),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Image.asset(
                                                                            AppAssets.book,
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(16),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child: Image
                                                                            .asset(
                                                                          AppAssets
                                                                              .book,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ),
                                                            ),
                                                            padHorizontal(10),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                padVertical(5),
                                                                Label(
                                                                  txt: getBookTitle(
                                                                      name: controller
                                                                          .allNewBooks
                                                                          ?.value
                                                                          ?.data
                                                                          ?.newBooks?[
                                                                              index]
                                                                          ?.name),
                                                                  type: TextTypes
                                                                      .f_17_500,
                                                                ),
                                                                Label(
                                                                  txt: getBookTitle(
                                                                      name: controller
                                                                          .allNewBooks
                                                                          ?.value
                                                                          ?.data
                                                                          ?.newBooks?[
                                                                              index]
                                                                          ?.authorId
                                                                          ?.first
                                                                          ?.name),
                                                                  type: TextTypes
                                                                      .f_13_400,
                                                                  forceColor:
                                                                      AppColors
                                                                          .resnd,
                                                                ),
                                                                // Label(
                                                                //   txt: getBookTitle(
                                                                //       name: controller.allAudioBooks?.value?.data?.audioBooks?[
                                                                //       index]
                                                                //           ?.publisherId
                                                                //           ?. ??
                                                                //           ""),
                                                                //   type: TextTypes
                                                                //       .f_13_400,
                                                                //   forceColor:
                                                                //   AppColors
                                                                //       .resnd,
                                                                // ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        padVertical(10),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Icon(
                                                                    Icons.star),
                                                                Label(
                                                                  txt:
                                                                      "${controller.allNewBooks?.value?.data?.newBooks?[index].averageRating?.toString()}.0",
                                                                  type: TextTypes
                                                                      .f_11_500,
                                                                ),
                                                                padHorizontal(
                                                                    8),
                                                                Container(
                                                                  height: 20,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: AppColors
                                                                          .buttongroupBorder,
                                                                      width:
                                                                          0.6,
                                                                    ),
                                                                  ),
                                                                ),
                                                                padHorizontal(
                                                                    8),
                                                                Label(
                                                                  txt: getBookTitle(
                                                                      name: controller
                                                                              .allNewBooks
                                                                              ?.value
                                                                              ?.data
                                                                              ?.newBooks?[index]
                                                                              ?.categoryId
                                                                              ?.first
                                                                              ?.name ??
                                                                          ""),
                                                                  type: TextTypes
                                                                      .f_11_500,
                                                                ),
                                                              ],
                                                            ),
                                                            // GestureDetector(
                                                            //   onTap: () {
                                                            //     controller
                                                            //         .toggleLike(
                                                            //             index);
                                                            //   },
                                                            //   child:
                                                            //       Image.asset(
                                                            //     width: 17,
                                                            //     height: 17,
                                                            //     controller.likeStatus[
                                                            //             index]
                                                            //         ? AppAssets
                                                            //             .like
                                                            //         : AppAssets
                                                            //             .unlike,
                                                            //     fit: BoxFit
                                                            //         .contain,
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                        padVertical(5),
                                                        if (controller
                                                                .allNewBooks
                                                                ?.value
                                                                ?.data
                                                                ?.newBooks
                                                                ?.length !=
                                                            (index + 1))
                                                          Divider(),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              ),
                                            )
                                          : Obx(
                                              () => Column(
                                                children: List.generate(
                                                    controller
                                                            .collectiondata
                                                            .value
                                                            ?.data
                                                            ?.booksId
                                                            ?.length ??
                                                        0, (index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 12.0,
                                                            top: 10),
                                                    child: Column(
                                                      children: [
                                                        padVertical(5),
                                                        Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              child: controller
                                                                          .collectiondata
                                                                          .value
                                                                          ?.data
                                                                          ?.booksId?[
                                                                              index]
                                                                          ?.image !=
                                                                      null
                                                                  ? Image
                                                                      .network(
                                                                      height:
                                                                          100,
                                                                      width:
                                                                          100,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      "${AppConfig.imgBaseUrl}${controller.collectiondata.value?.data?.booksId?[index].image}",
                                                                      errorBuilder: (context,
                                                                              error,
                                                                              stackTrace) =>
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(16),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Image.asset(
                                                                            AppAssets.book,
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(16),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child: Image
                                                                            .asset(
                                                                          AppAssets
                                                                              .book,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ),
                                                            ),
                                                            padHorizontal(10),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                padVertical(5),
                                                                Label(
                                                                  txt: getBookTitle(
                                                                      name: controller
                                                                          .collectiondata
                                                                          .value
                                                                          ?.data
                                                                          ?.booksId?[
                                                                              index]
                                                                          ?.name),
                                                                  type: TextTypes
                                                                      .f_17_500,
                                                                ),
                                                                Label(
                                                                  txt: getBookTitle(
                                                                      name: controller
                                                                          .collectiondata
                                                                          .value
                                                                          ?.data
                                                                          ?.booksId?[
                                                                              index]
                                                                          ?.authorId
                                                                          ?.first
                                                                          ?.name),
                                                                  type: TextTypes
                                                                      .f_13_400,
                                                                  forceColor:
                                                                      AppColors
                                                                          .resnd,
                                                                ),
                                                                Label(
                                                                  txt: getBookTitle(
                                                                      name: controller
                                                                              .collectiondata
                                                                              .value
                                                                              ?.data
                                                                              ?.booksId?[index]
                                                                              ?.publisherId
                                                                              ?.name ??
                                                                          ""),
                                                                  type: TextTypes
                                                                      .f_13_400,
                                                                  forceColor:
                                                                      AppColors
                                                                          .resnd,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        padVertical(10),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Icon(
                                                                    Icons.star),
                                                                Label(
                                                                  txt:
                                                                      "${controller.collectiondata.value?.data?.booksId?[index].averageRating?.toString()}.0",
                                                                  type: TextTypes
                                                                      .f_11_500,
                                                                ),
                                                                padHorizontal(
                                                                    8),
                                                                Container(
                                                                  height: 20,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: AppColors
                                                                          .buttongroupBorder,
                                                                      width:
                                                                          0.6,
                                                                    ),
                                                                  ),
                                                                ),
                                                                padHorizontal(
                                                                    8),
                                                                Label(
                                                                  txt: getBookTitle(
                                                                      name: controller
                                                                              .collectiondata
                                                                              .value
                                                                              ?.data
                                                                              ?.booksId?[index]
                                                                              ?.categoryId
                                                                              ?.first
                                                                              ?.name ??
                                                                          ""),
                                                                  type: TextTypes
                                                                      .f_11_500,
                                                                ),
                                                              ],
                                                            ),
                                                            // GestureDetector(
                                                            //   onTap: () {
                                                            //     controller
                                                            //         .toggleLike(
                                                            //             index);
                                                            //   },
                                                            //   child:
                                                            //       Image.asset(
                                                            //     width: 17,
                                                            //     height: 17,
                                                            //     controller.likeStatus[
                                                            //             index]
                                                            //         ? AppAssets
                                                            //             .like
                                                            //         : AppAssets
                                                            //             .unlike,
                                                            //     fit: BoxFit
                                                            //         .contain,
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                        padVertical(5),
                                                        if (controller
                                                                .collectiondata
                                                                .value
                                                                ?.data
                                                                ?.booksId
                                                                ?.length !=
                                                            (index + 1))
                                                          Divider(),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
