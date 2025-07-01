import 'package:bookstagram/features/data/modules/auth_module/controller/congratulation_controller.dart';
import 'package:get/get.dart';


class CongratulationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CongratulationController>(() => CongratulationController());
  }
}