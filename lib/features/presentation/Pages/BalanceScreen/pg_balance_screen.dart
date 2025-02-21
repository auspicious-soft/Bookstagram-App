import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/features/presentation/Pages/TopUp/pg_top_up.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgBalanceScreen extends StatefulWidget {
  const PgBalanceScreen({super.key});

  @override
  State<PgBalanceScreen> createState() => _PgBalanceScreenState();
}

class _PgBalanceScreenState extends State<PgBalanceScreen> {
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
                            const Positioned(
                              top: 55,
                              left: 145,
                              child: Label(
                                txt: '0 ₸',
                                type: TextTypes.f_36_700,
                                forceColor: AppColors.whiteColor,
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PgTopUp(),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.add,
                                              color: Colors.white),
                                          Label(
                                            txt: AppLocalization.of(context)
                                                .translate('topup'),
                                            type: TextTypes.f_15_400,
                                            forceColor: AppColors.whiteColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 40,
                                      color: Colors.white,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Label(
                                          txt: '20',
                                          type: TextTypes.f_15_400,
                                          forceColor: AppColors.whiteColor,
                                        ),
                                        Label(
                                          txt: AppLocalization.of(context)
                                              .translate('cashback'),
                                          type: TextTypes.f_15_400,
                                          forceColor: AppColors.whiteColor,
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
                      padVertical(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Label(
                            txt: AppLocalization.of(context)
                                .translate('history'),
                            type: TextTypes.f_16_700,
                          ),
                          const Icon(Icons.calendar_month_sharp)
                        ],
                      ),
                      padVertical(20),
                      SingleChildScrollView(
                        child: Column(
                          children: List.generate(2, (index) {
                            return Column(
                              children: [
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Label(
                                          txt: 'Operation name',
                                          type: TextTypes.f_13_600,
                                        ),
                                        Label(
                                          txt: '19.11.2024 02:12',
                                          type: TextTypes.f_12_400,
                                          forceColor: AppColors.grey,
                                        ),
                                      ],
                                    ),
                                    Label(
                                      txt: '+35 ₸',
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
