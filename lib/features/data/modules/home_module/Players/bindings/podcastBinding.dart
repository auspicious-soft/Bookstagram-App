import 'package:bookstagram/features/data/modules/home_module/Players/controllers/podcast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/videoplayer_controller.dart';

class Podcastbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PodcastController>(() => PodcastController());
  }
}
