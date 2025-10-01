// Binding: PgAuthordetailBinding.dart
import 'package:get/get.dart';

import '../controllers/CollectionSummaryBooksController.dart';
import '../controllers/Subcategories_books_controller.dart';
import '../controllers/teacher_detail_controller.dart';

class CollectionSummaryBooksBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Collectionsummarybookscontroller>(
        () => Collectionsummarybookscontroller());
  }
}
