import 'package:get/get.dart';

import '../controllers/level_controller.dart';

class PgAchievementsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgAchievementsController>(() => PgAchievementsController());
  }
}
