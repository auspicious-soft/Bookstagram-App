import 'package:get/get.dart';

import '../controller/completed_books_controller.dart';

class CompletedBooksBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompletedBooksController>(() => CompletedBooksController());
  }
}
