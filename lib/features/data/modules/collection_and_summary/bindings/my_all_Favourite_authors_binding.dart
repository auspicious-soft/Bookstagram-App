import 'package:bookstagram/features/data/modules/collection_and_summary/controller/my_all_FavouriteAuthors_controller.dart';
import 'package:get/get.dart';

class MyFavoriteAuthorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyFavoriteAuthorController>(() => MyFavoriteAuthorController());
  }
}
