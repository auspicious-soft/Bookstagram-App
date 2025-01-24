import 'package:bookstagram/Pages/TeacherProfile/pg_teacher_profile.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';

import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgTeachers extends StatefulWidget {
  const PgTeachers({super.key});

  @override
  State<PgTeachers> createState() => _PgTeachersState();
}

class _PgTeachersState extends State<PgTeachers> {
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
                  Label(
                    txt: AppLocalization.of(context).translate('teachers'),
                    type: TextTypes.f_20_500,
                  ),
                  const Label(txt: "   ", type: TextTypes.f_20_500),
                ],
              ),
              padVertical(10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PgTeacherProfile(),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Image.asset(
                                AppAssets.book,
                                width: 85,
                                height: 85,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // padVertical(5),
                            const Label(
                              txt: "Құнанбайұлы",
                              type: TextTypes.f_10_500,
                            ),
                          ],
                        ));
                  },
                ),
              ),
              padVertical(10),
            ],
          ),
        ),
      ),
    );
  }
}
