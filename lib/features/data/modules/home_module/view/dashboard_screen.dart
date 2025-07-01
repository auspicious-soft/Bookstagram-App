import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../app_settings/components/label.dart';
import '../../../../../app_settings/constants/app_assets.dart';
import '../../../../../app_settings/constants/app_colors.dart';
import '../../../../../app_settings/constants/app_const.dart';
import '../../../../../app_settings/constants/app_dim.dart';
import '../../../../../localization/app_localization.dart';
import '../controller/dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final labelToAssetMap = {
      AppLocalization.of(context).translate('home'): AppAssets.home,
      AppLocalization.of(context).translate('Search'): AppAssets.search,
      AppLocalization.of(context).translate('Bookshelf'): AppAssets.bookself,
      AppLocalization.of(context).translate('Cart'): AppAssets.cart,
      AppLocalization.of(context).translate('Profile'): AppAssets.profile,
    };
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.background, // Set status bar color
        statusBarIconBrightness: Brightness.dark, // Ensure icons are visible on white
      ),
    );

    return Scaffold(
      body:PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: controller.tabViews,
      ),
      bottomNavigationBar: Obx(() => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTab,
          unselectedFontSize: 10,
          selectedFontSize: 10,
          unselectedLabelStyle:
          const TextStyle(fontFamily: AppConst.fontFamily),
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            _buildNavItem(AppLocalization.of(context).translate('home'), 0,
                labelToAssetMap),
            _buildNavItem(AppLocalization.of(context).translate('Search'), 1,
                labelToAssetMap),
            _buildNavItem(AppLocalization.of(context).translate('Bookshelf'), 2,
                labelToAssetMap),
            _buildNavItem(AppLocalization.of(context).translate('Cart'), 3,
                labelToAssetMap),
            _buildNavItem(AppLocalization.of(context).translate('Profile'), 4,
                labelToAssetMap),
          ],
        ),
      )),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      String label, int index, Map<String, String> labelToAssetMap) {
    bool isActive = controller.selectedIndex.value == index;

    return BottomNavigationBarItem(
      icon: SizedBox(
        height: 50,
        width: 70,
        child: Column(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              padVertical(5),
              Image.asset(
                labelToAssetMap[label] ?? AppAssets.profile,
                fit: BoxFit.contain,
                width: 25,
                height: 20,
                color: isActive
                    ? AppColors.primaryColor
                    : AppColors.buttongroupBorder,
              )
            ],
          ),
          padVertical(5),
          Label(
            txt: label,
            maxLines: 1,
            type: TextTypes.f_13_400,
            forceColor: isActive
                ? AppColors.primaryColor
                : AppColors.buttongroupBorder,
          ),
        ]),
      ),
      label: "",
    );
  }
}
