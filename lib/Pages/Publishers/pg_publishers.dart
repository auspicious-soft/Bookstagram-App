import 'package:bookstagram/Pages/PublisherDetail/pg_publisherdetail.dart';
import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';

import 'package:bookstagram/app_settings/constants/app_dim.dart';

import 'package:bookstagram/localization/app_localization.dart';

import 'package:flutter/material.dart';

class PgPublishers extends StatefulWidget {
  const PgPublishers({super.key});

  @override
  State<PgPublishers> createState() => _PgPublishersState();
}

class _PgPublishersState extends State<PgPublishers> {
  int selectedIndex = 0;
  bool likeUnlike = false;
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
                      txt: AppLocalization.of(context).translate('Publishers'),
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
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PgPublisherdetail(),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
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
                              txt: "Құнанбайұлы",
                              type: TextTypes.f_10_500,
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
