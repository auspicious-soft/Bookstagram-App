import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app_settings/components/loader.dart';
import '../controller/pg_certificate_controller.dart';

class PgCertificate extends GetView<PgCertificateController> {
  const PgCertificate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
          child: WidgetGlobalMargin(
        child: Obx(
          () => controller.isLoading.value == true
              ? Container(
                  height: Get.height,
                  width: Get.width,
                  child: Center(child: LoadingScreen()))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios),
                                  onPressed: controller.goBack,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.file_upload_outlined),
                                  onPressed:
                                      controller.goBack, // Or custom action
                                ),
                              ],
                            ),
                            padVertical(12),
                            Obx(() => Image.network(
                                  "${AppConfig.imgBaseUrl}${controller.certificate.value?.data?.certificatePng}",
                                  fit: BoxFit.contain,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      )),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: controller.downloadCertificate,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(12),
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Label(
                txt: AppLocalization.of(context)
                    .translate('downloadcertificate'),
                type: TextTypes.f_17_500,
                forceColor: AppColors.whiteColor,
              ),
              padHorizontal(10),
              Icon(
                Icons.cloud_download_outlined,
                color: AppColors.whiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
