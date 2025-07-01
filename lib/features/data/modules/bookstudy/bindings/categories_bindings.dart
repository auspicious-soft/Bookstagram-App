import 'package:get/get.dart';

import '../controllers/categories_controller.dart';

class PgCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgCategoryController>(() => PgCategoryController());
  }
}
