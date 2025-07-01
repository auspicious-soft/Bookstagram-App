import 'package:get/get.dart';

import '../controllers/categoryById_controller.dart';

class CategorybyidBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategorybyidController>(() => CategorybyidController());
  }
}
