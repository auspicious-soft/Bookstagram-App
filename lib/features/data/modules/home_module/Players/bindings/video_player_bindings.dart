
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/videoplayer_controller.dart';




class VideoPlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoController>(() => VideoController());

  }
}
