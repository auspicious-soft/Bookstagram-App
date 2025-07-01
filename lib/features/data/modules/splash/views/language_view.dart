import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/language_controller.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.background, // Set status bar color
        statusBarIconBrightness:
        Brightness.dark, // Ensure icons are visible on white
      ),
    );
    return GetBuilder<LanguageController>(
      init: LanguageController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: WidgetGlobalMargin(
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.languages.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  const SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () =>
                                    {
                                      controller.changeLanguage(
                                          controller.languages[index]['code']),
                                      print("${controller.languages[index]['code']}>>>>>>>>>>>>>>>>>>")

                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      height: 67,
                                      decoration: BoxDecoration(
                                        color: controller.selectedLanguageCode ==
                                            controller.languages[index]['code']
                                            ? AppColors.selback
                                            : AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: AppColors.border,
                                          width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const SizedBox(width: 8),
                                              Label(
                                                txt: controller.languages[index]["title"],
                                                type: TextTypes.f_17_400,
                                              ),
                                            ],
                                          ),
                                          GetBuilder<LanguageController>(
                                            id: 'language_radio_$index',
                                            builder: (controller) {
                                              return Icon(
                                                controller.selectedLanguageCode ==
                                                    controller.languages[index]['code']
                                                    ? Icons.radio_button_checked_sharp
                                                    : Icons.radio_button_off,
                                                color: AppColors.primaryColor,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: commonButton(

                      arrow: true,
                      context: context,
                      onPressed: controller.navigateBack,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}