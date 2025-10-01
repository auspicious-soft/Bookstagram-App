// Binding: PgAuthordetailBinding.dart
import 'package:get/get.dart';

import '../controllers/Subcategories_books_controller.dart';
import '../controllers/teacher_detail_controller.dart';

class Subcategoriesbooksbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubcategoriesBooksController>(
        () => SubcategoriesBooksController());
  }
}
