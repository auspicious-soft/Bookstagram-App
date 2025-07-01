import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  late BetterPlayerController betterPlayerController;
  var isInitialized = false.obs;
  var isPlaying = false.obs;

  // Static video URL
  static const String videoUrl =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4";

  void initialize() {
    // Configure BetterPlayerDataSource
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      videoUrl,
      // Optional: Add headers, caching, or other configurations
      // headers: {'key': 'value'},
      // cacheConfiguration: BetterPlayerCacheConfiguration(...),
    );

    // Configure BetterPlayerController
    betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: true, // Auto-play on initialization
        aspectRatio: 16 / 9, // Match the widget's aspect ratio
        fit: BoxFit.contain,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableFullscreen: true,
          enablePlayPause: true,
          enableMute: true,
          enableProgressBar: true,
          enableSkips: false, // Customize as needed
        ),
      ),
      betterPlayerDataSource: dataSource,
    );

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
