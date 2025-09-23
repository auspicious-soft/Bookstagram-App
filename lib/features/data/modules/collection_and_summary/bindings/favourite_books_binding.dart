import 'package:get/get.dart';

import '../controller/favorite_books_controller.dart';

class PgFavoriteBooksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgFavoriteBooksController>(() => PgFavoriteBooksController());
  }
}
