import 'package:get/get.dart';

import '../controllers/book_masters_controller.dart';

class BookMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookMastersController>(() => BookMastersController());
  }
}
