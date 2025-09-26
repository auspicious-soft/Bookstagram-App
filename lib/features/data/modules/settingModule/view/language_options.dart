import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/language_options_controller.dart';
import '../controllers/level_controller.dart';

class LanguageOptions extends StatelessWidget {
  const LanguageOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageOptionsController controller =
        Get.find<LanguageOptionsController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: WidgetGlobalMargin(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                              .translate('languages'),
                          type: TextTypes.f_20_500,
                        ),
                        const Label(txt: "   ", type: TextTypes.f_20_500),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed("/interface_bindings");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Label(
                                txt: AppLocalization.of(context)
                                    .translate('Interface language'),
                                type: TextTypes.f_17_500,
                              ),
                            ]),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 18,
                            )
                          ],
                        )).marginSymmetric(horizontal: 10, vertical: 10),
                    Divider(
                      color: Colors.grey,
                    ).marginSymmetric(horizontal: 10),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed("/course-language");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Label(
                                txt: AppLocalization.of(context)
                                    .translate('Books/Courses languages'),
                                type: TextTypes.f_17_500,
                              ),
                            ]),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 18,
                            )
                          ],
                        )).marginSymmetric(horizontal: 10, vertical: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
