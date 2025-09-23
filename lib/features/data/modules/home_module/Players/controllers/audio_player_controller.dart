import 'dart:convert';
import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    show FlutterSecureStorage;
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../../bookstudy/controllers/book_market_controller.dart';
import '../../models/ReadProgressModel.dart';
import '../Models/BookChaptersModels.dart';

class AudioController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;
  var playbackSpeed = 1.0.obs;
  final Rx<AudioBookChapters?> audioChapters = Rx<AudioBookChapters?>(null);
  final Rx<progressReadResponseModel?> readProgress =
      Rx<progressReadResponseModel?>(null);
  var currentChapterIndex = 0.obs;
  String audioUrl = '';
  String AudioName = '';
  String Artist = '';
  String bookId = '';
  var Image = ''.obs;
  var isLoading = true.obs;
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
      bookId = Get.arguments["id"] ?? '';
      audioUrl = "${AppConfig.imgBaseUrl}${Get.arguments["audio"] ?? ''}";
      handelGetChapters();
      print('Initialized with audioUrl: $audioUrl');
    }
    _initAudioPlayer();
    setAudioSource();
  }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  Future<void> handelGetChapters() async {
    isLoading.value = true;
    try {
      var data = await GetAudioBookChapters();
      audioChapters.value = data;
      audioChapters.refresh();
      if (audioChapters.value?.data?.chapter?.isNotEmpty ?? false) {
        audioUrl =
            "${AppConfig.imgBaseUrl}${audioChapters.value!.data!.chapter![currentChapterIndex.value]?.file}";
        AudioName = audioChapters
                .value!.data!.chapter![currentChapterIndex.value].name ??
            '';
        setAudioSource();
      }
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<AudioBookChapters> GetAudioBookChapters() async {
    try {
      final token = await getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'role': 'admin',
        'x-client-type': 'mobile',
      };
      HttpWithMiddleware httpClient = HttpWithMiddleware.build(
        middlewares: [HttpLogger(logLevel: LogLevel.BODY)],
      );
      String selectedLanguage = Get.locale?.languageCode ?? "";
      String uri = selectedLanguage == "en"
          ? '${AppConfig.baseUrl}${"${AppConfig.AudioChapterEndPoints}/${bookId}/chapters?lang=eng"}'
          : selectedLanguage == "kk"
              ? '${AppConfig.baseUrl}${"${AppConfig.AudioChapterEndPoints}/${bookId}/chapters?lang=kaz"}'
              : '${AppConfig.baseUrl}${"${AppConfig.AudioChapterEndPoints}/${bookId}/chapters?lang=kaz"}';
      final response = await httpClient.get(Uri.parse(uri), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonBody = json.decode(response.body);
        return AudioBookChapters.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  void _initAudioPlayer() {
    _audioPlayer.setLoopMode(LoopMode.off);
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
    _audioPlayer.processingStateStream.listen((state) async {
      print('Processing state: $state');
      if (state == ProcessingState.completed) {
        isPlaying.value = false;
        position.value = Duration.zero;
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
        setAudioSource();
        await ReadProgress();
      }
    });
  }

  Future<void> ReadProgress() async {
    isLoading.value = true;
    try {
      var data = await postOrderBooks();
      readProgress.value = data;
      readProgress.refresh();
      handelGetChapters();
      Get.find<PgBookmarketController>().fetchBookStudy();
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, dynamic> getChapterProgress() {
    // Total number of chapters (hardcoded as per your requirement)
    int? totalChapters = audioChapters.value?.data?.chapter?.length ?? 0;

    // Current chapter index
    final int currentIndex = currentChapterIndex.value;

    // Calculate progress: ((currentIndex + 1) / totalChapters) * 100
    final double progress = ((currentIndex + 1) / totalChapters) * 100;

    // Get the chapter ID
    final String? chapterId =
        audioChapters.value?.data?.chapter?[currentIndex]?.sId;

    // Prepare JSON payload
    return {
      "progress": progress,
      "readAudioChapter": chapterId,
      // "voucherId": "6790d426454c2938059091bc" // Uncomment if needed
    };
  }

  Future<progressReadResponseModel> postOrderBooks() async {
    try {
      final token = await getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'role': 'admin',
        'x-client-type': 'mobile',
      };
      HttpWithMiddleware httpClient = HttpWithMiddleware.build(
        middlewares: [HttpLogger(logLevel: LogLevel.BODY)],
      );
      var totalSublessons = audioChapters?.value?.data?.chapter?.length;
      String uri = '${AppConfig.baseUrl}${AppConfig.CompeteLesson}/${bookId}';
      final response = await httpClient.put(Uri.parse(uri),
          headers: headers, body: jsonEncode(getChapterProgress()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonBody = json.decode(response.body);
        return progressReadResponseModel.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  Future<void> setAudioSource({int retryCount = 0}) async {
    try {
      isLoading.value = true;
      if (audioUrl.isEmpty) {
        Get.snackbar('Error', 'Audio URL is empty');
        print('Error: Audio URL is empty');
        isLoading.value = false;
        return;
      }

      print(
          'Attempting to set audio source: $audioUrl (Retry $retryCount/$maxRetries)');
      await _audioPlayer.setUrl(audioUrl);
      await _audioPlayer.setSpeed(playbackSpeed.value);
      await _audioPlayer.pause();
      print('Audio source set successfully: $audioUrl');
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('Error setting audio source: $e');
      if (retryCount < maxRetries &&
          e.toString().contains('Connection aborted')) {
        print('Retrying after delay...');
        await Future.delayed(retryDelay);
        await (workerCount: retryCount + 1);
        isLoading.value = false;
      } else {
        isLoading.value = false;
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

  void previousChapter() {
    if (currentChapterIndex.value > 0) {
      currentChapterIndex.value--;
      updateChapter();
    }
  }

  void nextChapter() {
    if (currentChapterIndex.value <
        (audioChapters.value?.data?.chapter?.length ?? 0) - 1) {
      currentChapterIndex.value++;
      updateChapter();
    }
  }

  void setChapter(int index) {
    currentChapterIndex.value = index;
    updateChapter();
  }

  void updateChapter() {
    final chapter =
        audioChapters.value?.data?.chapter?[currentChapterIndex.value];
    if (chapter != null) {
      audioUrl = "${AppConfig.imgBaseUrl}${chapter.file}";
      AudioName = chapter.name ?? '';
      setAudioSource();
      if (isPlaying.value) {
        play();
      }
    }
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
    print('AudioController closed');
  }
}
