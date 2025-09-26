import 'package:get/get.dart';

import '../controllers/balance_controller.dart';
import '../controllers/language_options_controller.dart';

class LanguageOptionsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageOptionsController>(() => LanguageOptionsController());
  }
}
