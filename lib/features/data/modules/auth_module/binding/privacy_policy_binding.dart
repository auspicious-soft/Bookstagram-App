import 'package:get/get.dart';

import '../controller/privacy_policy_controller.dart';


class PrivacyPolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyPolicyController>(() => PrivacyPolicyController());
  }
}