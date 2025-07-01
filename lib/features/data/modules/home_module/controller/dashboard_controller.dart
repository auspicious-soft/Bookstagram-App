import 'package:bookstagram/features/data/modules/home_module/controller/searchcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../presentation/Pages/BookRooomScreens/BookRoom/pg_book_room.dart';
import '../../../../presentation/Pages/Cart/pg_cartscreen.dart';


import '../view/profile_screen.dart';
import '../view/search_screen.dart';
import '../view/tabhome_screen.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  var language="";
  final PageController pageController = PageController(initialPage: 0);

  List<Widget> get tabViews => const [
    TabhomeScreen(),
    PgTabsearch(),
    PgBookRoom(),
    PgCartscreen(),
    PgTabprofile(),
  ];

  void changeTab(int index) {
    final searchController = Get.put(TabSearchController());
    searchController.selectedIndex.value=0;
    selectedIndex.value = index;
    pageController.jumpToPage(index);
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


