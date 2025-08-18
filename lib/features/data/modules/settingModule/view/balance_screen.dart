import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/features/presentation/Pages/TopUp/pg_top_up.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/balance_controller.dart';

class PgBalanceScreen extends GetView<PgBalanceScreenController> {
  const PgBalanceScreen({super.key});

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
                                .translate('balance'),
                            type: TextTypes.f_20_500,
                          ),
                          const Label(txt: "   ", type: TextTypes.f_20_500),
                        ],
                      ),
                      padVertical(20),
                      Center(
                        child: Stack(
                          children: [
                            Image.asset(
                              AppAssets.walletback,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 20,
                              left: 160,
                              child: Image.asset(
                                AppAssets.wallet,
                                width: 30,
                                height: 35,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: 55,
                              left: 145,
                              child: Obx(
                                () => Label(
                                  txt: '${controller.balance.value} ₸',
                                  type: TextTypes.f_36_700,
                                  forceColor: AppColors.whiteColor,
                                ),
                              ),
                            ),
                            padVertical(10),
                            Positioned(
                              bottom: 14,
                              left: 30,
                              right: 30,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.purple,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 40),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Obx(
                                      () => Label(
                                        txt: '${controller.cashback.value}',
                                        type: TextTypes.f_15_400,
                                        forceColor: AppColors.whiteColor,
                                      ),
                                    ),
                                    Label(
                                      txt: AppLocalization.of(context)
                                          .translate('cashback'),
                                      type: TextTypes.f_15_400,
                                      forceColor: AppColors.whiteColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      padVertical(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Label(
                            txt: AppLocalization.of(context)
                                .translate('history'),
                            type: TextTypes.f_16_700,
                          ),
                          const Icon(Icons.calendar_month_sharp),
                        ],
                      ),
                      padVertical(20),
                      Obx(
                        () => SingleChildScrollView(
                          child: Column(
                            children: controller.history.map((item) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Label(
                                            txt: item['name'],
                                            type: TextTypes.f_13_600,
                                          ),
                                          Label(
                                            txt: item['date'],
                                            type: TextTypes.f_12_400,
                                            forceColor: AppColors.grey,
                                          ),
                                        ],
                                      ),
                                      Label(
                                        txt: item['amount'],
                                        type: TextTypes.f_12_400,
                                        forceColor: AppColors.green,
                                      ),
                                    ],
                                  ),
                                  padVertical(10),
                                  const Divider(
                                    color: AppColors.divider,
                                    thickness: 2,
                                  ),
                                  padVertical(10),
                                ],
                              );
                            }).toList(),
                          ),
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
