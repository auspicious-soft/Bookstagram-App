import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/components/label.dart';

import '../../../../../localization/app_localization.dart';
import '../controller/privacy_policy_controller.dart';

class PrivacyPolicyScreen extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Label(
          txt: controller.title.value == "privacyPolicy"
              ? AppLocalization.of(context).translate('privacypolicy')
              : controller.title.value,
          type: TextTypes.f_18_700,
          forceColor: AppColors.blackColor,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => controller.profileData.value?.data != null ||
                controller.profileData.value?.data?.isNotEmpty == true
            ? Html(
                data: controller.profileData.value?.data,
                style: {
                  "h2": Style(
                    fontSize: FontSize(24),
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                    margin: Margins(bottom: Margin(16)),
                  ),
                  "h3": Style(
                    fontSize: FontSize(20),
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                    margin: Margins(bottom: Margin(12), top: Margin(16)),
                  ),
                  "p": Style(
                    fontSize: FontSize(16),
                    color: AppColors.blackColor,
                    margin: Margins(bottom: Margin(12)),
                  ),
                  "li": Style(
                    fontSize: FontSize(16),
                    color: AppColors.blackColor,
                    margin: Margins(bottom: Margin(8)),
                  ),
                  "b": Style(
                    fontWeight: FontWeight.bold,
                  ),
                },
              )
            : SizedBox(
                height: Get.height * 0.5,
                child: Center(child: CircularProgressIndicator()))),
      ),
    );
  }
}
