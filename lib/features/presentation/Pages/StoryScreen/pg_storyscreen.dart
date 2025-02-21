import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:flutter/material.dart';

class PgStoryscreen extends StatefulWidget {
  const PgStoryscreen({super.key});

  @override
  State<PgStoryscreen> createState() => _PgStoryscreenState();
}

class _PgStoryscreenState extends State<PgStoryscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.blackColor,
        body: SafeArea(
            child: WidgetGlobalMargin(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                padVertical(12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Background color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: List.generate(5, (index) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: index < 4 ? 4 : 0),
                          height: 4,
                          decoration: BoxDecoration(
                            color: index == 0
                                ? AppColors.whiteColor
                                : AppColors.inputBorder,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                padVertical(15),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                Center(
                    child: Image.asset(
                  AppAssets.book,
                  height: MediaQuery.of(context).size.height / 1.3,
                )),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.inputBorder,
                      width: 1,
                    ),
                  ),
                  child: const Center(
                    child: Label(
                      txt: "Follow",
                      type: TextTypes.f_17_700,
                      forceColor: Colors.white,
                    ),
                  ),
                )
              ])))
            ]))));
  }
}
