import 'package:get/get.dart';

import '../controllers/Notification_controller.dart';

class PgNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgNotificationController>(() => PgNotificationController());
  }
}
