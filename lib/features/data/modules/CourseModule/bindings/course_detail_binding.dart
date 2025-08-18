import 'package:get/get.dart';

import '../controller/course_page_detail_controller.dart';

class PgCoursedetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgCoursedetailController>(() => PgCoursedetailController());
  }
}
