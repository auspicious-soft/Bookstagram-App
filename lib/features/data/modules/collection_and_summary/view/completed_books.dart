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
import '../controller/completed_books_controller.dart';
import '../controller/favorite_books_controller.dart';

class CompletedBooks extends GetView<CompletedBooksController> {
  const CompletedBooks({super.key});

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
                  child: Obx(() => controller.isLoading.value == true
                      ? Container(
                          height: Get.height,
                          width: Get.width,
                          child: Center(child: LoadingScreen()))
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            padVertical(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios,
                                      color: Colors.black),
                                  onPressed: controller.goBack,
                                ),
                                Label(
                                  txt: AppLocalization.of(context)
                                      .translate('completedbooks'),
                                  type: TextTypes.f_20_500,
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      controller.showFilterBottomSheet(context),
                                  child: Image.asset(
                                    width: 16,
                                    height: 20,
                                    AppAssets.categoryfil,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                            padVertical(10),
                            Obx(() => controller
                                        ?.collectiondata?.value?.data?.length ==
                                    0
                                ? Container(
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
                                          txt: "Nothing found on this request",
                                          type: TextTypes.f_13_500,
                                        ),
                                      ],
                                    ),
                                  )
                                : Column(
                                    children: List.generate(
                                        controller?.collectiondata?.value?.data
                                                ?.length ??
                                            0, (index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          await Get.toNamed('/book-detail',
                                              arguments: {
                                                "id": controller
                                                    .collectiondata
                                                    .value
                                                    ?.data?[index]
                                                    ?.bookId
                                                    ?.sId,
                                              });
                                          controller.GetAllReadBooks();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12.0, top: 10),
                                          child: Column(
                                            children: [
                                              padVertical(5),
                                              Row(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          child: Center(
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              child: controller
                                                                          ?.collectiondata
                                                                          ?.value
                                                                          ?.data?[
                                                                              index]
                                                                          ?.bookId
                                                                          ?.image !=
                                                                      null
                                                                  ? Image
                                                                      .network(
                                                                      width:
                                                                          113,
                                                                      height:
                                                                          130,
                                                                      "${AppConfig.imgBaseUrl}${controller?.collectiondata?.value?.data?[index]?.bookId?.image}",
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      errorBuilder: (context,
                                                                              error,
                                                                              stackTrace) =>
                                                                          Image
                                                                              .asset(
                                                                        AppAssets
                                                                            .book,
                                                                        width:
                                                                            113,
                                                                        height:
                                                                            130,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    )
                                                                  : Image.asset(
                                                                      width:
                                                                          113,
                                                                      height:
                                                                          130,
                                                                      AppAssets
                                                                          .book,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  padHorizontal(10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      padVertical(5),
                                                      Label(
                                                        txt:
                                                            "${controller.getBookTitle(name: controller?.collectiondata?.value?.data?[index]?.bookId?.name)}",
                                                        type:
                                                            TextTypes.f_17_500,
                                                      ),
                                                      Label(
                                                        txt:
                                                            "${controller.getBookTitle(name: controller?.collectiondata?.value?.data?[index]?.bookId?.authorId?.first?.name)}",
                                                        type:
                                                            TextTypes.f_13_400,
                                                        forceColor:
                                                            AppColors.resnd,
                                                      ),
                                                      Label(
                                                        txt:
                                                            "${controller?.collectiondata?.value?.data?[index]?.bookId?.genre?.first}",
                                                        type:
                                                            TextTypes.f_13_400,
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
                                                      Icon(Icons.star),
                                                      Label(
                                                        txt:
                                                            "${controller?.collectiondata?.value?.data?[index]?.bookId?.averageRating?.toStringAsFixed(1) ?? 0.0}",
                                                        type:
                                                            TextTypes.f_11_500,
                                                      ),
                                                      padHorizontal(8),
                                                      Container(
                                                        height: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          border: Border.all(
                                                            color: AppColors
                                                                .buttongroupBorder,
                                                            width: 0.6,
                                                          ),
                                                        ),
                                                      ),
                                                      padHorizontal(8),
                                                      Label(
                                                        txt:
                                                            "${controller?.collectiondata?.value?.data?[index]?.bookId?.genre?.first}",
                                                        type:
                                                            TextTypes.f_11_500,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              padVertical(5),
                                              if ((index + 1) !=
                                                  controller?.collectiondata
                                                      ?.value?.data?.length)
                                                const Divider(),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  )),
                          ],
                        )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
