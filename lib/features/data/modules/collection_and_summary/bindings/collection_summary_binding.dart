import 'package:get/get.dart';

import '../controller/collection_summary_controller.dart';

class CollectionSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CollectionSummaryController>(
        () => CollectionSummaryController());
  }
}
