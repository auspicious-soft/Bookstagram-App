
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/audio_player_controller.dart';




class AudioPlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioController>(() => AudioController());

  }
}
