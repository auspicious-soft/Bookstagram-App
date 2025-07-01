import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'no_internet_screen.dart';

class ConnectivityController extends GetxController {
  static ConnectivityController get to => Get.find();
  final Connectivity _connectivity = Connectivity();
  final RxBool _isConnected = true.obs;
  bool _isNoInternetScreenShown = false;
  String _currentConnectionType = 'None';

  bool get isConnected => _isConnected.value;
  String getCurrentConnectionType() => _currentConnectionType;

  @override
  void onInit() {
    super.onInit();
    // Listen to connectivity changes
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    // Perform initial check
    checkConnection();
  }


  Future<void> checkConnection() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      await _updateConnectionStatus(connectivityResult);
      debugPrint("Connectivity Check: Result = $connectivityResult");
    } catch (e) {
      debugPrint("Error checking connectivity: $e");
    }
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    bool hasInternet = false;
    String connectionType = 'None';

    // Handle connectivity results
    if (results.contains(ConnectivityResult.wifi)) {
      connectionType = 'Wi-Fi';
      hasInternet = await _checkInternetAccess();
      debugPrint("Wi-Fi: ${hasInternet ? 'Internet access confirmed' : 'Connected but no internet'}");
    } else if (results.contains(ConnectivityResult.mobile)) {
      connectionType = 'Mobile Data';
      hasInternet = await _checkInternetAccess();
      debugPrint("Mobile Data: ${hasInternet ? 'Internet access confirmed' : 'Connected but no internet'}");
    } else if (results.contains(ConnectivityResult.none)) {
      connectionType = 'No Connection';
      debugPrint("No network connection detected");
    } else {
      connectionType = 'Other';
      hasInternet = await _checkInternetAccess();
      debugPrint("Other connection type detected: $results");
    }

    _currentConnectionType = connectionType;

    // Update connection status and manage NoInternetScreen
    if (_isConnected.value != hasInternet) {
      _isConnected.value = hasInternet;
      if (!hasInternet && !_isNoInternetScreenShown) {
        _isNoInternetScreenShown = true;
        Get.toNamed('/no-internet');
        debugPrint("Navigating to NoInternetScreen (Connection Type: $connectionType)");
      } else if (hasInternet && _isNoInternetScreenShown) {
        _isNoInternetScreenShown = false;
        if (Get.currentRoute == '/no-internet') {
          if (Get.routing.previous.isEmpty || Get.routing.previous == '/') {
            debugPrint("No previous route, navigating to splash screen");
            Get.offAllNamed('/splash');
          } else {
            debugPrint("Closing NoInternetScreen, returning to previous screen: ${Get.routing.previous}");
            Get.back();
          }
        }else{
          Get.toNamed("/splash");
        }
      }
    } else {
      debugPrint("Connection status unchanged: hasInternet=$hasInternet, connectionType=$connectionType");
    }
  }

  Future<bool> _checkInternetAccess() async {
    try {
      final lookupResult = await InternetAddress.lookup('google.com').timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          debugPrint("Ping timed out");
          return [];
        },
      );
      return lookupResult.isNotEmpty && lookupResult[0].rawAddress.isNotEmpty;
    } catch (e) {
      debugPrint("Error checking internet access: $e");
      return false;
    }
  }
}