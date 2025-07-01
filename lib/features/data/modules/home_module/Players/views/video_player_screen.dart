import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/videoplayer_controller.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen();

  @override
  Widget build(BuildContext context) {
    // Initialize VideoController with the provided URL
    final VideoController controller = Get.put(VideoController());
    controller.initialize();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Video Player',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Obx(() {
          if (!controller.isInitialized.value) {
            return const CircularProgressIndicator();
          }
          return AspectRatio(
            aspectRatio: 16 / 9, // Standard video aspect ratio
            child: BetterPlayer(
              controller: controller.betterPlayerController,
            ),
          );
        }),
      ),
    );
  }
}
