import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../presentation/Pages/Support/pg_support.dart';
import '../controller/book_school_controller.dart';

class PgBookSchool extends GetView<PgBookSchoolController> {
  const PgBookSchool({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Set status bar color
        statusBarIconBrightness:
            Brightness.dark, // Ensure icons are visible on white
      ),
    );
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
                      Get.back();
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
                      width: ScreenUtils.screenWidth(context) / 1.2,
                      child: Label(
                        txt: AppLocalization.of(context)
                            .translate('bookstagramlibrary'),
                        type: TextTypes.f_28_700,
                        forceAlignment: TextAlign.center,
                      ),
                    ),
                  ),
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
                        width: ScreenUtils.screenWidth(context) / 1.4,
                        child: Label(
                          txt: AppLocalization.of(context)
                              .translate('unlimitedlib'),
                          type: TextTypes.f_16_500,
                        ),
                      ),
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
                        width: ScreenUtils.screenWidth(context) / 1.4,
                        child: Label(
                          txt: AppLocalization.of(context)
                              .translate('accessallbook'),
                          type: TextTypes.f_16_500,
                        ),
                      ),
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
                        width: ScreenUtils.screenWidth(context) / 1.4,
                        child: Label(
                          txt: AppLocalization.of(context)
                              .translate('accessnewbook'),
                          type: TextTypes.f_16_500,
                        ),
                      ),
                    ],
                  ),
                  padVertical(20),
                  Label(
                    txt: AppLocalization.of(context)
                        .translate('bookstagramcollection'),
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
                        Expanded(
                          child: TextField(
                            controller: controller.schoolCodeController,
                            decoration: InputDecoration(
                              hintText: AppLocalization.of(context)
                                  .translate('enterschoolcode'),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              hintStyle: const TextStyle(
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
                          padding: const EdgeInsets.only(left: 15, right: 10),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: Obx(() => controller.isLoading.value == true
                              ? CircularProgressIndicator(
                                  color: AppColors.whiteColor,
                                )
                              : IconButton(
                                  icon: Image.asset(
                                    AppAssets.applycoup,
                                    fit: BoxFit.contain,
                                    width: 21,
                                    height: 21,
                                  ),
                                  onPressed: controller.toggleApplyCoupon,
                                )),
                        ),
                      ],
                    ),
                  ),
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
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: Label(
                              txt: AppLocalization.of(context)
                                  .translate('specialoffer'),
                              forceColor: AppColors.whiteColor,
                              type: TextTypes.f_11_500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Label(
                                txt: AppLocalization.of(context)
                                    .translate('leaverequest'),
                                type: TextTypes.f_15_400,
                                forceColor: AppColors.smallTxt,
                              ),
                              SizedBox(
                                width: ScreenUtils.screenWidth(context) / 1.8,
                                child: Label(
                                  txt: AppLocalization.of(context)
                                      .translate('connectschool'),
                                  type: TextTypes.f_16_500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        padVertical(10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.toNamed("/Support");
                  },
                  child: Container(
                    child: Label(
                      txt: AppLocalization.of(context)
                          .translate('School Conditions'),
                      type: TextTypes.f_16_300,
                      forceColor: AppColors.grey,
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.toNamed("/Support", arguments: {'initialTabIndex': 1});
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         const PgSupport(initialTabIndex: 1),
                    //   ),
                    // );
                  },
                  child: Label(
                    txt: AppLocalization.of(context)
                        .translate('School Get a consultation'),
                    type: TextTypes.f_16_300,
                    forceColor: AppColors.grey,
                  ),
                ),
              ],
            ).marginSymmetric(horizontal: 20, vertical: 40)
          ],
        ),
      ),
    );
  }
}
