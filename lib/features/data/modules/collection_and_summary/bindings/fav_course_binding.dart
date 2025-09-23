import 'package:bookstagram/features/data/modules/collection_and_summary/controller/fav_courses_controller.dart';
import 'package:get/get.dart';

class FavCourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavCoursesController>(() => FavCoursesController());
  }
}
