import 'package:get/get.dart';

import '../controller/pg_certificate_controller.dart';

class PgCertificateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgCertificateController>(() => PgCertificateController());
  }
}
