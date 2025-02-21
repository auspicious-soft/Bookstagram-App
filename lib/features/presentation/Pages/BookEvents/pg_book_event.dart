import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/features/presentation/Pages/EventDetail/pg_event_detail.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgBookEvent extends StatefulWidget {
  const PgBookEvent({super.key});

  @override
  State<PgBookEvent> createState() => _PgBookEventState();
}

class _PgBookEventState extends State<PgBookEvent> {
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
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                padVertical(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Label(
                        txt:
                            AppLocalization.of(context).translate('Bookrvents'),
                        type: TextTypes.f_20_500),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: AppColors.whiteColor,
                          builder: (BuildContext context) {
                            return FilterBottomSheet();
                          },
                        );
                      },
                      child: Image.asset(
                        width: 16,
                        height: 20,
                        AppAssets.categoryfil,
                        fit: BoxFit.contain,
                      ),
                    )
                  ],
                ),
                padVertical(10),
                Column(
                  children: List.generate(3, (index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PgEventDetail(),
                            ),
                          );
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(right: 10, top: 10),
                            child: Column(children: [
                              padVertical(5),
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              AppAssets.book,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  padHorizontal(10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      padVertical(5),
                                      SizedBox(
                                          width:
                                              ScreenUtils.screenWidth(context) /
                                                  1.8,
                                          child: const Label(
                                            txt: "How to understand AI?",
                                            type: TextTypes.f_22_700,
                                          )),
                                      SizedBox(
                                        width:
                                            ScreenUtils.screenWidth(context) /
                                                1.8,
                                        child: const Label(
                                          txt:
                                              "15 қараша күні, сағат 15.00-де Алматы қаласында орналасқан...",
                                          type: TextTypes.f_13_400,
                                          forceColor: AppColors.resnd,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              padVertical(5),
                              const Divider()
                            ])));
                  }),
                ),
              ])))
            ]))));
  }
}
