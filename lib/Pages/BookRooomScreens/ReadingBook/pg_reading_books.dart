import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgReadingBooks extends StatefulWidget {
  const PgReadingBooks({super.key});

  @override
  State<PgReadingBooks> createState() => _PgReadingBooksState();
}

class _PgReadingBooksState extends State<PgReadingBooks> {
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
                            AppLocalization.of(context).translate('readingnow'),
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
                  children: List.generate(2, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
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
                                  width: 113,
                                  height: 144,
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
                                    txt: "Алашқа", type: TextTypes.f_15_500),
                                const Label(
                                  txt: "Міржақып Дулатұлы",
                                  type: TextTypes.f_15_400,
                                  forceColor: AppColors.resnd,
                                ),
                                padVertical(15),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: ScreenUtils.screenWidth(context) /
                                          2.5,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
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
                                Row(children: [
                                  SizedBox(
                                      width:
                                          ScreenUtils.screenWidth(context) / 3,
                                      height: 38,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Label(
                                          txt: "Continue",
                                          type: TextTypes.f_13_400,
                                          forceColor: AppColors.whiteColor,
                                        ),
                                      )),
                                  padHorizontal(10),
                                  SizedBox(
                                      width: ScreenUtils.screenWidth(context) /
                                          5.5,
                                      height: 38,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: AppColors.finbtn,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Label(
                                          txt: "Finish",
                                          type: TextTypes.f_13_400,
                                          forceColor: AppColors.whiteColor,
                                        ),
                                      ))
                                ])
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
