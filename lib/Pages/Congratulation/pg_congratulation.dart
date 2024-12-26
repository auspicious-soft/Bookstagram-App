import 'package:bookstagram/Pages/SIgnUp/pg_signup.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgCongratulation extends StatefulWidget {
  const PgCongratulation({super.key});

  @override
  State<PgCongratulation> createState() => _PgCongratulationState();
}

class _PgCongratulationState extends State<PgCongratulation> {
  String otpCode = "";

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
            Image.asset(
              AppAssets.congrat,
              fit: BoxFit.fill,
              width: double.infinity,
              height: ScreenUtils.screenHeight(context) / 1.6,
            ),
            languageCode == 'kk'
                ? const Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Label(
                        txt: "Bookstagram",
                        type: TextTypes.f_32_500,
                        forceAlignment: TextAlign.center,
                        forceColor: AppColors.primaryColor,
                      ),
                      Label(
                        txt: "-ға қош",
                        type: TextTypes.f_32_500,
                        forceAlignment: TextAlign.center,
                      ),
                    ]),
                    Label(
                      txt: "келдіңіз! 🎉",
                      type: TextTypes.f_32_500,
                      forceAlignment: TextAlign.center,
                    ),
                  ])
                : Column(children: [
                    Label(
                      txt: AppLocalization.of(context).translate('welcometo'),
                      type: TextTypes.f_32_500,
                      forceAlignment: TextAlign.center,
                    ),
                    Label(
                      txt: AppLocalization.of(context).translate('bookstagram'),
                      type: TextTypes.f_32_500,
                      forceAlignment: TextAlign.center,
                      forceColor: AppColors.primaryColor,
                    ),
                  ]),
            padVertical(40),
            commonButton(
                context: context,
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PgSignup(),
                        ),
                      )
                    },
                txt: AppLocalization.of(context).translate('letgo')),
          ])))
        ],
      )),
    );
  }
}
