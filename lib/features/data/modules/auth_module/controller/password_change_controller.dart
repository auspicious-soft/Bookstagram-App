// controllers/change_pass_controller.dart
import 'package:bookstagram/features/domain/usecases/usecase_change_pass.dart';
import 'package:bookstagram/features/domain/usecases/usecase_forgot_email.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../../../../app_settings/components/label.dart';
import '../../../../../app_settings/constants/app_colors.dart';


class ChangePassController extends GetxController {
  TextEditingController newPassController = TextEditingController();
  TextEditingController repPassController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool passEye = true.obs;
  RxBool passEye2 = true.obs;
  late final UsecaseChangePass _usecaseChangePass;
  void togglePassEye() => passEye.value = !passEye.value;
  void togglePassEye2() => passEye2.value = !passEye2.value;
  @override
  void onInit() {

    _usecaseChangePass = Get.find<UsecaseChangePass>();
    super.onInit();
  }

  void changePassword(String otp, BuildContext context) async {
    final newPassword = newPassController.text.trim();
    final repeatPassword = repPassController.text.trim();

    if (newPassword.isEmpty || repeatPassword.isEmpty) {
      Get.snackbar("Error", "All fields are required!!",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    if (newPassword != repeatPassword) {
      Get.snackbar("Error", "Passwords do not match",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;
      final result = await _usecaseChangePass.call(password: newPassword, otpCode:otp);
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
            (successData)async {
              MotionToast.success(
                title: const Label(
                  txt: "Success",
                  type: TextTypes.f_15_500,
                  forceColor: AppColors.whiteColor,
                ),
                description: const Label(
                  txt:"Password Change Successfully",
                  type: TextTypes.f_13_500,
                  forceColor: AppColors.whiteColor,
                ),
                      animationType: AnimationType.slideInFromBottom,
                toastAlignment: Alignment.topRight,
                dismissable: true,
              ).show(context);

              Get.offAllNamed('/login'); // Navigate on success
        },
      );


          } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
