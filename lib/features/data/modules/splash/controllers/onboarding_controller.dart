import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  @override
  void onInit() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("$token>>>>>>>>>>>>>>>>>>>>>Token");
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
