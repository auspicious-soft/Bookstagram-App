import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/features/data/modules/splash/controllers/publisher_detail_controller.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_more_text/read_more_text.dart';

import '../../../../../app_settings/components/loader.dart';
import '../../../../../app_settings/constants/app_config.dart';

class PublisherDetailScreen extends StatelessWidget {
  const PublisherDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller once
    final controller = Get.put(PublisherDetailController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: GetBuilder<PublisherDetailController>(
        init: controller,
        builder: (controller) => SingleChildScrollView(
            child: Obx(
          () => controller.isLoading.value
              ? SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: const Center(child: LoadingScreen()),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        // Background image with gradient overlay
                        Container(
                          height: Get.height * 0.4,
                          width: Get.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: controller.bookStudy.value?.data?.publisher
                                          ?.image !=
                                      null
                                  ? NetworkImage(
                                      "${AppConfig.imgBaseUrl}${controller.bookStudy.value?.data?.publisher?.image}",
                                    )
                                  : AssetImage(AppAssets.book),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.background.withOpacity(0.0),
                                  AppColors.background.withOpacity(0.3),
                                  AppColors.background.withOpacity(0.8),
                                  AppColors.background,
                                ],
                                stops: const [0.0, 0.5, 0.8, 1.0],
                              ),
                            ),
                          ),
                        ),
                        // AppBar-like header
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 15,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white),
                                onPressed: () => Get.back(),
                              ),
                              Label(
                                txt: controller.getBookTitle(
                                  name: controller.bookStudy.value?.data
                                          ?.publisher?.name ??
                                      'Unknown',
                                ),
                                type: TextTypes.f_20_500,
                                forceColor: AppColors.whiteColor,
                              ),
                              IconButton(
                                icon: const Icon(Icons.file_upload_outlined,
                                    color: Colors.white),
                                onPressed: () => Get.back(),
                              ),
                            ],
                          ),
                        ),
                        // Main content
                        Container(
                          margin: EdgeInsets.only(top: Get.height * 0.25),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              padVertical(8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Label(
                                        txt: controller.getBookTitle(
                                          name: controller.bookStudy.value?.data
                                                  ?.publisher?.name ??
                                              'Unknown',
                                        ),
                                        type: TextTypes.f_22_700,
                                      ),
                                      Label(
                                        txt: AppLocalization.of(context)
                                            .translate('Publisher'),
                                        type: TextTypes.f_13_500,
                                        forceColor: AppColors.resnd,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              padVertical(8),
                              Label(
                                txt:
                                    "${controller.bookStudy.value?.data?.booksCount?.toString() ?? ''}+",
                                type: TextTypes.f_17_500,
                              ),
                              Label(
                                txt: AppLocalization.of(context)
                                    .translate('bookCount'),
                                type: TextTypes.f_13_500,
                                forceColor: AppColors.resnd,
                              ),
                              padVertical(10),
                              ReadMoreText(
                                controller.getBookTitle(
                                  name: controller.bookStudy.value?.data
                                          ?.publisher?.description ??
                                      '',
                                ),
                                numLines: 3,
                                readMoreTextStyle: const TextStyle(
                                  color: AppColors.resnd,
                                  fontFamily: AppConst.fontFamily,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                                readMoreAlign: Alignment.center,
                                readMoreText: 'Read more',
                                readLessText: 'Read less',
                                readMoreIconColor: Colors.grey,
                                style: const TextStyle(
                                  color: AppColors.resnd,
                                  fontFamily: AppConst.fontFamily,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              padVertical(10),
                              Label(
                                txt: AppLocalization.of(context)
                                    .translate('Categories'),
                                type: TextTypes.f_15_500,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    controller.bookStudy.value?.data?.publisher
                                            ?.categoryId?.length ??
                                        0,
                                    (index) => Padding(
                                      padding: const EdgeInsets.only(
                                          right: 12.0, top: 10, bottom: 10),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
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
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          // Ensure Row takes minimum width
                                          children: [
                                            ClipRRect(
                                              child: controller
                                                          .bookStudy
                                                          .value
                                                          ?.data
                                                          ?.publisher
                                                          ?.categoryId?[index]
                                                          .image !=
                                                      null
                                                  ? Image.network(
                                                      height: 20,
                                                      width: 20,
                                                      "${AppConfig.imgBaseUrl}${controller.bookStudy.value?.data?.publisher?.categoryId?[index].image}",
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Label(
                                                        txt: "📋",
                                                        type:
                                                            TextTypes.f_18_400,
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
                                                txt: controller.getBookTitle(
                                                        name: controller
                                                            .bookStudy
                                                            .value
                                                            ?.data
                                                            ?.publisher
                                                            ?.categoryId?[index]
                                                            .name) ??
                                                    'Unknown',
                                                type: TextTypes.f_18_400,
                                              ).marginSymmetric(horizontal: 8),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              padVertical(20),
                              controller.bookStudy.value?.data?.publisherBooks
                                          ?.length !=
                                      0
                                  ? GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Label(
                                            txt: AppLocalization.of(context)
                                                .translate('Publishedbooks'),
                                            type: TextTypes.f_15_500,
                                          ),
                                          const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 18),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                              Obx(
                                () => Column(
                                  children: List.generate(
                                      controller.bookStudy.value?.data
                                              ?.publisherBooks?.length ??
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
                                                    BorderRadius.circular(15),
                                                child: controller
                                                            .bookStudy
                                                            .value
                                                            ?.data
                                                            ?.publisherBooks?[
                                                                index]
                                                            ?.image !=
                                                        null
                                                    ? Image.network(
                                                        height: 100,
                                                        width: 100,
                                                        fit: BoxFit.cover,
                                                        "${AppConfig.imgBaseUrl}${controller.bookStudy.value?.data?.publisherBooks?[index]?.image}",
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          child: Center(
                                                            child: Image.asset(
                                                              AppAssets.book,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        child: Center(
                                                          child: Image.asset(
                                                            AppAssets.book,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                              padHorizontal(10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  padVertical(5),
                                                  Label(
                                                    txt: controller.getBookTitle(
                                                        name: controller
                                                            .bookStudy
                                                            .value
                                                            ?.data
                                                            ?.publisherBooks?[
                                                                index]
                                                            ?.name),
                                                    type: TextTypes.f_17_500,
                                                  ),
                                                  Label(
                                                    txt: controller.getBookTitle(
                                                        name: controller
                                                            .bookStudy
                                                            .value
                                                            ?.data
                                                            ?.publisherBooks?[
                                                                index]
                                                            ?.authorId
                                                            ?.first
                                                            ?.name),
                                                    type: TextTypes.f_13_400,
                                                    forceColor: AppColors.resnd,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          padVertical(10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(Icons.star),
                                                  Label(
                                                    txt:
                                                        "${controller.bookStudy.value?.data?.publisherBooks?[index]?.averageRating}.0",
                                                    type: TextTypes.f_11_500,
                                                  ),
                                                  padHorizontal(8),
                                                  Container(
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                            .bookStudy
                                                            .value
                                                            ?.data
                                                            ?.publisherBooks?[
                                                                index]
                                                            ?.genre
                                                            ?.first ??
                                                        "",
                                                    type: TextTypes.f_11_500,
                                                  ),
                                                ],
                                              ),
                                              // GestureDetector(
                                              //   onTap: () {
                                              //     controller.toggleLike(index);
                                              //   },
                                              //   child: Image.asset(
                                              //     width: 17,
                                              //     height: 17,
                                              //     controller.likeStatus[index]
                                              //         ? AppAssets.like
                                              //         : AppAssets.unlike,
                                              //     fit: BoxFit.contain,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          padVertical(5),
                                          if (controller.bookStudy.value?.data
                                                  ?.publisherBooks?.length !=
                                              (index + 1))
                                            Divider(),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        )),
      ),
    );
  }
}
