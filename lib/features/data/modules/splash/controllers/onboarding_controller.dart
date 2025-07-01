import 'package:get/get.dart';

class OnboardingController extends GetxController {


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
  // Navigation methods
  void navigateToLogin() {
   Get.toNamed("/login");
  }

  void navigateToSignup() {
   Get.toNamed("/signup");
  }
}