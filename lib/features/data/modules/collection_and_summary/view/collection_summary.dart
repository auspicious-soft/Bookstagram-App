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
import '../controller/collection_summary_controller.dart';

class CollectionSummary extends GetView<CollectionSummaryController> {
  CollectionSummary({super.key});

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
                                  onPressed: () => Get.back(),
                                ),
                                Obx(() => Label(
                                    txt: "${controller.title.value}",
                                    type: TextTypes.f_20_500)),
                                GestureDetector(
                                  onTap: controller.showFilterBottomSheet,
                                  child: Image.asset(
                                    width: 16,
                                    height: 20,
                                    AppAssets.categoryfil,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                            padVertical(30),
                            // const Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Label(
                            //         txt: "📜   Тарихи тұлғалар",
                            //         type: TextTypes.f_20_300),
                            //     Icon(Icons.arrow_forward_ios_rounded, size: 18),
                            //   ],
                            // ),
                            ListView.builder(
                              itemCount: controller
                                      .collectiondata?.value?.data?.length ??
                                  0,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              child: controller
                                                          .collectiondata
                                                          ?.value
                                                          ?.data?[index]
                                                          .image !=
                                                      null
                                                  ? Image.network(
                                                      height: 20,
                                                      width: 20,
                                                      "${AppConfig.imgBaseUrl}${controller.collectiondata?.value?.data?[index].image}",
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
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Label(
                                              txt: controller.getBookTitle(
                                                  name: controller
                                                      ?.collectiondata
                                                      ?.value
                                                      ?.data?[index]
                                                      ?.name),
                                              type: TextTypes.f_20_300,
                                            ),
                                          ],
                                        ),
                                        const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 18),
                                      ],
                                    ),
                                    padVertical(30),
                                  ],
                                );
                              },
                            ),
                            padVertical(20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).marginSymmetric(horizontal: 10)),
        ),
      ),
    );
  }
}
