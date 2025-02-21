import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgCartscreen extends StatefulWidget {
  const PgCartscreen({super.key});

  @override
  State<PgCartscreen> createState() => _PgCartscreenState();
}

class _PgCartscreenState extends State<PgCartscreen> {
  bool selLike = false;

  bool selLike2 = false;
  bool appplycoupn = false;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
          child: WidgetGlobalMargin(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          padVertical(10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Label(
              txt: AppLocalization.of(context).translate('cart'),
              type: TextTypes.f_20_500,
            ),
            const Icon(
              Icons.delete,
            ),
          ]),
          const Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Image.asset(
                                AppAssets.book,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        padHorizontal(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            padVertical(5),
                            const Label(
                              txt: "Carrie",
                              type: TextTypes.f_17_500,
                            ),
                            const Text(
                              'Stephen King',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: AppConst.fontFamily,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.resnd,
                                  color: AppColors.resnd),
                            ),
                            const Label(
                              txt: "Happy Life Publisher",
                              type: TextTypes.f_13_400,
                              forceColor: AppColors.resnd,
                            ),
                            padVertical(15),
                            const Label(
                              txt: "1000 ₸",
                              type: TextTypes.f_13_600,
                              forceColor: AppColors.resnd,
                            ),
                          ],
                        ),
                      ]),
                      Icon(Icons.delete)
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ))),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            appplycoupn
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: AppLocalization.of(context)
                                    .translate('entercopan'),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                hintStyle: const TextStyle(
                                  color: AppColors.inputBorder,
                                  fontFamily: AppConst.fontFamily,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
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
                                setState(() {
                                  appplycoupn = !appplycoupn;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        appplycoupn = !appplycoupn;
                      });
                    },
                    child: Text(
                      AppLocalization.of(context).translate('havecoupn'),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppConst.fontFamily,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor,
                        color: AppColors.primaryColor,
                      ),
                    )),
            padVertical(5),
            SizedBox(
              width: ScreenUtils.screenWidth(context) / 1.2, // Constrain width
              child: ElevatedButton(
                onPressed: () {
                  // Handle buy now button
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Label(
                      txt: AppLocalization.of(context).translate('paynow'),
                      type: TextTypes.f_17_500,
                      forceColor: AppColors.whiteColor,
                    ),
                    padHorizontal(15),
                    const Label(
                      txt: "2000 ₸",
                      type: TextTypes.f_17_500,
                      forceColor: AppColors.whiteColor,
                    ),
                  ],
                ),
              ),
            ),
            Label(
              txt: AppLocalization.of(context).translate('morecatalog'),
              type: TextTypes.f_17_500,
              forceColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
