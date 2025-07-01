import 'package:bookstagram/features/data/datasources/user_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';

import '../../Splash/views/language_view.dart';

class SplashController extends GetxController {
  final UserStorage userStorage = UserStorage.con;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  @override
  void Close() {
    super.onClose();
  }


  Future checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      final token = await userStorage.getToken();
      print("Token: $token");

      if (token.isEmpty) {
        // Option 1: Using named route (make sure it's defined in GetMaterialApp)
        Get.offAllNamed('/language');

      } else {
  Get.offAllNamed("/dashboard");
      }
    } catch (e) {
      print("Error in checkAuthStatus: $e");
      // Fallback navigation
      Get.offAllNamed('/language');
    }
  }
}