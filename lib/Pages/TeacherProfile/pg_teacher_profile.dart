import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgTeacherProfile extends StatefulWidget {
  const PgTeacherProfile({super.key});

  @override
  State<PgTeacherProfile> createState() => _PgTeacherProfileState();
}

class _PgTeacherProfileState extends State<PgTeacherProfile> {
  bool selLike = false;

  bool selLike2 = false;

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
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Label(
                            txt: "Эмиль Афанов",
                            type: TextTypes.f_20_500,
                            forceColor: AppColors.whiteColor,
                          ),
                          IconButton(
                            icon: const Icon(Icons.file_upload_outlined,
                                color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
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
                padVertical(8),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Label(
                                txt: "Эмиль Афанов", type: TextTypes.f_22_700),
                            Text(
                              'Speaker',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppConst.fontFamily,
                                  decoration: TextDecoration.underline,
                                  color: AppColors.resnd),
                            ),
                          ]),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selLike = !selLike;
                          });
                        },
                        icon: Image.asset(
                          selLike ? AppAssets.liked : AppAssets.unliked,
                          fit: BoxFit.contain,
                          width: 52,
                          height: 52,
                        ),
                      )
                    ]),
                padVertical(8),
                Label(
                  txt: AppLocalization.of(context).translate('country'),
                  type: TextTypes.f_13_500,
                  forceColor: AppColors.resnd,
                ),
                const Label(
                  txt: "Kazakhstan",
                  type: TextTypes.f_17_500,
                ),
                padVertical(10),
                const Label(
                  txt:
                      "Қоғам қайраткері, қазақ ақыны, жазушы, лингвист-ғалым, Қазақ КСР Халық жазушысы (1990), Қазақстанның Еңбек Ері (2016)[1]. Халықаралық антиядролық қозғалысының негізін салушысы.",
                  type: TextTypes.f_16_500,
                  forceColor: AppColors.resnd,
                ),
                padVertical(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Label(
                      txt: AppLocalization.of(context).translate('readmore'),
                      type: TextTypes.f_15_400,
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 30,
                    )
                  ],
                ),
                padVertical(10),
                Label(
                  txt: AppLocalization.of(context).translate('Categories'),
                  type: TextTypes.f_15_500,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(3, (index) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              right: 12.0, top: 10, bottom: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Label(
                              txt: "🔍 Поэзия",
                              type: TextTypes.f_18_400,
                            ),
                          ));
                    }),
                  ),
                ),
                padVertical(20),
                GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Label(
                            txt: AppLocalization.of(context)
                                .translate('lecturecourses'),
                            type: TextTypes.f_15_500),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                        )
                      ],
                    )),
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
                                      ),
                                      const Label(
                                          txt: "5.0", type: TextTypes.f_11_500),
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
                                        decoration: TextDecoration.lineThrough,
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
                                ]))
                          ]),
                    );
                  }),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
