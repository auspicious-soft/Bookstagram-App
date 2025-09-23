import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';

import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app_settings/components/loader.dart';
import '../../../../../app_settings/constants/app_config.dart';
import '../controllers/all_publisher_controller.dart';

class PgPublishers extends StatelessWidget {
  const PgPublishers({super.key});

  @override
  Widget build(BuildContext context) {
    final PublishersController controller = Get.find();
    getBookTitle({required dynamic name}) {
      const String defaultTitle = 'No Title';
      String selectedLanguage = Get.locale?.languageCode ?? "";

      if (name == null) return defaultTitle;

      try {
        switch (selectedLanguage) {
          case 'en':
            return name.eng != null ? name.eng : defaultTitle;
          case 'kk':
            return name.kaz != null ? name.kaz : defaultTitle;
          case 'ru':
            return name.rus != null ? name.rus : defaultTitle;
          default:
            return name.eng ?? name.kaz ?? name.rus ?? defaultTitle;
        }
      } catch (e) {
        print("Error in getBookTitle: $e");
        return defaultTitle;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: WidgetGlobalMargin(
          child: Obx(() => controller.isLoading.value == true
              ? Container(
                  height: Get.height,
                  width: Get.width,
                  child: Center(child: LoadingScreen()))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    padVertical(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.black),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        Label(
                          txt: AppLocalization.of(context)
                              .translate('Publishers'),
                          type: TextTypes.f_20_500,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.showFilterSheet(context);
                          },
                          child: Image.asset(
                            width: 16,
                            height: 20,
                            AppAssets.categoryfil,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    padVertical(10),
                    Obx(() {
                      if (controller.allPublishers.value == null ||
                          controller.allPublishers.value!.data == null ||
                          controller.allPublishers.value!.data!.isEmpty) {
                        return const Center(child: Text('No publishers found'));
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: controller.allPublishers.value!.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: controller.allPublishers.value!
                                              .data![index].image !=
                                          null
                                      ? Image.network(
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                          "${AppConfig.imgBaseUrl}${controller.allPublishers.value!.data![index].image}",
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                AppAssets.book,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              AppAssets.book,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                ),
                                padVertical(5),
                                Label(
                                  txt: getBookTitle(
                                      name: controller.allPublishers.value!
                                          .data![index].name),
                                  type: TextTypes.f_10_500,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  ],
                )),
        ),
      ),
    );
  }
}
