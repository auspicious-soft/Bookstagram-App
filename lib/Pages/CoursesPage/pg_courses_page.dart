import 'package:bookstagram/Pages/CourseDetail/pg_coursedetail.dart';
import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';

import 'package:bookstagram/app_settings/constants/app_dim.dart';

import 'package:flutter/material.dart';

class PgCoursesPage extends StatefulWidget {
  const PgCoursesPage({super.key});

  @override
  State<PgCoursesPage> createState() => _PgCoursesPageState();
}

class _PgCoursesPageState extends State<PgCoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: WidgetGlobalMargin(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              padVertical(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Label(txt: "➗ Math", type: TextTypes.f_20_500),
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
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PgCoursedetail(),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    width: double.infinity,
                                    height: 100,
                                    AppAssets.book,
                                    fit: BoxFit.fill,
                                  ),
                                  padVertical(5),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Label(
                                                  txt:
                                                      "Learn Figma from Scrat...",
                                                  type: TextTypes.f_10_500,
                                                  forceAlignment:
                                                      TextAlign.left,
                                                ),
                                                padVertical(5),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      size: 16,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    const Label(
                                                        txt: "5.0",
                                                        type:
                                                            TextTypes.f_11_500),
                                                    padHorizontal(8),
                                                    Container(
                                                      height: 12,
                                                      width: 1,
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .buttongroupBorder,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                      ),
                                                    ),
                                                    padHorizontal(8),
                                                    const Label(
                                                        txt: "Designe",
                                                        type:
                                                            TextTypes.f_11_500),
                                                  ],
                                                ),
                                              ]))),
                                ],
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
