import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/all_collection_controller.dart';


class PgCollections extends GetView<PgCollectionsController> {

  const PgCollections({Key? key}) : super(key: key);

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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          Label(txt: controller.title.value,maxWidth:Get.width*0.4,forceAlignment: TextAlign.center, type: TextTypes.f_20_500),
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

                      Obx(
                            () => Column(
                          children: List.generate(3, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 12.0, top: 10),
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
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  AppAssets.book,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      padHorizontal(10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          padVertical(5),
                                          const Label(
                                            txt: "Көксерек",
                                            type: TextTypes.f_17_500,
                                          ),
                                          const Label(
                                            txt: "Мұхтар Әуезов",
                                            type: TextTypes.f_13_400,
                                            forceColor: AppColors.resnd,
                                          ),
                                          const Label(
                                            txt: "Аудио",
                                            type: TextTypes.f_13_400,
                                            forceColor: AppColors.resnd,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  padVertical(10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.star),
                                          const Label(
                                            txt: "5.0",
                                            type: TextTypes.f_11_500,
                                          ),
                                          padHorizontal(8),
                                          Container(
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              border: Border.all(
                                                color: AppColors.buttongroupBorder,
                                                width: 0.6,
                                              ),
                                            ),
                                          ),
                                          padHorizontal(8),
                                          const Label(
                                            txt: "Classic",
                                            type: TextTypes.f_11_500,
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.toggleLike(index);
                                        },
                                        child: Image.asset(
                                          width: 17,
                                          height: 17,
                                          controller.likeStatus[index] ? AppAssets.like : AppAssets.unlike,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  padVertical(5),
                                  const Divider(),
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
    );
  }
}