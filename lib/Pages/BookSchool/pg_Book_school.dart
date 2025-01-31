import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:flutter/material.dart';

class PgBookSchool extends StatefulWidget {
  const PgBookSchool({super.key});

  @override
  State<PgBookSchool> createState() => _PgBookSchoolState();
}

class _PgBookSchoolState extends State<PgBookSchool> {
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
                  AppAssets.bookschool,
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: SizedBox(
                            width: ScreenUtils.screenWidth(context) / 1.9,
                            child: const Label(
                              txt: "Bookstagram School Library",
                              type: TextTypes.f_28_700,
                              forceAlignment: TextAlign.center,
                            ))),
                    padVertical(20),
                    Row(
                      children: [
                        Image.asset(
                          AppAssets.infinity,
                          fit: BoxFit.contain,
                          width: 48,
                          height: 48,
                        ),
                        padHorizontal(20),
                        SizedBox(
                            width: ScreenUtils.screenWidth(context) / 1.5,
                            child: const Label(
                              txt:
                                  "unlimited annual library for school, college and university students",
                              type: TextTypes.f_16_500,
                            ))
                      ],
                    ),
                    padVertical(10),
                    Row(
                      children: [
                        Image.asset(
                          AppAssets.access,
                          fit: BoxFit.contain,
                          width: 48,
                          height: 48,
                        ),
                        padHorizontal(20),
                        SizedBox(
                            width: ScreenUtils.screenWidth(context) / 1.5,
                            child: const Label(
                              txt:
                                  "Access to all books for students of each school by a unique code",
                              type: TextTypes.f_16_500,
                            ))
                      ],
                    ),
                    padVertical(10),
                    Row(
                      children: [
                        Image.asset(
                          AppAssets.diamond,
                          fit: BoxFit.contain,
                          width: 48,
                          height: 48,
                        ),
                        padHorizontal(20),
                        SizedBox(
                            width: ScreenUtils.screenWidth(context) / 2,
                            child: const Label(
                              txt: "Access to new books and exclusive titles",
                              type: TextTypes.f_16_500,
                            ))
                      ],
                    ),
                    padVertical(20),
                    const Label(
                      txt:
                          "If your school is connected to the Bookstagram library, enter your school's special code and use the Bookstagram book collection",
                      type: TextTypes.f_15_300,
                    ),
                    padVertical(20),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Enter your school 's code...",
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  hintStyle: TextStyle(
                                    color: AppColors.buttongroupBorder,
                                    fontFamily: AppConst.fontFamily,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 10),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                              child: IconButton(
                                icon: Image.asset(
                                  AppAssets.applycoup,
                                  fit: BoxFit.contain,
                                  width: 21,
                                  height: 21,
                                ),
                                onPressed: () {
                                  // setState(() {
                                  //   appplycoupn = !appplycoupn;
                                  // });
                                },
                              ),
                            ),
                          ],
                        )),
                    padVertical(15),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(8)),
                                  ),
                                  child: const Label(
                                    txt: "special offer",
                                    forceColor: AppColors.whiteColor,
                                    type: TextTypes.f_11_500,
                                  ))),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 1),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Label(
                                      txt: "or leave a request to",
                                      type: TextTypes.f_15_400,
                                      forceColor: AppColors.smallTxt,
                                    ),
                                    SizedBox(
                                        width:
                                            ScreenUtils.screenWidth(context) /
                                                1.8,
                                        child: const Label(
                                          txt:
                                              "connect your school to the Bookstagram library ",
                                          type: TextTypes.f_16_500,
                                        )),
                                  ])),
                          padVertical(10)
                        ],
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
