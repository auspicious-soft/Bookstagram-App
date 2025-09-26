import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app_settings/components/loader.dart';
import '../controllers/level_controller.dart';

class PgAchievements extends StatelessWidget {
  const PgAchievements({super.key});

  @override
  Widget build(BuildContext context) {
    final PgAchievementsController controller =
        Get.find<PgAchievementsController>();

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
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back),
                              ),
                              Label(
                                txt: AppLocalization.of(context)
                                    .translate('yourgrade'),
                                type: TextTypes.f_20_500,
                              ),
                              const Label(txt: "   ", type: TextTypes.f_20_500),
                            ],
                          ),
                          Expanded(
                            child: Obx(
                              () => SingleChildScrollView(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  reverse: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1,
                                  ),
                                  itemCount: controller.achievementsResponse
                                          .value?.data?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    final achievement = controller
                                        .achievementsResponse
                                        .value
                                        ?.data?[index];
                                    return Column(
                                      children: [
                                        Image.asset(
                                          achievement?.badge == "Saint"
                                              ? achievement?.achieved == false
                                                  ? AppAssets.Saintbadgeblank
                                                  : AppAssets.Saintbadge
                                              : achievement?.badge == "Hakim"
                                                  ? achievement?.achieved ==
                                                          false
                                                      ? AppAssets
                                                          .Hakimbadgeblank
                                                      : AppAssets.Hakimbadge
                                                  : achievement?.badge ==
                                                          "Genius"
                                                      ? achievement?.achieved ==
                                                              false
                                                          ? AppAssets
                                                              .Geniusbadgeblank
                                                          : AppAssets
                                                              .Geniusbadge
                                                      : achievement?.badge ==
                                                              "Teacher"
                                                          ? achievement
                                                                      ?.achieved ==
                                                                  false
                                                              ? AppAssets
                                                                  .Teacherbadgeblank
                                                              : AppAssets
                                                                  .Teacherbadge
                                                          : achievement
                                                                      ?.badge ==
                                                                  "Sufi"
                                                              ? achievement
                                                                          ?.achieved ==
                                                                      false
                                                                  ? AppAssets
                                                                      .Sufibadgeblank
                                                                  : AppAssets
                                                                      .Sufibadge
                                                              : achievement
                                                                          ?.badge ==
                                                                      "Expert"
                                                                  ? achievement
                                                                              ?.achieved ==
                                                                          false
                                                                      ? AppAssets
                                                                          .Expertbadgeblank
                                                                      : AppAssets
                                                                          .Expertbadge
                                                                  : achievement
                                                                              ?.badge ==
                                                                          "Commentator"
                                                                      ? achievement?.achieved ==
                                                                              false
                                                                          ? AppAssets
                                                                              .Commentatorbadgeblank
                                                                          : AppAssets
                                                                              .Commentatorbadge
                                                                      : achievement?.badge ==
                                                                              "Dervish"
                                                                          ? achievement?.achieved == false
                                                                              ? AppAssets.Expertbadgeblank
                                                                              : AppAssets.Derveshbadge
                                                                          : achievement?.badge == "Murid"
                                                                              ? achievement?.achieved == false
                                                                                  ? AppAssets.Expertbadgeblank
                                                                                  : AppAssets.Muridbadge
                                                                              : AppAssets.Expertbadgeblank,
                                          height: 100,
                                          width: 110,
                                          fit: BoxFit.contain,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
        ),
      ),
    );
  }
}
