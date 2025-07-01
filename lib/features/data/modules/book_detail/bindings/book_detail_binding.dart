import 'package:get/get.dart';

import '../controller/bookdetail.controller.dart';

class PgBookViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgBookViewController>(() => PgBookViewController());
  }
}
