import 'package:get/get.dart';

import '../controllers/all_publisher_controller.dart';

class PublishersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublishersController>(() => PublishersController());
  }
}
