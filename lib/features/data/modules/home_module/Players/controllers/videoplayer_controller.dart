import 'package:flick_video_player/flick_video_player.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late FlickManager flickManager;
  var isInitialized = false.obs;
  var isPlaying = false.obs;

  // Static video URL
  static const String videoUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4";
  // Initialize with the static video URL
  void initialize() {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(videoUrl))
        ..initialize().then((_) {
          isInitialized.value = true;
          isPlaying.value = true; // Auto-play on initialization
          flickManager.flickVideoManager?.videoPlayerController
              ?.addListener(() {
            isPlaying.value =
                flickManager.flickVideoManager?.videoPlayerController?.value.isPlaying ?? false;
          });
        }).catchError((error) {
          Get.snackbar('Error', 'Failed to load video: $error');
        }),
      autoPlay: true,
    );
  }

  void play() => flickManager.flickControlManager?.play();
  void pause() => flickManager.flickControlManager?.pause();
  void togglePlay() => flickManager.flickControlManager?.togglePlay();
  void toggleMute() => flickManager.flickControlManager?.toggleMute();
  void enterFullscreen() => flickManager.flickControlManager?.enterFullscreen();
  void exitFullscreen() => flickManager.flickControlManager?.exitFullscreen();

  @override
  void onClose() {
    flickManager.dispose();
    super.onClose();
  }
}