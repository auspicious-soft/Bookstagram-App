import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../app_settings/components/label.dart';
import '../app_settings/constants/app_assets.dart';
import '../app_settings/constants/app_colors.dart';
import '../app_settings/constants/app_dim.dart';
import 'connectivity_controller.dart';
import 'no_internet_screen.dart';

class NoInternetScreen extends StatelessWidget {
  final String connectionType;

  const NoInternetScreen({Key? key, required this.connectionType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConnectivityController connectivityController = Get.find<ConnectivityController>();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.whiteColor, // Set status bar color
        statusBarIconBrightness:
        Brightness.dark, // Ensure icons are visible on white
      ),
    );
    return WillPopScope(
      onWillPop: () async => false, // Prevent back button from dismissing
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.Connectionlost,
                  height: 100,
                  width: 100,
                ),
                padVertical(10),
                Image.asset(
                  AppAssets.noData,
                  height: 100,
                  width: 100,
                ),
                padVertical(10),
                Label(
                  txt: "You seem to have a weak internet connection",
                  type: TextTypes.f_13_500,
                ),
                padVertical(20),
                // ElevatedButton(
                //   onPressed: () async {
                //     // Trigger connectivity check
                //     await connectivityController.checkConnection();
                //     // If connected, the dialog will be closed by the controller
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.blue,
                //     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //   ),
                //   child: const Text(
                //     'Retry',
                //     style: TextStyle(
                //       fontSize: 18,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}