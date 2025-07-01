import 'package:bookstagram/features/domain/usecases/usecase_forgot_email.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;
  final isEmailError = false.obs;
  late final UsecaseForgotEmail usecaseForgotEmail;

  @override
  void onInit() {

    usecaseForgotEmail = Get.find<UsecaseForgotEmail>();
    super.onInit();
  }

  void forgotPassEmail({required BuildContext context}) async {
    final email = emailController.text.trim();
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      isEmailError.value = true;
      MotionToast.error(
        title: const Label(
          txt: "Error",
          type: TextTypes.f_15_500,
          forceColor: AppColors.whiteColor,
        ),
        description: const Label(
          txt: "The email is incorrect!",
          type: TextTypes.f_13_500,
          forceColor: AppColors.whiteColor,
        ),
              animationType: AnimationType.slideInFromBottom,
        toastAlignment: Alignment.topRight,
        dismissable: true,
      ).show(context);
      return;
    }

    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2)); // simulate API call

        final useCase = usecaseForgotEmail; // Assuming you have this registered
        final data = await useCase.call(
          email: email,
        );
        data.fold(
              (error) {
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
              (fineData) async {

            MotionToast.success(
              title: const Label(
                txt: "Success",
                type: TextTypes.f_15_500,
                forceColor: AppColors.whiteColor,
              ),
              description: Label(
                txt: fineData.message ?? "Otp Sent successful",
                type: TextTypes.f_13_500,
                forceColor: AppColors.whiteColor,
              ),
                    animationType: AnimationType.slideInFromBottom,
              toastAlignment: Alignment.topRight,
              dismissable: true,
            ).show(context);
           Get.back();
            Get.offNamed('/otpscreen', arguments: {
              'type':email,"from":"forget"
            });

          },
        );



    } catch (e) {
      MotionToast.error(
        title: const Label(
          txt: "Error",
          type: TextTypes.f_15_500,
          forceColor: AppColors.whiteColor,
        ),
        description: Label(
          txt: e.toString(),
          type: TextTypes.f_13_500,
          forceColor: AppColors.whiteColor,
        ),
              animationType: AnimationType.slideInFromBottom,
        toastAlignment: Alignment.topRight,
        dismissable: true,
      ).show(context);
    } finally {
      isLoading.value = false;
    }
  }
}
