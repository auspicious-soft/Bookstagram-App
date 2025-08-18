import 'package:get/get.dart';
import '../controllers/edit_profile_controller.dart';

class PgEditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgEditProfileController>(() => PgEditProfileController());
  }
}
