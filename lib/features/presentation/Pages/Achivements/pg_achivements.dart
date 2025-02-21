import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';

import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/localization/app_localization.dart';

import 'package:flutter/material.dart';

class PgAchivements extends StatefulWidget {
  const PgAchivements({super.key});

  @override
  State<PgAchivements> createState() => _PgAchivementsState();
}

class _PgAchivementsState extends State<PgAchivements> {
  final List<Map<String, dynamic>> achievements = [
    {"title": "Achievement 1", "image": AppAssets.grade, "achieved": false},
    {"title": "Achievement 2", "image": AppAssets.grade, "achieved": false},
    {"title": "Achievement 3", "image": AppAssets.grade, "achieved": false},
    {"title": "Achievement 4", "image": AppAssets.grade, "achieved": false},
    {"title": "Achievement 5", "image": AppAssets.grade, "achieved": false},
    {"title": "Achievement 6", "image": AppAssets.grade, "achieved": false},
  ];

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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Label(
                          txt: AppLocalization.of(context)
                              .translate('yourgrade'),
                          type: TextTypes.f_20_500,
                        ),
                        const Label(txt: "   ", type: TextTypes.f_20_500),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                          itemCount: achievements.length,
                          itemBuilder: (context, index) {
                            final achievement = achievements[index];
                            return Column(
                              children: [
                                Opacity(
                                  opacity: achievement["achieved"] ? 1.0 : 0.3,
                                  child: Image.asset(
                                    achievement["image"],
                                    height: 95,
                                    width: 110,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                // const SizedBox(height: 5),
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
