import 'package:better_player_plus/better_player_plus.dart';
import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PodcastController extends GetxController {
  late BetterPlayerController betterPlayerController;
  var isInitialized = false.obs;
  var isPlaying = false.obs;
  String videoUrl = '';

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      videoUrl = await "${AppConfig.imgBaseUrl}${Get.arguments['url']}";
      print("videoUrl>>>>>>>>>>>>>>$videoUrl");
      initialize();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  void initialize() {
    // Configure BetterPlayerDataSource
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      videoUrl,
    );

    // Configure BetterPlayerController
    betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: true,
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableFullscreen: true,
          enablePlayPause: true,
          enableMute: true,
          enableProgressBarDrag: true,
          enableProgressBar: true,
          enableSkips: true,
        ),
      ),
      betterPlayerDataSource: dataSource,
    );

    // Handle empty or invalid video URL
    if (videoUrl.isEmpty || videoUrl == "no_video") {
      isInitialized.value = true;
      return;
    }

    // Listen to initialization and playback state
    betterPlayerController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
        isInitialized.value = true;
        isPlaying.value = betterPlayerController.isPlaying() ?? false;
      } else if (event.betterPlayerEventType == BetterPlayerEventType.play ||
          event.betterPlayerEventType == BetterPlayerEventType.pause) {
        isPlaying.value = betterPlayerController.isPlaying() ?? false;
      }
    });

    // Handle errors
    betterPlayerController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.exception) {
        Get.snackbar('Error', 'Failed to load video');
      }
    });
  }

  void play() => betterPlayerController.play();

  void pause() => betterPlayerController.pause();

  void togglePlay() {
    if (betterPlayerController.isPlaying() ?? false) {
      betterPlayerController.pause();
    } else {
      betterPlayerController.play();
    }
  }

  void toggleMute() {
    // if (betterPlayerController.isMuted() ?? false) {
    //   betterPlayerController.setVolume(1.0);
    // } else {
    //   betterPlayerController.setVolume(0.0);
    // }
  }

  void enterFullscreen() => betterPlayerController.enterFullScreen();

  void exitFullscreen() => betterPlayerController.exitFullScreen();

  @override
  void onClose() {
    betterPlayerController.dispose();
    super.onClose();
  }
}
