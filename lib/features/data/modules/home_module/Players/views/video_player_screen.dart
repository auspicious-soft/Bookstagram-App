import 'package:better_player_plus/better_player_plus.dart';
import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:read_more_text/read_more_text.dart' show ReadMoreText;
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../app_settings/components/label.dart';
import '../../../../../../app_settings/constants/app_colors.dart';
import '../../../../../../app_settings/constants/app_const.dart';
import '../../../../../../app_settings/constants/app_dim.dart';
import '../../../../../../localization/app_localization.dart';
import '../controllers/videoplayer_controller.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen();

  @override
  Widget build(BuildContext context) {
    final VideoController controller = Get.put(VideoController());

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // Set status bar color
        statusBarIconBrightness:
            Brightness.dark, // Ensure icons are visible on white
      ),
    );
    return WillPopScope(
      onWillPop: () async {
        // Delete the controller when leaving the screen
        Get.delete<VideoController>();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: GetBuilder<VideoController>(builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    if (!controller.isInitialized.value &&
                            controller.videoUrl.isEmpty == false ||
                        !controller.isInitialized.value &&
                            controller.videoUrl.isEmpty == "no_video") {
                      return Container(
                        height: Get.height * 0.8,
                        width: Get.width,
                        child: Align(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        ),
                      );
                    }
                    return Obx(() => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  IconButton(
                                    icon:
                                        const Icon(Icons.file_upload_outlined),
                                    onPressed: () {
                                      // Navigator.pop(context);
                                    },
                                  ),
                                ]),
                            controller.videoUrl.isEmpty == true ||
                                    controller.videoUrl == "no_video"
                                ? SizedBox()
                                : Container(
                                    width: Get.width,
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: BetterPlayer(
                                        controller:
                                            controller.betterPlayerController,
                                      ),
                                    ),
                                  ).marginOnly(top: 20, bottom: 20),
                            Label(
                              txt: controller
                                      .CourseLessonDetail
                                      .value
                                      ?.data
                                      ?.courseLessons?[controller.index.value]
                                      ?.subLessons?[controller.subindex.value]
                                      .name ??
                                  "",
                              type: TextTypes.f_22_700,
                            ),
                            padVertical(10),
                            ReadMoreText(
                              controller
                                      .CourseLessonDetail
                                      .value
                                      ?.data
                                      ?.courseLessons?[controller.index.value]
                                      ?.subLessons?[controller.subindex.value]
                                      ?.description ??
                                  "",
                              numLines: 3,
                              readMoreTextStyle: TextStyle(
                                color: AppColors.resnd,
                                fontFamily: AppConst.fontFamily,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              readMoreAlign: Alignment.center,
                              readMoreText: 'Read more',
                              readLessText: 'Read less',
                              readMoreIconColor: Colors.grey,
                              style: TextStyle(
                                color: AppColors.resnd,
                                fontFamily: AppConst.fontFamily,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            padVertical(20),
                            controller
                                        .CourseLessonDetail
                                        .value
                                        ?.data
                                        ?.courseLessons?[controller.index.value]
                                        ?.subLessons?[controller.subindex.value]
                                        ?.additionalFiles
                                        ?.length ==
                                    0
                                ? SizedBox()
                                : GestureDetector(
                                    onTap: () {
                                      controller.showAddtionalfiles.value =
                                          !controller.showAddtionalfiles.value;
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.file_copy_outlined,
                                          size: 20,
                                          color: AppColors.primaryColor,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Label(
                                          txt: AppLocalization.of(context)
                                              .translate('AddFiles'),
                                          type: TextTypes.f_15_400,
                                          forceColor: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                            Obx(
                              () => controller.showAddtionalfiles.value == false
                                  ? SizedBox()
                                  : Container(
                                      // Constrain height to avoid overflow
                                      child: Obx(() {
                                        final additionalFiles = controller
                                            .CourseLessonDetail
                                            .value
                                            ?.data
                                            ?.courseLessons?[
                                                controller.index.value]
                                            ?.subLessons?[
                                                controller.subindex.value]
                                            ?.additionalFiles;
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              additionalFiles?.length ?? 1,
                                          itemBuilder: (context, index) {
                                            if (additionalFiles == null ||
                                                additionalFiles.isEmpty) {
                                              return Label(
                                                txt: "No additional files",
                                                type: TextTypes.f_15_400,
                                                forceColor:
                                                    AppColors.primaryColor,
                                              );
                                            }
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Label(
                                                  txt: additionalFiles[index]
                                                          ?.name ??
                                                      "",
                                                  type: TextTypes.f_15_400,
                                                  forceColor:
                                                      AppColors.blackColor,
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    // Example URL, replace with your actual URL (e.g., from CourseLessonsModel)
                                                    final String url =
                                                        "${AppConfig.imgBaseUrl}${additionalFiles[index].file}";

                                                    // Check if the URL can be launched
                                                    if (await canLaunchUrl(
                                                        Uri.parse(url))) {
                                                      await launchUrl(
                                                          Uri.parse(url),
                                                          mode: LaunchMode
                                                              .externalApplication);
                                                    } else {
                                                      Get.snackbar('Error',
                                                          'Could not launch $url');
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.download_outlined,
                                                        color: AppColors
                                                            .whiteColor,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ).marginOnly(top: 10, left: 20);
                                          },
                                        );
                                      }),
                                    ),
                            ),
                            padVertical(20),
                            controller
                                        .CourseLessonDetail
                                        .value
                                        ?.data
                                        ?.courseLessons?[controller.index.value]
                                        ?.subLessons?[controller.subindex.value]
                                        ?.links
                                        ?.length ==
                                    0
                                ? SizedBox()
                                : GestureDetector(
                                    onTap: () {
                                      controller.showAddtionallinks.value =
                                          !controller.showAddtionallinks.value;
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.link,
                                          size: 20,
                                          color: AppColors.primaryColor,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Label(
                                          txt: AppLocalization.of(context)
                                              .translate('AddLinks'),
                                          type: TextTypes.f_15_400,
                                          forceColor: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                            Obx(
                              () => controller.showAddtionallinks.value == false
                                  ? SizedBox()
                                  : Container(
                                      // Constrain height to avoid overflow
                                      child: Obx(() {
                                        final additionalFiles = controller
                                            .CourseLessonDetail
                                            .value
                                            ?.data
                                            ?.courseLessons?[
                                                controller.index.value]
                                            ?.subLessons?[
                                                controller.subindex.value]
                                            ?.links;
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              additionalFiles?.length ?? 1,
                                          itemBuilder: (context, index) {
                                            if (additionalFiles == null ||
                                                additionalFiles.isEmpty) {
                                              return Label(
                                                txt: "No additional links",
                                                type: TextTypes.f_15_400,
                                                forceColor:
                                                    AppColors.primaryColor,
                                              );
                                            }
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    // Example URL, replace with your actual URL (e.g., from CourseLessonsModel)
                                                    final String url =
                                                        "${additionalFiles[index].url}";

                                                    // Check if the URL can be launched
                                                    if (await canLaunchUrl(
                                                        Uri.parse(url))) {
                                                      await launchUrl(
                                                          Uri.parse(url),
                                                          mode: LaunchMode
                                                              .inAppWebView);
                                                    }
                                                  },
                                                  child: Label(
                                                    txt: additionalFiles[index]
                                                            ?.name ??
                                                        "",
                                                    textDecoration:
                                                        TextDecoration
                                                            .underline,
                                                    type: TextTypes.f_15_400,
                                                    forceColor:
                                                        AppColors.primaryColor,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    // Example URL, replace with your actual URL (e.g., from CourseLessonsModel)
                                                    final String url =
                                                        "${additionalFiles[index].url}";

                                                    try {
                                                      // Copy the URL to the clipboard
                                                      await Clipboard.setData(
                                                          ClipboardData(
                                                              text: url));

                                                      // Show localized success message
                                                    } catch (e) {
                                                      // Show localized error message
                                                      Get.snackbar(
                                                        'Error',
                                                        'Failed to copy URL',
                                                      );
                                                      print(
                                                          "Clipboard error: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.copy,
                                                        color: AppColors
                                                            .whiteColor,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ).marginOnly(
                                                top: 10, left: 20, bottom: 30);
                                          },
                                        );
                                      }),
                                    ),
                            ),
                          ],
                        )).marginSymmetric(horizontal: 20);
                  }),
                ],
              ).marginOnly(bottom: 30),
            );
          }),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          color: Colors.white,
          child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: controller.isInitialized.value &&
                            controller.canGoToPrevious()
                        ? () {
                            controller.goToPrevious();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.whiteColor,
                      side: BorderSide(color: AppColors.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Label(
                      txt: AppLocalization.of(context).translate('Prev'),
                      type: TextTypes.f_17_500,
                      forceColor: AppColors.primaryColor,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: controller.isInitialized.value &&
                            controller.canGoToNext()
                        ? () {
                            controller.goToNext();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isInitialized.value &&
                              controller.canGoToNext()
                          ? AppColors.primaryColor
                          : AppColors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Label(
                      txt: AppLocalization.of(context).translate('Next'),
                      type: TextTypes.f_17_500,
                      forceColor: AppColors.whiteColor,
                    ).marginSymmetric(horizontal: 5, vertical: 5),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
