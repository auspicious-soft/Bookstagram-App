import 'package:bookstagram/features/presentation/Pages/Category/pg_catergory.dart';
import 'package:bookstagram/features/presentation/Pages/CoursesPage/pg_courses_page.dart';
import 'package:bookstagram/features/presentation/Pages/Teachers/pg_teachers.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgBookMaster extends StatefulWidget {
  const PgBookMaster({super.key});

  @override
  State<PgBookMaster> createState() => _PgBookMasterState();
}

class _PgBookMasterState extends State<PgBookMaster> {
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
                  AppAssets.bookmaster,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 15,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 4.1,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Label(
                    txt: AppLocalization.of(context)
                        .translate('professionalslab'),
                    type: TextTypes.f_34_700,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(10),
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
                              hintText: AppLocalization.of(context)
                                  .translate('search'),
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
                  padVertical(15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PgCatergory(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Label(
                            txt: AppLocalization.of(context)
                                .translate('Categories'),
                            type: TextTypes.f_20_500),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                  padVertical(15),
                  _buildButtonGrid(),
                  padVertical(20),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PgTeachers(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Label(
                              txt: AppLocalization.of(context)
                                  .translate('Speakers'),
                              type: TextTypes.f_20_500),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                          )
                        ],
                      )),
                  padVertical(10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(6, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(55)),
                                  child: Center(
                                    child: Image.asset(
                                      width: 85,
                                      height: 85,
                                      AppAssets.book,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                padVertical(5),
                                const Label(
                                  txt: "Эмиль Апанов",
                                  type: TextTypes.f_13_500,
                                  forceAlignment: TextAlign.center,
                                ),
                              ]),
                        );
                      }),
                    ),
                  ),
                  padVertical(20),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PgCoursesPage(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Label(
                              txt: AppLocalization.of(context)
                                  .translate('popularlectures'),
                              type: TextTypes.f_20_500),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                          )
                        ],
                      )),
                  padVertical(15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(6, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 144,
                                  width: 246,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        AppAssets.book,
                                        fit: BoxFit.fill,
                                        height: 144,
                                        width: 246,
                                      ),
                                    ),
                                  ),
                                ),
                                padVertical(5),
                                const Label(
                                    txt: "Learn Figma from Scratch",
                                    type: TextTypes.f_13_500),
                                SizedBox(
                                    width: 240,
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
                                                  color: AppColors
                                                      .buttongroupBorder,
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
                                                decorationColor:
                                                    AppColors.blackColor,
                                                color: AppColors.blackColor,
                                              ),
                                            ),
                                            padHorizontal(8),
                                            const Label(
                                                txt: "990₸",
                                                forceColor:
                                                    AppColors.primaryColor,
                                                type: TextTypes.f_11_500),
                                          ])
                                        ]))
                              ]),
                        );
                      }),
                    ),
                  ),
                  padVertical(20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildButtonGrid() {
  final List<Map<String, dynamic>> items = [
    {'label': '📋 Расказы'},
    {'label': '👤 Биография'},
    {'label': '🌍 География'},
    {'label': '🏛 Тарих'},
    {'label': '✨ Физика'},
  ];

  return Wrap(
    // alignment: WrapAlignment.center,
    spacing: 6.0,
    runSpacing: 10.0,
    children: items.map((item) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
        child: Label(
          txt: item['label'],
          type: TextTypes.f_18_400,
        ),
      );
    }).toList(),
  );
}
