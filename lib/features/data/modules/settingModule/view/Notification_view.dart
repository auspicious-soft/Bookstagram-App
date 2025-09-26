import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/Notification_controller.dart';

class PgNotification extends GetView<PgNotificationController> {
  const PgNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: WidgetGlobalMargin(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                  ),
                  Label(
                    txt: AppLocalization.of(context).translate('notification'),
                    type: TextTypes.f_20_500,
                  ),
                  Image.asset(
                    AppAssets.markall,
                    height: 30,
                    width: 30,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      children: controller.notifications.map((notification) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: notification.isUnread
                                  ? const Color.fromRGBO(239, 209, 196, 1)
                                  : AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(width: 1, color: AppColors.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Label(
                                  txt: notification.title,
                                  type: TextTypes.f_16_500,
                                ),
                                Label(
                                  txt: notification.subtitle,
                                  type: TextTypes.f_10_500,
                                  forceColor: AppColors.grey,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ).marginSymmetric(vertical: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
