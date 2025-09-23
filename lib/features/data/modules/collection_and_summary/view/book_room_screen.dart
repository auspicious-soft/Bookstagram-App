import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller/book_room_controller.dart';

class PgBookRoom extends GetView<PgBookRoomController> {
  const PgBookRoom({super.key});

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
                  AppAssets.bookroom,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                // Uncomment if you need a back button
                // Positioned(
                //   top: MediaQuery.of(context).padding.top + 15,
                //   left: 10,
                //   child: IconButton(
                //     icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                //     onPressed: () {
                //       Get.back();
                //     },
                //   ),
                // ),
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: controller.goToReadingBooks,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              AppAssets.read,
                              fit: BoxFit.contain,
                              width: 24,
                              height: 24,
                            ),
                            padHorizontal(15),
                            Label(
                              txt: AppLocalization.of(context)
                                  .translate('readingnow'),
                              type: TextTypes.f_22_400,
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  padVertical(40),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: controller.goToFavoriteBooks,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              AppAssets.unlike,
                              fit: BoxFit.contain,
                              width: 24,
                              height: 24,
                            ),
                            padHorizontal(15),
                            Label(
                              txt: AppLocalization.of(context)
                                  .translate('favoritebooks'),
                              type: TextTypes.f_22_400,
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  padVertical(40),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: controller.goToCompletedBooks,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              AppAssets.combook,
                              fit: BoxFit.contain,
                              width: 24,
                              height: 24,
                            ),
                            padHorizontal(15),
                            Label(
                              txt: AppLocalization.of(context)
                                  .translate('completedbooks'),
                              type: TextTypes.f_22_400,
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  padVertical(40),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: controller.goToFavoriteAuthors,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              AppAssets.favaut,
                              fit: BoxFit.contain,
                              width: 24,
                              height: 24,
                            ),
                            padHorizontal(15),
                            Label(
                              txt: AppLocalization.of(context)
                                  .translate('favoriteauthors'),
                              type: TextTypes.f_22_400,
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  // padVertical(40),
                  // GestureDetector(
                  //   behavior: HitTestBehavior.translucent,
                  //   onTap: controller.goToAudioPlayer,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Image.asset(
                  //             AppAssets.audio,
                  //             fit: BoxFit.contain,
                  //             width: 24,
                  //             height: 24,
                  //           ),
                  //           padHorizontal(15),
                  //           Label(
                  //             txt: AppLocalization.of(context)
                  //                 .translate('audioplayer'),
                  //             type: TextTypes.f_22_400,
                  //           ),
                  //         ],
                  //       ),
                  //       const Icon(
                  //         Icons.arrow_forward_ios_outlined,
                  //         size: 18,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  padVertical(40),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: controller.goToYourCourses,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              AppAssets.courseaudio,
                              fit: BoxFit.contain,
                              width: 24,
                              height: 24,
                            ),
                            padHorizontal(15),
                            Label(
                              txt: AppLocalization.of(context)
                                  .translate('yourcourses'),
                              type: TextTypes.f_22_400,
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
