import 'package:get/get.dart';

import '../controller/book_room_controller.dart';

class PgBookRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgBookRoomController>(() => PgBookRoomController());
  }
}
