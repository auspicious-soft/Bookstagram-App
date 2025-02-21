import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgTopUp extends StatefulWidget {
  const PgTopUp({super.key});

  @override
  State<PgTopUp> createState() => _PgTopUpState();
}

class _PgTopUpState extends State<PgTopUp> {
  String amount = "1000";

  // void _onKeyPressed(String value) {
  //   setState(() {
  //     if (value == "⌫") {
  //       if (amount.isNotEmpty) {
  //         amount = amount.substring(0, amount.length - 1);
  //       }
  //     } else {
  //       amount += value;
  //     }
  //   });
  // }

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
                      padVertical(10),
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
                                .translate('topwallet'),
                            type: TextTypes.f_20_500,
                          ),
                          const Label(txt: "   ", type: TextTypes.f_20_500),
                        ],
                      ),
                      padVertical(20),
                      Container(
                        padding: const EdgeInsets.all(15),
                        // height: 80,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: AppColors.border2),
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.whiteColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppAssets.card,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain,
                                ),
                                padHorizontal(10),
                                Label(
                                  txt: AppLocalization.of(context)
                                      .translate('Card'),
                                  type: TextTypes.f_15_400,
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 17,
                            )
                          ],
                        ),
                      ),
                      padVertical(10),
                      Container(
                        padding: const EdgeInsets.all(15),
                        // height: 80,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: AppColors.border2),
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.whiteColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppAssets.blance,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain,
                                  color: AppColors.primaryColor,
                                ),
                                padHorizontal(10),
                                Label(
                                  txt: AppLocalization.of(context)
                                      .translate('bookstagramwallet'),
                                  type: TextTypes.f_15_400,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      padVertical(20),
                      Label(
                        txt: AppLocalization.of(context)
                            .translate('refillamount'),
                        type: TextTypes.f_16_300,
                      ),
                      padVertical(20),
                      const Label(
                        txt: "1000",
                        type: TextTypes.f_70_700,
                      ),
                      padVertical(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.border2),
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.whiteColor),
                            child: const Label(
                              txt: "20 ₸",
                              type: TextTypes.f_15_400,
                            ),
                          ),
                          padHorizontal(10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.border2),
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.whiteColor),
                            child: const Label(
                              txt: "40 ₸",
                              type: TextTypes.f_15_400,
                            ),
                          ),
                          padHorizontal(10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.border2),
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.whiteColor),
                            child: const Label(
                              txt: "60 ₸",
                              type: TextTypes.f_15_400,
                            ),
                          ),
                        ],
                      ),
                      padVertical(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.border2),
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.whiteColor),
                            child: const Label(
                              txt: "100 ₸",
                              type: TextTypes.f_15_400,
                            ),
                          ),
                          padHorizontal(10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.border2),
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.whiteColor),
                            child: const Label(
                              txt: "2000 ₸",
                              type: TextTypes.f_15_400,
                            ),
                          ),
                          padHorizontal(10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.border2),
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.whiteColor),
                            child: const Label(
                              txt: "5000 ₸",
                              type: TextTypes.f_15_400,
                            ),
                          ),
                        ],
                      ),
                      padVertical(10),
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
