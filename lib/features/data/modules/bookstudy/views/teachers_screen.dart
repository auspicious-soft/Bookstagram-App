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
import '../controllers/teachers_controller.dart';

class PgTeachers extends GetView<TeachersController> {
  const PgTeachers({super.key});

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
                    SizedBox(height: 10), // Replaced padVertical(10)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.black),
                          onPressed: () {
                            Get.back(); // Use GetX navigation
                          },
                        ),
                        Label(
                          txt:
                              AppLocalization.of(context).translate('teachers'),
                          type: TextTypes.f_20_500,
                        ),
                        const Label(txt: "   ", type: TextTypes.f_20_500),
                      ],
                    ),
                    SizedBox(height: 10), // Replaced padVertical(10)
                    Obx(() => _buildAuthorGrid(
                        controller.bookStudy.value?.data?.teachers ?? [])),
                    SizedBox(height: 10), // Replaced padVertical(10)
                  ],
                )),
        ),
      ),
    );
  }

  Widget _buildAuthorGrid(List authors) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: authors.length,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print("hello>>>>>>teachers>>>>>>${authors[index].sId}");
            Get.toNamed("/teacherDetail",
                arguments: {"teacherId": authors[index].sId});
          },
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: authors[index].image != null
                        ? Image.network(
                            height: 110,
                            width: 110,
                            "${AppConfig.imgBaseUrl}${authors[index].image}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                    height: 110,
                                    width: 110,
                                    AppAssets.book,
                                    fit: BoxFit.contain),
                          )
                        : Image.asset(
                            height: 110,
                            width: 110,
                            AppAssets.book,
                            fit: BoxFit.contain),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Label(
                  txt: controller.getBookTitle(name: authors[index].name),
                  type: TextTypes.f_13_500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
