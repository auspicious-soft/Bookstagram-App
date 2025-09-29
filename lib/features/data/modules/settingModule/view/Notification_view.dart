import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app_settings/components/loader.dart';
import '../controllers/Notification_controller.dart';

class PgNotification extends GetView<PgNotificationController> {
  const PgNotification({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScrollController for infinite scrolling
    final ScrollController scrollController = ScrollController();

    // Add listener for infinite scrolling
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels >=
    //       scrollController.position.maxScrollExtent - 200 &&
    //       !controller.isLoadingMore.value) {
    //     debugPrint('Reached end of list, loading more...');
    //     controller.loadMoreNotifications();
    //   }
    // });

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
                  GestureDetector(
                    onTap: () {
                      controller.MarkAllApiCall();
                    },
                    child: Image.asset(
                      AppAssets.markall,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? Container(
                          height: Get.height,
                          width: Get.width,
                          child: const Center(child: LoadingScreen()),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            debugPrint('Pull-to-refresh triggered');
                            await controller.getNoticationApiCall();
                          },
                          color: AppColors.primaryColor ?? Colors.blue,
                          backgroundColor: AppColors.whiteColor,
                          displacement: 20,
                          strokeWidth: 3,
                          child: ListView.builder(
                            controller: scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount:
                                controller.proileData.value?.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              final notification =
                                  controller.proileData.value!.data![index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: notification.isRead == false
                                        ? const Color.fromRGBO(239, 209, 196, 1)
                                        : AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.border,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Label(
                                        txt: notification.title ?? "",
                                        type: TextTypes.f_16_500,
                                      ),
                                      Label(
                                        txt: notification.description ?? "",
                                        type: TextTypes.f_10_500,
                                        forceColor: AppColors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ).marginSymmetric(vertical: 10),
              ),
              // Loading indicator for infinite scrolling
              // Obx(
              //       () => controller.isLoadingMore.value
              //       ? const Padding(
              //     padding: EdgeInsets.all(10),
              //     child: Center(child: CircularProgressIndicator()),
              //   )
              //       : const SizedBox.shrink(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
