import 'package:bookstagram/Pages/AuthorDetail/pg_authordetail.dart';
import 'package:bookstagram/app_settings/components/common_authorsheet.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgAuthors extends StatefulWidget {
  const PgAuthors({super.key});

  @override
  State<PgAuthors> createState() => _PgAuthorsState();
}

class _PgAuthorsState extends State<PgAuthors> {
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
                    txt: AppLocalization.of(context).translate('Authors'),
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
                              builder: (context) => const PgAuthordetail(),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Image.asset(
                                AppAssets.book,
                                width: 85, // Ensure width and height are equal
                                height: 85,
                                fit: BoxFit
                                    .cover, // Cover ensures the image fills the circle
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
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: AppColors.whiteColor,
                    builder: (BuildContext context) {
                      return CommonAuthorsheet();
                    },
                  );
                },
                child: Center(
                    child: Container(
                        width: ScreenUtils.screenWidth(context) / 2.6,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.filter_alt_outlined,
                                color: AppColors.whiteColor,
                              ),
                              padHorizontal(20),
                              Label(
                                txt: AppLocalization.of(context)
                                    .translate('Filter'),
                                type: TextTypes.f_15_400,
                                forceColor: AppColors.whiteColor,
                              ),
                            ]))),
              ),
              padVertical(10),
            ],
          ),
        ),
      ),
    );
  }
}
