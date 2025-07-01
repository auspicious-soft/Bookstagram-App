// Binding: PgAuthordetailBinding.dart
import 'package:get/get.dart';

import '../controllers/teacher_detail_controller.dart';

class PgTeacherdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgTeacherProfileController>(() => PgTeacherProfileController());
  }
}
