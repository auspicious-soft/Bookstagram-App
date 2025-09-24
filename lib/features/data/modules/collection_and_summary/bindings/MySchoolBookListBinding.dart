import 'package:get/get.dart';

import '../controller/MySchoolBookListConstroller.dart'
    show Myschoolbooklistconstroller;

class Myschoolbooklistbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Myschoolbooklistconstroller>(
        () => Myschoolbooklistconstroller());
  }
}
