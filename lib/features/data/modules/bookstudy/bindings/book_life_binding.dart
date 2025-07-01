import 'package:bookstagram/features/data/modules/bookstudy/controllers/book_life_controller.dart';
import 'package:get/get.dart';

import '../controllers/book_event_controller.dart';

class BookLifeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookLifeController>(() => BookLifeController());
  }
}
