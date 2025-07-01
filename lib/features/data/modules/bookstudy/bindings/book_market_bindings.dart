import 'package:get/get.dart';

import '../controllers/book_market_controller.dart';

class PgBookmarketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgBookmarketController>(() => PgBookmarketController());
  }
}
