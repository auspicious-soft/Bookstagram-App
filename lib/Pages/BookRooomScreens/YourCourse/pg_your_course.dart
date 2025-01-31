import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgYourCourse extends StatefulWidget {
  const PgYourCourse({super.key});

  @override
  State<PgYourCourse> createState() => _PgYourCourseState();
}

class _PgYourCourseState extends State<PgYourCourse> {
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
                        txt: AppLocalization.of(context)
                            .translate('yourcourses'),
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
                        final tabWidth = screenWidth / 3;
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
                                              "Favorites",
                                              "Studying now",
                                              "Completed courses",
                                              "Certificates"
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
                if (selectedIndex == 0)
                  Column(
                    children: List.generate(2, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0, top: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 144,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Image.asset(
                                    AppAssets.book,
                                    fit: BoxFit.fill,
                                    height: 144,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              padVertical(5),
                              const Label(
                                  txt: "Learn Figma from Scratch",
                                  type: TextTypes.f_13_500),
                              padVertical(5),
                              SizedBox(
                                  // width: 240,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 16,
                                          color: AppColors.primaryColor,
                                        ),
                                        const Label(
                                            txt: "5.0",
                                            type: TextTypes.f_11_500),
                                        padHorizontal(8),
                                        Container(
                                          height: 12,
                                          width: 1,
                                          decoration: BoxDecoration(
                                            color: AppColors.buttongroupBorder,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        padHorizontal(8),
                                        const Label(
                                            txt: "Designe",
                                            type: TextTypes.f_11_500),
                                      ],
                                    ),
                                    Row(children: [
                                      const Text(
                                        "1670₸",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: AppConst.fontFamily,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationThickness: 2,
                                          decorationColor: AppColors.blackColor,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                      padHorizontal(8),
                                      const Label(
                                          txt: "990₸",
                                          forceColor: AppColors.primaryColor,
                                          type: TextTypes.f_11_500),
                                    ])
                                  ])),
                              padVertical(10),
                            ]),
                      );
                    }),
                  ),
                if (selectedIndex == 1)
                  Column(
                    children: List.generate(2, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Center(
                                  child: Image.asset(
                                    width: 80,
                                    height: 80,
                                    AppAssets.book,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              padHorizontal(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  padVertical(10),
                                  const Label(
                                      txt: "Course_title",
                                      type: TextTypes.f_15_500),
                                  const Label(
                                    txt: "Course_category",
                                    type: TextTypes.f_15_400,
                                    forceColor: AppColors.resnd,
                                  ),
                                  padVertical(5),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            ScreenUtils.screenWidth(context) /
                                                2.5,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: const LinearProgressIndicator(
                                            value: 0.73,
                                            backgroundColor:
                                                AppColors.inputBorder,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    AppColors.primaryColor),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Label(
                                        txt: "73%",
                                        type: TextTypes.f_12_400,
                                      ),
                                    ],
                                  ),
                                  padVertical(5),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                if (selectedIndex == 2)
                  Column(
                    children: List.generate(1, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Center(
                                  child: Image.asset(
                                    width: 80,
                                    height: 80,
                                    AppAssets.book,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              padHorizontal(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  padVertical(10),
                                  const Label(
                                      txt: "Course_title",
                                      type: TextTypes.f_15_500),
                                  const Label(
                                    txt: "Course_category",
                                    type: TextTypes.f_15_400,
                                    forceColor: AppColors.resnd,
                                  ),
                                  padVertical(5),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            ScreenUtils.screenWidth(context) /
                                                2.5,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: const LinearProgressIndicator(
                                            value: 100,
                                            backgroundColor:
                                                AppColors.inputBorder,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    AppColors.primaryColor),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Label(
                                        txt: "100%",
                                        type: TextTypes.f_12_400,
                                      ),
                                    ],
                                  ),
                                  padVertical(5),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
              ])))
            ]))));
  }
}
