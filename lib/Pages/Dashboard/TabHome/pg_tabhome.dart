import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';

import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';

import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/localization/app_localization.dart';

import 'package:flutter/material.dart';

class PgTabhome extends StatefulWidget {
  const PgTabhome({super.key});

  @override
  State<PgTabhome> createState() => _PgTabhomeState();
}

class _PgTabhomeState extends State<PgTabhome> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
                padVertical(20),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Label(txt: "Hello,", type: TextTypes.f_20_700),
                        Label(
                          txt: "Duman!",
                          type: TextTypes.f_20_500i,
                          forceColor: AppColors.primaryColor,
                        )
                      ]),
                      Icon(Icons.notifications_none_outlined)
                    ]),
                padVertical(15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.purple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                                3.0), // Gradient border width
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white, // Inner background color
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Image.asset(
                                  AppAssets.congrat,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                padVertical(30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.border2,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        height: 20,
                        width: 20,
                        AppAssets.search,
                        fit: BoxFit.contain,
                      ),
                      padHorizontal(10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                AppLocalization.of(context).translate('search'),
                            hintStyle: const TextStyle(
                              color: AppColors.inputBorder,
                              fontFamily: AppConst.fontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontFamily: AppConst.fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      padHorizontal(10),
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          height: 20,
                          width: 20,
                          AppAssets.filter,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                padVertical(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                height: 35,
                                width: 35,
                                AppAssets.bookmarket,
                                fit: BoxFit.contain,
                              ),
                              Label(
                                  txt: AppLocalization.of(context)
                                      .translate('Bookmarket'),
                                  type: TextTypes.f_12_400)
                            ])),
                    Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                height: 25,
                                width: 25,
                                AppAssets.room,
                                fit: BoxFit.contain,
                              ),
                              padVertical(6),
                              Label(
                                  txt: AppLocalization.of(context)
                                      .translate('Bookroom'),
                                  type: TextTypes.f_12_400)
                            ])),
                    Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                height: 30,
                                width: 30,
                                AppAssets.school,
                                fit: BoxFit.contain,
                              ),
                              padVertical(5),
                              Label(
                                  txt: AppLocalization.of(context)
                                      .translate('Bookschool'),
                                  type: TextTypes.f_12_400)
                            ])),
                    Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                height: 35,
                                width: 40,
                                AppAssets.study,
                                fit: BoxFit.contain,
                              ),
                              Label(
                                  txt: AppLocalization.of(context)
                                      .translate('Bookstudy'),
                                  type: TextTypes.f_12_400)
                            ])),
                  ],
                ),
                padVertical(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 75,
                        width: 78,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                height: 35,
                                width: 35,
                                AppAssets.uni,
                                fit: BoxFit.contain,
                              ),
                              Label(
                                  txt: AppLocalization.of(context)
                                      .translate('Bookuniversity'),
                                  type: TextTypes.f_12_400)
                            ])),
                    Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              padVertical(7),
                              Image.asset(
                                height: 25,
                                width: 25,
                                AppAssets.master,
                                fit: BoxFit.contain,
                              ),
                              padVertical(6),
                              Label(
                                  txt: AppLocalization.of(context)
                                      .translate('Bookmasters'),
                                  type: TextTypes.f_12_400)
                            ])),
                    Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                height: 30,
                                width: 30,
                                AppAssets.event,
                                fit: BoxFit.contain,
                              ),
                              padVertical(5),
                              Label(
                                  txt: AppLocalization.of(context)
                                      .translate('Bookrvents'),
                                  type: TextTypes.f_12_400)
                            ])),
                    Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              padVertical(5),
                              Image.asset(
                                height: 28,
                                width: 28,
                                AppAssets.booklife,
                                fit: BoxFit.contain,
                              ),
                              padVertical(5),
                              Label(
                                  txt: AppLocalization.of(context)
                                      .translate('Booklife'),
                                  type: TextTypes.f_12_400)
                            ])),
                  ],
                ),
                padVertical(20),
                Image.asset(
                  AppAssets.banner,
                  fit: BoxFit.fill,
                ),
                padVertical(20),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedIndex = 0),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          child: Text(
                            '🔥${AppLocalization.of(context).translate('Stock')}',
                            style: TextStyle(
                              fontFamily: AppConst.fontFamily,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: selectedIndex == 0
                                  ? AppColors.primaryColor
                                  : AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedIndex = 1),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          child: Text(
                            '📚${AppLocalization.of(context).translate('Collections')}',
                            style: TextStyle(
                              fontFamily: AppConst.fontFamily,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: selectedIndex == 1
                                  ? AppColors.primaryColor
                                  : AppColors.buttongroupBorder,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Bottom Border line
                Stack(
                  children: [
                    Container(
                      width: screenWidth,
                      height: 2,
                      color: Colors.grey.shade300,
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      left: selectedIndex == 0 ? 0 : screenWidth / 2,
                      width: screenWidth / 2,
                      height: 2,
                      child: Container(color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ])))
            ]))));
  }
}
