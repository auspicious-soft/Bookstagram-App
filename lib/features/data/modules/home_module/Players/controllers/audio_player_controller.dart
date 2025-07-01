import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;
  var playbackSpeed = 1.0.obs;

  String audioUrl = '';
  String AudioName = '';
  String Artist = '';
  var Image = ''.obs;

  final List<double> availableSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      Artist = Get.arguments["artist"] ?? '';
      AudioName = Get.arguments["name"] ?? '';
      Image.value = Get.arguments["image"] ?? '';
      audioUrl = "${AppConfig.imgBaseUrl}${Get.arguments["audio"] ?? ''}";
      print('Initialized with audioUrl: $audioUrl');
    }
    _initAudioPlayer();
    setAudioSource();
  }

  void _initAudioPlayer() {
    _audioPlayer.setLoopMode(LoopMode.off); // Disable looping
    _audioPlayer.durationStream.listen((d) {
      duration.value = d ?? Duration.zero;
      print('Duration updated: ${duration.value}');
    });
    _audioPlayer.positionStream.listen((p) {
      position.value = p;
      print('Position updated: $p');
    });
    _audioPlayer.playingStream.listen((playing) {
      isPlaying.value = playing;
      print('Playing state: $playing');
    });
    _audioPlayer.speedStream.listen((speed) {
      playbackSpeed.value = speed;
      print('Playback speed: $speed');
    });
    _audioPlayer.processingStateStream.listen((state) {
      print('Processing state: $state');
      if (state == ProcessingState.completed) {
        isPlaying.value = false;
        position.value = Duration.zero; // Set time to 0
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause(); // Ensure paused
        setAudioSource(); // Reset audio source
      }
    });
  }

  Future<void> setAudioSource({int retryCount = 0}) async {
    try {
      if (audioUrl.isEmpty) {
        Get.snackbar('Error', 'Audio URL is empty');
        print('Error: Audio URL is empty');
        return;
      }

      print(
          'Attempting to set audio source: $audioUrl (Retry $retryCount/$maxRetries)');
      await _audioPlayer.setUrl(audioUrl);
      await _audioPlayer.setSpeed(playbackSpeed.value);
      await _audioPlayer.pause(); // Ensure paused state
      print('Audio source set successfully: $audioUrl');
    } catch (e) {
      print('Error setting audio source: $e');
      if (retryCount < maxRetries &&
          e.toString().contains('Connection aborted')) {
        print('Retrying after delay...');
        await Future.delayed(retryDelay);
        await setAudioSource(retryCount: retryCount + 1);
      } else {
        Get.snackbar('Error', 'Failed to load audio: $e');
      }
    }
  }

  Future<void> setPlaybackSpeed(double speed) async {
    try {
      await _audioPlayer.setSpeed(speed);
      playbackSpeed.value = speed;
      print('Playback speed set to: $speed');
    } catch (e) {
      Get.snackbar('Error', 'Failed to set playback speed: $e');
      print('Error setting playback speed: $e');
    }
  }

  void cyclePlaybackSpeed() {
    final currentIndex = availableSpeeds.indexOf(playbackSpeed.value);
    final nextIndex = (currentIndex + 1) % availableSpeeds.length;
    setPlaybackSpeed(availableSpeeds[nextIndex]);
  }

  Future<void> play() async {
    if (_audioPlayer.processingState == ProcessingState.completed) {
      await setAudioSource();
    }
    await _audioPlayer.play();
    print('Play triggered, state: ${_audioPlayer.processingState}');
  }

  void pause() {
    _audioPlayer.pause();
    print('Pause triggered');
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
    print('Seek to: $position');
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
    print('AudioController closed');
  }
}
