import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';

import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller/BookSchoolCongratsController.dart';

class BookschoolCongrats extends GetView<Bookschoolcongratscontroller> {
  const BookschoolCongrats({super.key});

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.background, // Set status bar color
        statusBarIconBrightness:
            Brightness.dark, // Ensure icons are visible on white
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppAssets.congrat,
                      fit: BoxFit.fill,
                      width: ScreenUtils.screenWidth(context),
                      height: ScreenUtils.screenHeight(context) / 1.8,
                    ).marginOnly(left: 20),
                    Column(
                      children: [
                        Label(
                          txt: AppLocalization.of(context)
                              .translate('Congratulations!'),
                          type: TextTypes.f_28_700,
                          forceAlignment: TextAlign.center,
                        ),
                        Label(
                          txt: AppLocalization.of(context).translate(
                              'Your coupon has been successfully activated'),
                          type: TextTypes.f_16_300,
                          maxLines: 10,
                          forceAlignment: TextAlign.center,
                        ).marginSymmetric(horizontal: 20),
                      ],
                    ),
                    padVertical(40),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            AppAssets.DonkeyRead,
                            fit: BoxFit.fill,
                            width: 50,
                            height: 50,
                          ).marginOnly(right: 20, bottom: 4),
                        ),
                        commonButton(
                          context: context,
                          onPressed: () {
                            Get.toNamed("/book-school-List");
                          },
                          txt: AppLocalization.of(context)
                              .translate('Go to catalog'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
