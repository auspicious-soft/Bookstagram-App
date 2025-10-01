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
import '../../../../../app_settings/constants/common_button.dart';
import '../../../../../localization/app_localization.dart';
import '../controllers/CollectionSummaryBooksController.dart';
import '../controllers/Subcategories_books_controller.dart';

class Collectionsummarybooks extends GetView<Collectionsummarybookscontroller> {
  const Collectionsummarybooks({Key? key}) : super(key: key);

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
                                        StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            // Define state variables

                                            return SingleChildScrollView(
                                              child: Container(
                                                height: Get.height / 1.2,
                                                decoration: const BoxDecoration(
                                                  color: AppColors.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Header
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text('  '),
                                                          Label(
                                                            txt: AppLocalization
                                                                    .of(context)
                                                                .translate(
                                                                    'Filter'),
                                                            type: TextTypes
                                                                .f_17_500,
                                                          ),
                                                          IconButton(
                                                            onPressed: () {
                                                              // controller
                                                              //     .fetchBookStudy(
                                                              //         controller
                                                              //             .id
                                                              //             .value);
                                                              Get.back(); // Close the bottom sheet
                                                            },
                                                            icon: Image.asset(
                                                              width: 30,
                                                              height: 30,
                                                              AppAssets.close,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      // Sorting Section
                                                      Label(
                                                        txt: AppLocalization.of(
                                                                context)
                                                            .translate(
                                                                'sorting'),
                                                        forceColor: AppColors
                                                            .buttongroupBorder,
                                                        type:
                                                            TextTypes.f_13_400,
                                                      ),
                                                      padVertical(20),
                                                      // Default
                                                      GestureDetector(
                                                        onTap: () {
                                                          controller.filter
                                                                  .value =
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
                                                              txt: AppLocalization
                                                                      .of(
                                                                          context)
                                                                  .translate(
                                                                      'thedefault'),
                                                              type: TextTypes
                                                                  .f_16_500,
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
                                                                    color: Colors
                                                                        .orange,
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .radio_button_checked,
                                                                    color: Colors
                                                                        .orange,
                                                                  ))
                                                          ],
                                                        ),
                                                      ),
                                                      padVertical(15),
                                                      // Alphabetically
                                                      GestureDetector(
                                                        onTap: () {
                                                          controller.filter
                                                                  .value =
                                                              AppLocalization.of(
                                                                      context)
                                                                  .translate(
                                                                      'alphabetically');
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Label(
                                                              txt: AppLocalization
                                                                      .of(
                                                                          context)
                                                                  .translate(
                                                                      'alphabetically'),
                                                              type: TextTypes
                                                                  .f_16_500,
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
                                                                    color: Colors
                                                                        .orange,
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .radio_button_checked,
                                                                    color: Colors
                                                                        .orange,
                                                                  ))
                                                          ],
                                                        ),
                                                      ),
                                                      padVertical(15),
                                                      // By Rating
                                                      GestureDetector(
                                                        onTap: () {
                                                          controller.filter
                                                                  .value =
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
                                                              txt: AppLocalization
                                                                      .of(
                                                                          context)
                                                                  .translate(
                                                                      'byrating'),
                                                              type: TextTypes
                                                                  .f_16_500,
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
                                                                    color: Colors
                                                                        .orange,
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .radio_button_checked,
                                                                    color: Colors
                                                                        .orange,
                                                                  ))
                                                          ],
                                                        ),
                                                      ),
                                                      padVertical(15),
                                                      // By Novelty
                                                      GestureDetector(
                                                        onTap: () {
                                                          controller.filter
                                                                  .value =
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
                                                              txt: AppLocalization
                                                                      .of(
                                                                          context)
                                                                  .translate(
                                                                      'bynovelty'),
                                                              type: TextTypes
                                                                  .f_16_500,
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
                                                                    color: Colors
                                                                        .orange,
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .radio_button_checked,
                                                                    color: Colors
                                                                        .orange,
                                                                  ))
                                                          ],
                                                        ),
                                                      ),
                                                      padVertical(15),
                                                      SizedBox(
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.2),
                                                      commonButton(
                                                        context: context,
                                                        onPressed: () {
                                                          controller
                                                              .fetchBookStudy(
                                                                  controller.id
                                                                      .value);
                                                          Get.back();
                                                        },
                                                        txt: AppLocalization.of(
                                                                context)
                                                            .translate(
                                                                'Filter'),
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
                                      width: 16,
                                      height: 20,
                                      AppAssets.categoryfil,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                              Obx(
                                () => Center(
                                  child: controller.collectiondata.value?.data
                                              ?.books?.length ==
                                          0
                                      ? Column(
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
                                        )
                                      : Column(
                                          children: List.generate(
                                              controller.collectiondata.value
                                                      ?.data?.books?.length ??
                                                  0, (index) {
                                            return GestureDetector(
                                              onTap: () async {
                                                if (controller
                                                        .collectiondata
                                                        .value
                                                        ?.data
                                                        ?.books?[index]
                                                        ?.type ==
                                                    "course") {
                                                  await Get.toNamed(
                                                      '/Course-detail',
                                                      arguments: {
                                                        "id": controller
                                                            .collectiondata
                                                            .value
                                                            ?.data
                                                            ?.books?[index]
                                                            ?.sId,
                                                      });
                                                  controller.fetchBookStudy(
                                                      controller.id.value);
                                                } else {
                                                  await Get.toNamed(
                                                      '/book-detail',
                                                      arguments: {
                                                        "id": controller
                                                            .collectiondata
                                                            .value
                                                            ?.data
                                                            ?.books?[index]
                                                            ?.sId,
                                                      });
                                                  controller.fetchBookStudy(
                                                      controller.id.value);
                                                }
                                              },
                                              child: Padding(
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
                                                                      .collectiondata
                                                                      .value
                                                                      ?.data
                                                                      ?.books?[
                                                                          index]
                                                                      ?.image !=
                                                                  null
                                                              ? Image.network(
                                                                  height: 100,
                                                                  width: 100,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  "${AppConfig.imgBaseUrl}${controller.collectiondata.value?.data?.books?[index].image}",
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
                                                                        height:
                                                                            100,
                                                                        width:
                                                                            100,
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
                                                                      height:
                                                                          100,
                                                                      width:
                                                                          100,
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
                                                                      ?.books?[
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
                                                                      ?.books?[
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
                                                                          ?.books?[
                                                                              index]
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
                                                                  "${controller.collectiondata.value?.data?.books?[index].averageRating?.toString()}.0",
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
                                                                          .collectiondata
                                                                          .value
                                                                          ?.data
                                                                          ?.books?[
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
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: Image.asset(
                                                            width: 17,
                                                            height: 17,
                                                            controller
                                                                        .collectiondata
                                                                        .value
                                                                        ?.data
                                                                        ?.books?[
                                                                            index]
                                                                        ?.isFavorite ==
                                                                    true
                                                                ? AppAssets.like
                                                                : AppAssets
                                                                    .unlike,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    padVertical(5),
                                                    if (controller
                                                            .collectiondata
                                                            .value
                                                            ?.data
                                                            ?.books
                                                            ?.length !=
                                                        (index + 1))
                                                      Divider(),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                ),
                              )
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
