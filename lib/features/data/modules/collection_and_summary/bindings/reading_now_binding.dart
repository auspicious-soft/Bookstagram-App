import 'package:get/get.dart';

import '../controller/reading_now_controller.dart';

class PgReadingBooksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgReadingBooksController>(() => PgReadingBooksController());
  }
}
