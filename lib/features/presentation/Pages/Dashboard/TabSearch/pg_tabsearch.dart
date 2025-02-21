import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';

class PgTabsearch extends StatefulWidget {
  const PgTabsearch({super.key});

  @override
  State<PgTabsearch> createState() => _PgTabsearchState();
}

class _PgTabsearchState extends State<PgTabsearch> {
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
                Center(
                    child: Label(
                        txt: AppLocalization.of(context).translate('Search'),
                        type: TextTypes.f_20_500)),
                padVertical(10),
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
                    ],
                  ),
                ),
                padVertical(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final screenWidth = constraints.maxWidth;
                        final tabWidth = screenWidth /
                            3.8; // Ensure the width is evenly divided
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
                                        padding: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          AppLocalization.of(context).translate(
                                            [
                                              AppLocalization.of(context)
                                                  .translate('Books'),
                                              AppLocalization.of(context)
                                                  .translate('Audiobooks'),
                                              AppLocalization.of(context)
                                                  .translate('Authors'),
                                              AppLocalization.of(context)
                                                  .translate('Courses'),
                                            ][index],
                                          ),
                                          style: TextStyle(
                                            fontFamily: AppConst.fontFamily,
                                            fontSize: 13.5,
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
                )
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     SingleChildScrollView(
                //       scrollDirection: Axis.horizontal,
                //       child: Row(
                //         children: [
                //           // First Tab
                //           GestureDetector(
                //             onTap: () => setState(() => selectedIndex = 0),
                //             child: Container(
                //               padding: const EdgeInsets.only(
                //                   bottom: 10, left: 16, right: 16),
                //               alignment: Alignment.center,
                //               child: Text(
                //                 AppLocalization.of(context).translate('Books'),
                //                 style: TextStyle(
                //                   fontFamily: AppConst.fontFamily,
                //                   fontSize: 17,
                //                   fontWeight: FontWeight.w500,
                //                   color: selectedIndex == 0
                //                       ? AppColors.primaryColor
                //                       : AppColors.blackColor,
                //                 ),
                //               ),
                //             ),
                //           ),
                //           // Second Tab
                //           GestureDetector(
                //             onTap: () => setState(() => selectedIndex = 1),
                //             child: Container(
                //               padding: const EdgeInsets.only(
                //                   bottom: 10, left: 16, right: 16),
                //               alignment: Alignment.center,
                //               child: Text(
                //                 AppLocalization.of(context)
                //                     .translate('Audiobooks'),
                //                 style: TextStyle(
                //                   fontFamily: AppConst.fontFamily,
                //                   fontSize: 17,
                //                   fontWeight: FontWeight.w500,
                //                   color: selectedIndex == 1
                //                       ? AppColors.primaryColor
                //                       : AppColors.blackColor,
                //                 ),
                //               ),
                //             ),
                //           ),
                //           // Third Tab
                //           GestureDetector(
                //             onTap: () => setState(() => selectedIndex = 2),
                //             child: Container(
                //               padding: const EdgeInsets.only(
                //                   bottom: 10, left: 16, right: 16),
                //               alignment: Alignment.center,
                //               child: Text(
                //                 AppLocalization.of(context)
                //                     .translate('Authors'),
                //                 style: TextStyle(
                //                   fontFamily: AppConst.fontFamily,
                //                   fontSize: 17,
                //                   fontWeight: FontWeight.w500,
                //                   color: selectedIndex == 2
                //                       ? AppColors.primaryColor
                //                       : AppColors.blackColor,
                //                 ),
                //               ),
                //             ),
                //           ),
                //           GestureDetector(
                //             onTap: () => setState(() => selectedIndex = 3),
                //             child: Container(
                //               padding: const EdgeInsets.only(
                //                   bottom: 10, left: 16, right: 16),
                //               alignment: Alignment.center,
                //               child: Text(
                //                 AppLocalization.of(context)
                //                     .translate('Courses'),
                //                 style: TextStyle(
                //                   fontFamily: AppConst.fontFamily,
                //                   fontSize: 17,
                //                   fontWeight: FontWeight.w500,
                //                   color: selectedIndex == 3
                //                       ? AppColors.primaryColor
                //                       : AppColors.blackColor,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     // Bottom Border line
                //     Stack(
                //       children: [
                //         Container(
                //           width: screenWidth,
                //           height: 2,
                //           color: Colors.grey.shade300,
                //         ),
                //         AnimatedPositioned(
                //           duration: const Duration(milliseconds: 300),
                //           left: selectedIndex * (screenWidth / 4),
                //           width: screenWidth / 4,
                //           height: 2,
                //           child: Container(color: AppColors.primaryColor),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ])))
            ]))));
  }
}
