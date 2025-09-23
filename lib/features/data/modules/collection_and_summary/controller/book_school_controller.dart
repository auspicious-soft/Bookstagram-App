import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PgBookSchoolController extends GetxController {
  // Reactive state for apply coupon toggle
  final applyCoupon = false.obs;

  // TextEditingController for the school code input
  final schoolCodeController = TextEditingController();

  // Toggle apply coupon state
  void toggleApplyCoupon() {
    applyCoupon.toggle();
    print('applyCoupon: ${applyCoupon.value}');
  }

  @override
  void onClose() {
    // Dispose the TextEditingController to prevent memory leaks
    schoolCodeController.dispose();
    super.onClose();
  }
}
