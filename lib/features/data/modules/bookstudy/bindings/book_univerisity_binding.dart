import 'package:get/get.dart';

import '../controllers/book_university_controller.dart';
import '../controllers/bookstudy_home_controller.dart';

class BookUniverisityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookUniversityController>(() => BookUniversityController());
  }
}
