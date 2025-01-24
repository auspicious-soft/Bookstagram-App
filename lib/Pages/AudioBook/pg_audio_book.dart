import 'package:bookstagram/Pages/AudioBook/Widgets/custom_progressbar.dart';
import 'package:bookstagram/Pages/AuthorDetail/pg_authordetail.dart';
import 'package:bookstagram/Pages/Cart/pg_cartscreen.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/review_sheet.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgAudioBook extends StatefulWidget {
  const PgAudioBook({super.key});

  @override
  State<PgAudioBook> createState() => _PgAudioBookState();
}

class _PgAudioBookState extends State<PgAudioBook> {
  bool selLike = false;

  bool selLike2 = false;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  AppAssets.banner,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: ScreenUtils.screenHeight(context) / 2.3,
                ),
                Positioned(
                    top: MediaQuery.of(context).padding.top + 15,
                    left: 0,
                    right: 0,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              color: AppColors.whiteColor,
                              Icons.arrow_back_ios,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Label(
                            txt: AppLocalization.of(context)
                                .translate('audiobook'),
                            type: TextTypes.f_20_500,
                            forceColor: AppColors.whiteColor,
                          ),
                          Row(children: [
                            const Icon(
                              Icons.list,
                              color: AppColors.whiteColor,
                            ),
                            IconButton(
                              icon: Image.asset(
                                AppAssets.dots,
                                fit: BoxFit.contain,
                                width: 18,
                                height: 4,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ])
                        ])),
                Positioned(
                  top: MediaQuery.of(context).size.height / 3,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 120,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.white.withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetGlobalMargin(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                padVertical(10),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Label(
                                txt: "Жүректің көзі ашылса...",
                                type: TextTypes.f_22_700),
                            Text(
                              'Абай Құнанбайұлы',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppConst.fontFamily,
                                  color: AppColors.resnd),
                            ),
                            Text(
                              'Абай баспасы',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppConst.fontFamily,
                                  decoration: TextDecoration.underline,
                                  color: AppColors.resnd),
                            ),
                          ]),
                    ]),
                padVertical(25),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Label(
                        txt: "00:50",
                        type: TextTypes.f_13_400,
                        forceColor: AppColors.resnd,
                      ),
                      Label(
                        txt: "04:00",
                        type: TextTypes.f_13_400,
                        forceColor: AppColors.resnd,
                      )
                    ],
                  ),
                  padVertical(15),
                  const CustomProgressBar(progress: 0.5),
                  padVertical(10),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Label(
                      txt: "1Х",
                      type: TextTypes.f_13_400,
                      forceColor: AppColors.resnd,
                    ),
                  ),
                  padVertical(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.skip_previous_outlined,
                        size: 40,
                        color: AppColors.resnd,
                      ),
                      padHorizontal(20),
                      const Icon(
                        Icons.pause_circle_filled,
                        color: AppColors.primaryColor,
                        size: 70,
                      ),
                      padHorizontal(20),
                      const Icon(
                        Icons.skip_next_outlined,
                        size: 40,
                        color: AppColors.resnd,
                      )
                    ],
                  )
                ])
              ],
            ))
          ],
        ),
      ),
    );
  }
}
