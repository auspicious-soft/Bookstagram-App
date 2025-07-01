import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../../app_settings/components/widget_global_margin.dart';
import '../../../../../../app_settings/constants/app_config.dart';
import '../../../../../../app_settings/constants/app_dim.dart';
import '../controllers/audio_player_controller.dart';

class CommonAudioScreen extends StatelessWidget {
  const CommonAudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AudioController controller = Get.put(AudioController());
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
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
                Obx(() => Container(
                      height: ScreenUtils.screenHeight(context) / 2.3,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: controller.Image.value.isNotEmpty
                          ? Image.network(
                              "${AppConfig.imgBaseUrl}${controller.Image.value}",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                height: ScreenUtils.screenHeight(context) / 2.3,
                                AppAssets.book,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              AppAssets.book,
                              height: ScreenUtils.screenHeight(context) / 2.3,
                              fit: BoxFit.cover,
                            ),
                    )),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 15,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.whiteColor,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Label(
                        txt: 'Music Player',
                        type: TextTypes.f_20_500,
                        forceColor: AppColors.whiteColor,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.list,
                            color: AppColors.whiteColor,
                          ),
                          IconButton(
                            icon: Image.asset(
                              AppAssets.dots,
                              fit: BoxFit.contain,
                              width: 18,
                              height: 4,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 3,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 120,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.white.withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetGlobalMargin(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  padVertical(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Label(
                        txt: controller.AudioName.isNotEmpty
                            ? controller.AudioName
                            : 'Sample Track',
                        type: TextTypes.f_22_700,
                      ),
                      Text(
                        controller.Artist.isNotEmpty
                            ? controller.Artist
                            : 'Artist Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppConst.fontFamily,
                          color: AppColors.resnd,
                        ),
                      ),
                      Text(
                        'Publisher',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppConst.fontFamily,
                          decoration: TextDecoration.underline,
                          color: AppColors.resnd,
                        ),
                      ),
                    ],
                  ),
                  padVertical(25),
                  Obx(() {
                    final position = controller.position.value.inSeconds < 0
                        ? 0
                        : controller.position.value.inSeconds.toDouble();
                    final maxDuration =
                        controller.duration.value.inSeconds.toDouble() > 0
                            ? controller.duration.value.inSeconds.toDouble()
                            : 1.0;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Label(
                              txt: _formatDuration(controller.position.value),
                              type: TextTypes.f_13_400,
                              forceColor: AppColors.resnd,
                            ),
                            Label(
                              txt: _formatDuration(controller.duration.value),
                              type: TextTypes.f_13_400,
                              forceColor: AppColors.resnd,
                            ),
                          ],
                        ),
                        padVertical(15),
                        Slider(
                          activeColor: Colors.orange,
                          inactiveColor: Colors.grey,
                          value: position.toDouble(),
                          max: maxDuration,
                          onChanged: controller.duration.value.inSeconds > 0
                              ? (value) {
                                  controller
                                      .seek(Duration(seconds: value.toInt()));
                                }
                              : null,
                        ),
                        padVertical(10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.resnd.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton<double>(
                              value: controller.availableSpeeds
                                      .contains(controller.playbackSpeed.value)
                                  ? controller.playbackSpeed.value
                                  : controller.availableSpeeds[2],
                              underline: const SizedBox(),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.resnd,
                              ),
                              dropdownColor: AppColors.background,
                              items: controller.availableSpeeds
                                  .map((speed) => DropdownMenuItem(
                                        value: speed,
                                        child: Label(
                                          txt: '${speed}x',
                                          type: TextTypes.f_13_400,
                                          forceColor: AppColors.resnd,
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.setPlaybackSpeed(value);
                                }
                              },
                            ),
                          ),
                        ),
                        padVertical(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.replay_10,
                                size: 40,
                                color: AppColors.resnd,
                              ),
                              onPressed: () {
                                final newPosition = controller.position.value -
                                    const Duration(seconds: 10);
                                controller.seek(newPosition.inSeconds < 0
                                    ? Duration.zero
                                    : newPosition);
                              },
                            ),
                            padHorizontal(20),
                            IconButton(
                              icon: Icon(
                                controller.isPlaying.value
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_filled,
                                color: AppColors.primaryColor,
                                size: 70,
                              ),
                              onPressed: controller.duration.value.inSeconds > 0
                                  ? () {
                                      if (controller.isPlaying.value) {
                                        controller.pause();
                                      } else {
                                        controller.play();
                                      }
                                    }
                                  : null,
                            ),
                            padHorizontal(20),
                            IconButton(
                              icon: const Icon(
                                Icons.forward_10,
                                size: 40,
                                color: AppColors.resnd,
                              ),
                              onPressed: () {
                                final newPosition = controller.position.value +
                                    const Duration(seconds: 10);
                                if (newPosition >= controller.duration.value) {
                                  controller.seek(controller.duration.value);
                                  controller.pause();
                                  controller.seek(Duration.zero);
                                  controller.setAudioSource();
                                } else {
                                  controller.seek(newPosition);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
