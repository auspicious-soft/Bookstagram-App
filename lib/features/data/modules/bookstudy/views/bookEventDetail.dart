import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:read_more_text/read_more_text.dart';

import '../../../../../app_settings/components/loader.dart';
import '../../../../../app_settings/constants/app_config.dart';
import '../../../../../app_settings/constants/app_dim.dart';
import '../controllers/bookEventDetail_controller.dart';

class PgEventDetail extends GetView<PgEventDetailController> {
  const PgEventDetail({super.key});

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
        child: Obx(
          () => controller.isLoading.value
              ? SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: const Center(child: LoadingScreen()),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        // Image container with gradient overlay
                        Container(
                          height: Get.height * 0.4,
                          width: Get.width,
                          child: Stack(
                            children: [
                              // Image
                              Container(
                                height: Get.height * 0.4,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        controller.eventdetail.value?.image !=
                                                null
                                            ? NetworkImage(
                                                "${AppConfig.imgBaseUrl}${controller.eventdetail.value?.image}",
                                              )
                                            : AssetImage(AppAssets.book),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Gradient overlay for smooth bottom fade
                              Container(
                                height: Get.height * 0.4,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.background.withOpacity(0.0),
                                      // Transparent at top
                                      AppColors.background.withOpacity(0.3),
                                      // Subtle fade
                                      AppColors.background.withOpacity(0.8),
                                      // Stronger fade
                                      AppColors.background,
                                      // Full background at bottom
                                    ],
                                    stops: const [0.0, 0.5, 0.8, 1.0],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Top navigation bar
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 15,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white),
                                onPressed: () => Get.back(),
                              ),
                              Obx(() => Label(
                                    txt: controller.eventdetail.value?.name ??
                                        "",
                                    type: TextTypes.f_20_500,
                                    forceColor: AppColors.whiteColor,
                                  )),
                              IconButton(
                                icon: const Icon(Icons.file_upload_outlined,
                                    color: Colors.white),
                                onPressed: () => Get.back(),
                              ),
                            ],
                          ),
                        ),
                        // Content below the image
                        Container(
                          margin: EdgeInsets.only(top: Get.height * 0.35),
                          // Adjusted to overlap slightly
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              padVertical(8),
                              Label(
                                txt: controller.eventdetail.value?.name ?? "",
                                type: TextTypes.f_22_700,
                              ),
                              padVertical(8),
                              Html(
                                style: {
                                  "body": Style(
                                    backgroundColor: Colors.transparent,
                                    color: Colors.black87,
                                    fontSize: FontSize.medium,
                                    padding:
                                        HtmlPaddings.symmetric(vertical: 10),
                                  ),
                                },
                                data: controller.eventdetail.value?.description,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
