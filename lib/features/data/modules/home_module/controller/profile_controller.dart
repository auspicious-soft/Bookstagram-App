import 'package:get/get.dart';

import '../../../datasources/user_storage.dart';

class ProfileController extends GetxController {
  var isSwitched = true.obs;

  void toggleSwitch(bool value) {
    isSwitched.value = value;
  }

  void logout() {
    print("Logout");
    UserStorage().deleteToken();
    Get.snackbar("Success", "Logout Successfully");
    Get.offAllNamed("/login");
  }
}
