import 'package:get/get.dart';

import '../controllers/all_collection_controller.dart';


class CollectionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgCollectionsController>(() => PgCollectionsController());
  }
}