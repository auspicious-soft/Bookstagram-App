import 'package:get/get.dart';

import '../controllers/bookEventDetail_controller.dart';

class PgEventDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgEventDetailController>(() => PgEventDetailController());
  }
}
