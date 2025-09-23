import 'package:bookstagram/features/data/modules/home_module/Players/controllers/cart_controller.dart';
import 'package:bookstagram/features/data/modules/home_module/controller/profile_controller.dart';
import 'package:bookstagram/features/data/modules/home_module/controller/searchcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../collection_and_summary/controller/book_room_controller.dart';
import '../../collection_and_summary/view/book_room_screen.dart';
import '../Players/views/cart_view.dart';
import '../view/profile_screen.dart';
import '../view/search_screen.dart';
import '../view/tabhome_screen.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  var language = "";
  final PageController pageController = PageController(initialPage: 0);
  final cartController = Get.put(CartController());
  final settingController = Get.put(ProfileController());
  final bookSelf = Get.put(PgBookRoomController());

  List<Widget> get tabViews => const [
        TabhomeScreen(),
        PgTabsearch(),
        PgBookRoom(),
        CartView(),
        PgTabprofile(),
      ];

  void changeTab(int index) {
    final searchController = Get.put(TabSearchController());

    searchController.selectedIndex.value = 0;
    selectedIndex.value = index;
    pageController.jumpToPage(index);
    if (index == 3) {
      cartController.AddToCartApicall();
    }
    if (index == 4) {
      settingController.getProfileApiCall();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
