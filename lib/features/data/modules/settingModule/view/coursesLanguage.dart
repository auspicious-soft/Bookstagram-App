import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../app_settings/components/loader.dart';
import '../../../../../localization/app_localization.dart';
import '../controllers/course_language_controller.dart';
import '../controllers/interface_language_controllers.dart';

class Courseslanguage extends StatelessWidget {
  const Courseslanguage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.background,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return GetBuilder<CourseLanguageController>(
      init: CourseLanguageController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: WidgetGlobalMargin(
              child: Obx(() => controller.isLoading.value == true
                  ? Container(
                      height: Get.height,
                      width: Get.width,
                      child: const Center(child: LoadingScreen()))
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            Label(
                              txt: AppLocalization.of(context)
                                  .translate('Books/Courses languages'),
                              type: TextTypes.f_20_500,
                            ),
                            const Label(txt: "   ", type: TextTypes.f_20_500),
                          ],
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Label(
                                  txt: AppLocalization.of(context)
                                      .translate('language will you read'),
                                  forceAlignment: TextAlign.center,
                                  type: TextTypes.f_20_700,
                                ),
                                Label(
                                  txt: AppLocalization.of(context)
                                      .translate("you can choose several"),
                                  type: TextTypes.f_15_300,
                                ).marginSymmetric(vertical: 10),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.languages.length,
                                  itemBuilder: (context, index) {
                                    return Obx(() => Column(
                                          children: [
                                            const SizedBox(height: 8),
                                            GestureDetector(
                                              onTap: () => controller
                                                  .toggleLanguage(controller
                                                          .languages[index]
                                                      ['code']),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                height: 67,
                                                decoration: BoxDecoration(
                                                  color: controller
                                                          .selectedLanguageCodes
                                                          .contains(controller
                                                                  .languages[
                                                              index]['code'])
                                                      ? AppColors.selback
                                                      : AppColors.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                    color: AppColors.border,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const SizedBox(
                                                            width: 8),
                                                        Label(
                                                          txt: controller
                                                                  .languages[
                                                              index]["title"],
                                                          type: TextTypes
                                                              .f_17_400,
                                                        ),
                                                      ],
                                                    ),
                                                    GetBuilder<
                                                        CourseLanguageController>(
                                                      id: 'language_check_$index',
                                                      builder: (controller) {
                                                        return Icon(
                                                          controller.selectedLanguageCodes
                                                                  .contains(controller
                                                                              .languages[
                                                                          index]
                                                                      ['code'])
                                                              ? Icons.check_box
                                                              : Icons
                                                                  .check_box_outline_blank,
                                                          color: AppColors
                                                              .primaryColor,
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: commonButton(
                            arrow: false,
                            txt: AppLocalization.of(context).translate('save'),
                            context: context,
                            onPressed: controller.navigateBack,
                          ),
                        ),
                      ],
                    )),
            ),
          ),
        );
      },
    );
  }
}
