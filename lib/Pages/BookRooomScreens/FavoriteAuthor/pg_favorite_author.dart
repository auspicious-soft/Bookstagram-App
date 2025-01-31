import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgFavoriteAuthor extends StatefulWidget {
  const PgFavoriteAuthor({super.key});

  @override
  State<PgFavoriteAuthor> createState() => _PgFavoriteAuthorState();
}

class _PgFavoriteAuthorState extends State<PgFavoriteAuthor> {
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
                        txt: AppLocalization.of(context)
                            .translate('favoriteauthors'),
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
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0, top: 10),
                      child: Dismissible(
                        key: Key(index.toString()), // Unique key for each item
                        direction:
                            DismissDirection.endToStart, // Swipe left to delete
                        background: Container(
                          color: AppColors.primaryColor,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          // Handle delete action here
                          print("Deleted author at index $index");
                        },
                        child: Column(
                          children: [
                            padVertical(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(55)),
                                    child: Center(
                                      child: Image.asset(
                                        width: 88,
                                        height: 88,
                                        AppAssets.book,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  padHorizontal(8),
                                  const Label(
                                    txt: "Жұмекен Нәжімеденов",
                                    type: TextTypes.f_16_500,
                                  ),
                                ]),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                )
                              ],
                            ),
                            padVertical(5),
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
