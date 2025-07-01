import 'package:get/get.dart';

import '../controllers/bookstudy_home_controller.dart';


class PgBookstudyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgBookstudyController>(() => PgBookstudyController());
  }
}