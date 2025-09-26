import 'package:get/get.dart';

import '../controllers/balance_controller.dart';
import '../controllers/course_language_controller.dart';
import '../controllers/interface_language_controllers.dart';
import '../controllers/language_options_controller.dart';

class CourseLanguageBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourseLanguageController>(() => CourseLanguageController());
  }
}
