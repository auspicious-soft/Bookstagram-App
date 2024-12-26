import 'package:bookstagram/Pages/Dashboard/TabHome/Pg_tabhome.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgDashBoard extends StatefulWidget {
  const PgDashBoard({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StatePgDashBoard();
  }
}

class _StatePgDashBoard extends State<PgDashBoard> {
  int selectedTab = 0;

  List<Widget> get tabViews => [const PgTabhome()];
  final PageController pageController = PageController(initialPage: 0);
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [PgTabhome()],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
              pageController.jumpToPage(index);
            });
          },
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
            _buildNavItem(AppLocalization.of(context).translate('home'), 0),
            _buildNavItem(AppLocalization.of(context).translate('Search'), 1),
            _buildNavItem(
                AppLocalization.of(context).translate('Bookshelf'), 2),
            _buildNavItem(AppLocalization.of(context).translate('Cart'), 3),
            _buildNavItem(AppLocalization.of(context).translate('Profile'), 4),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String label, int index) {
    bool isActive = selectedIndex == index;

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
                getImageAsset(label),
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
              type: TextTypes.f_13_400,
              forceColor: isActive
                  ? AppColors.primaryColor
                  : AppColors.buttongroupBorder),
        ]),
      ),
      label: "",
    );
  }

  String getImageAsset(String label) {
    switch (label.toLowerCase()) {
      case "home":
        return AppAssets.home;
      case "search":
        return AppAssets.search;
      case "bookshelf":
        return AppAssets.bookself;
      case "cart":
        return AppAssets.cart;
      default:
        return AppAssets.profile;
    }
  }
}
