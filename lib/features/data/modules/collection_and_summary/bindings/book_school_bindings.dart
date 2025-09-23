import 'package:get/get.dart';

import '../controller/book_school_controller.dart';

class PgBookSchoolBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgBookSchoolController>(() => PgBookSchoolController());
  }
}
