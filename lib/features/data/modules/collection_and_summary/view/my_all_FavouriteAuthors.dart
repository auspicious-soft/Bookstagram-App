import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/features/data/modules/collection_and_summary/controller/my_all_FavouriteAuthors_controller.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slideable/slideable.dart';

import '../../../../../app_settings/components/loader.dart';
import '../../../../../app_settings/constants/app_config.dart';

class MyFavoriteAuthorView extends GetView<MyFavoriteAuthorController> {
  const MyFavoriteAuthorView({super.key});

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
                                .translate('favoriteauthors'),
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
                      padVertical(10),
                      Obx(
                        () => controller.isLoading.value == true
                            ? Container(
                                height: Get.height,
                                width: Get.width,
                                child: Center(child: LoadingScreen()))
                            : controller?.collectiondata?.value?.data?.length ==
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
                                      controller.collectiondata?.value?.data
                                              ?.length ??
                                          0,
                                      (index) => GestureDetector(
                                        onTap: () async {
                                          await Get.toNamed("/teacherDetail",
                                              arguments: {
                                                "teacherId": controller
                                                    .collectiondata
                                                    ?.value
                                                    ?.data?[index]
                                                    ?.authorId
                                                    ?.sId,
                                              });

                                          controller.GetAllReadBooks();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12.0, top: 10),
                                          child: Slideable(
                                            backgroundColor:
                                                AppColors.background,
                                            resetSlide: index ==
                                                    controller
                                                        .resetSlideIndex.value
                                                ? false
                                                : true,
                                            items: <ActionItems>[
                                              ActionItems(
                                                icon: const Icon(
                                                  Icons.delete_outlined,
                                                  color: Colors.white,
                                                ),
                                                onPress: () => controller
                                                    .deleteAuthor(index),
                                                backgroudColor:
                                                    AppColors.primaryColor,
                                              ),
                                            ],
                                            child: GestureDetector(
                                              onLongPressDown: (_) {
                                                controller
                                                    .updateSlideIndex(index);
                                              },
                                              child: Column(
                                                children: [
                                                  padVertical(10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            88)),
                                                            child: controller
                                                                        ?.collectiondata
                                                                        ?.value
                                                                        ?.data?[
                                                                            index]
                                                                        ?.productId
                                                                        ?.image !=
                                                                    null
                                                                ? Image.network(
                                                                    width: 70,
                                                                    height: 70,
                                                                    "${AppConfig.imgBaseUrl}${controller?.collectiondata?.value?.data?[index]?.productId?.image}",
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    errorBuilder: (context,
                                                                            error,
                                                                            stackTrace) =>
                                                                        Image
                                                                            .asset(
                                                                      AppAssets
                                                                          .book,
                                                                      width: 70,
                                                                      height:
                                                                          70,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  )
                                                                : Image.asset(
                                                                    width: 70,
                                                                    height: 70,
                                                                    AppAssets
                                                                        .book,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                          ),
                                                          padHorizontal(10),
                                                          Label(
                                                            txt: controller.getBookTitle(
                                                                name: controller
                                                                    .collectiondata
                                                                    ?.value
                                                                    ?.data?[
                                                                        index]
                                                                    ?.authorId
                                                                    ?.name),
                                                            type: TextTypes
                                                                .f_16_500,
                                                          ),
                                                        ],
                                                      ),
                                                      const Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        size: 18,
                                                      ),
                                                    ],
                                                  ),
                                                  padVertical(5),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
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
    );
  }
}
