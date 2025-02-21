import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/features/presentation/Pages/BookLifeDetail/pg_book_life_detail.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgBookLife extends StatefulWidget {
  const PgBookLife({super.key});

  @override
  State<PgBookLife> createState() => _PgBookLifeState();
}

class _PgBookLifeState extends State<PgBookLife> {
  int selectedIndex = 0;
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
                            '💡 ${AppLocalization.of(context).translate('Booklife')}',
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
                padVertical(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final screenWidth = constraints.maxWidth;
                        final tabWidth = screenWidth /
                            3; // Ensure the width is evenly divided
                        return Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (int index = 0; index < 4; index++)
                                    GestureDetector(
                                      onTap: () =>
                                          setState(() => selectedIndex = index),
                                      child: Container(
                                        width: tabWidth,
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        alignment: Alignment.center,
                                        child: Text(
                                          AppLocalization.of(context).translate(
                                            [
                                              "Category 1",
                                              "Category 2",
                                              "Category 3",
                                              "Category 4"
                                            ][index],
                                          ),
                                          style: TextStyle(
                                            fontFamily: AppConst.fontFamily,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: selectedIndex == index
                                                ? AppColors.primaryColor
                                                : AppColors.blackColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: screenWidth,
                                  height: 2,
                                  color: Colors.grey.shade300,
                                ),
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 300),
                                  left: selectedIndex * tabWidth,
                                  width: tabWidth,
                                  height: 2,
                                  child:
                                      Container(color: AppColors.primaryColor),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                padVertical(10),
                Column(
                  children: List.generate(2, (index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PgBookLifeDetail(),
                            ),
                          );
                        },
                        child: Padding(
                            padding:
                                const EdgeInsets.only(right: 12.0, top: 10),
                            child: Column(children: [
                              padVertical(5),
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 98,
                                        width: 98,
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
                                        ),
                                      ),
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
