import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app_settings/components/loader.dart';
import '../../../../../app_settings/constants/app_config.dart';
import '../controller/reading_now_controller.dart';

class PgReadingBooks extends GetView<PgReadingBooksController> {
  const PgReadingBooks({super.key});

  @override
  Widget build(BuildContext context) {
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
                                  onPressed: controller.goBack,
                                ),
                                Label(
                                  txt: AppLocalization.of(context)
                                      .translate('readingnow'),
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
                            controller?.collectiondata?.value?.data?.length == 0
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
                                : ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: controller.collectiondata.value
                                            ?.data?.length ??
                                        0, // Adjust based on your data
                                    itemBuilder: (context, index) {
                                      final book = controller
                                          .collectiondata.value?.data?[index];
                                      return Container(
                                        width:
                                            ScreenUtils.screenWidth(context) *
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
                                              child: book?.bookId?.image != null
                                                  ? Image.network(
                                                      width: 113,
                                                      height: 130,
                                                      "${AppConfig.imgBaseUrl}${book?.bookId?.image}",
                                                      fit: BoxFit.fill,
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Image.asset(
                                                        AppAssets.book,
                                                        width: 113,
                                                        height: 130,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )
                                                  : Image.asset(
                                                      width: 113,
                                                      height: 130,
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
                                                    txt:
                                                        controller.getBookTitle(
                                                            name: book
                                                                ?.bookId?.name),
                                                    type: TextTypes.f_15_500,
                                                  ),
                                                  Label(
                                                    txt:
                                                        controller.getBookTitle(
                                                            name: book
                                                                ?.bookId
                                                                ?.authorId
                                                                ?.first
                                                                ?.name),
                                                    type: TextTypes.f_15_400,
                                                    forceColor: AppColors.resnd,
                                                  ),
                                                  Label(
                                                    txt: book?.bookId?.type ??
                                                        "",
                                                    type: TextTypes.f_13_400,
                                                    forceColor: AppColors.resnd,
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
                                                            "${book?.progress?.toStringAsFixed(1)}%",
                                                        // Replace with dynamic value like "${(book.progress * 100).toInt()}%"
                                                        type:
                                                            TextTypes.f_12_400,
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
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      child: Label(
                                                        txt: AppLocalization.of(
                                                                context)
                                                            .translate(
                                                                'continue'),
                                                        type:
                                                            TextTypes.f_13_400,
                                                        forceColor: AppColors
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
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
        ),
      ),
    );
  }
}
