import 'package:get/get.dart';

import '../controller/BookSchoolCongratsController.dart';

class BookSchoolCongratsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Bookschoolcongratscontroller>(
        () => Bookschoolcongratscontroller());
  }
}
