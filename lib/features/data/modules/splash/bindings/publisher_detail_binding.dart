// Binding: PgAuthordetailBinding.dart
import 'package:get/get.dart';

import '../controllers/publisher_detail_controller.dart';

class PublisherDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublisherDetailController>(() => PublisherDetailController());
  }
}
