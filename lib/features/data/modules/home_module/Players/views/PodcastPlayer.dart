import 'package:better_player_plus/better_player_plus.dart';
import 'package:bookstagram/app_settings/components/loader.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/podcast_controller.dart';

class Podcastplayer extends StatelessWidget {
  const Podcastplayer({super.key});

  @override
  Widget build(BuildContext context) {
    final PodcastController controller = Get.put(PodcastController());

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        Get.delete<PodcastController>();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () => Get.back(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.file_upload_outlined),
                        onPressed: () {
                          // TODO: Implement share functionality
                          print('Share button tapped');
                        },
                      ),
                    ],
                  ).marginSymmetric(horizontal: 20),
                  padVertical(20),
                  if (controller.isInitialized.value)
                    Container(
                      width: Get.width,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: BetterPlayer(
                          controller: controller.betterPlayerController,
                        ),
                      ),
                    ).marginSymmetric(horizontal: 20)
                  else
                    Container(
                      height: Get.height * 0.8,
                      width: Get.width,
                      child: const Center(child: LoadingScreen()),
                    ),
                ],
              ).marginOnly(bottom: 30),
            ),
          ),
        ),
      ),
    );
  }
}
