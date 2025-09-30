import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../../../../app_settings/components/label.dart';
import '../../../../../app_settings/constants/app_colors.dart';
import 'package:bookstagram/features/domain/usecases/usecase_change_pass.dart';

import 'otp_verification_Controller.dart';

class ChangePassController extends GetxController {
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController repPassController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool passEye = true.obs;
  final RxBool passEye2 = true.obs;

  late final UsecaseChangePass _usecaseChangePass;

  void togglePassEye() => passEye.value = !passEye.value;

  void togglePassEye2() => passEye2.value = !passEye2.value;

  @override
  void onInit() {
    super.onInit();
    _usecaseChangePass = Get.find<UsecaseChangePass>();
  }

  @override
  void onClose() {
    newPassController.dispose();
    repPassController.dispose();
    super.onClose();
  }

  void changePassword(String otp, BuildContext context) async {
    final newPassword = newPassController.text.trim();
    final repeatPassword = repPassController.text.trim();

    if (newPassword.isEmpty || repeatPassword.isEmpty) {
      Get.snackbar("Error", "All fields are required!!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
      return;
    }

    if (newPassword != repeatPassword) {
      Get.snackbar("Error", "Passwords do not match",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;
      final result = await _usecaseChangePass.call(
        password: newPassword,
        otpCode: otp,
      );

      result.fold(
        (error) {
          isLoading.value = false;
          MotionToast.error(
            title: const Label(
              txt: "Error",
              type: TextTypes.f_15_500,
              forceColor: AppColors.whiteColor,
            ),
            description: Label(
              txt: error.message,
              type: TextTypes.f_13_500,
              forceColor: AppColors.whiteColor,
            ),
            animationType: AnimationType.slideInFromBottom,
            toastAlignment: Alignment.topRight,
            dismissable: true,
          ).show(context);
        },
        (_) async {
          isLoading.value = false;
          MotionToast.success(
            title: const Label(
              txt: "Success",
              type: TextTypes.f_15_500,
              forceColor: AppColors.whiteColor,
            ),
            description: const Label(
              txt: "Password Changed Successfully",
              type: TextTypes.f_13_500,
              forceColor: AppColors.whiteColor,
            ),
            animationType: AnimationType.slideInFromBottom,
            toastAlignment: Alignment.topRight,
            dismissable: true,
          ).show(context);

          Get.offAllNamed('/login');
          Get.find<OtpVerificationController>().pinController.clear();
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    }
  }
}
