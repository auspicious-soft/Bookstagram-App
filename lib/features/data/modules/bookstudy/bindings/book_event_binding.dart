import 'package:get/get.dart';

import '../controllers/book_event_controller.dart';

class PgBookEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgBookEventController>(() => PgBookEventController());
  }
}
