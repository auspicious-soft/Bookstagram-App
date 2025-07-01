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
import '../controllers/categories_controller.dart';

class PgCategory extends GetView<PgCategoryController> {
  const PgCategory({super.key});

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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            padVertical(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios,
                                      color: Colors.black),
                                  onPressed: controller.goBack,
                                ),
                                Expanded(
                                  child: Container(
                                    width: Get.width * 0.85,
                                    child: Center(
                                      child: Label(
                                        txt: AppLocalization.of(context)
                                            .translate('Categories'),
                                        type: TextTypes.f_20_500,
                                      ),
                                    ),
                                  ),
                                ),
                                // GestureDetector(
                                //   onTap: controller.showFilterBottomSheet,
                                //   child: Image.asset(
                                //     width: 16,
                                //     height: 20,
                                //     AppAssets.categoryfil,
                                //     fit: BoxFit.contain,
                                //   ),
                                // ),
                              ],
                            ),
                            padVertical(10),
                            _buildButtonGrid(context),
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
                          txt: controller.getBookTitle(name: item.name ?? {}) ??
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
}
