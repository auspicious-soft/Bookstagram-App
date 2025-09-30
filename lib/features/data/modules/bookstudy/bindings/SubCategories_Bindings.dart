import 'package:get/get.dart';

import '../controllers/SubCategories_Controller.dart';
import '../controllers/categories_controller.dart';

class SubcategoriesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubcategoriesController>(() => SubcategoriesController());
  }
}
