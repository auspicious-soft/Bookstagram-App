import 'dart:async';
import 'dart:convert';

import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/features/data/models/verification_otp_model.dart';
import 'package:bookstagram/features/domain/usecases/usecase_forgot_otp.dart';
import 'package:bookstagram/features/domain/usecases/usecase_verify_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';


import '../../../../../app_settings/constants/app_config.dart';
import '../../../datasources/user_storage.dart';

import '../models/resendOtp_requestmodrl.dart';
import '../view/password_change.dart';

class OtpVerificationController extends GetxController {
  late final UsecaseVerifyOtp verifyOtpUseCase;
  late final UsecaseForgotOtp _forgotOtpUseCase;
  final TextEditingController pinController = TextEditingController();
  late final UsecaseResendOtp _resendOtpUseCase;
  final isLoading = false.obs;
  final errorMessage = RxString('');
  final verificationResult = Rx<VerificationOtpModel?>(null);
  RxInt secondsRemaining = 30.obs;
  late Timer _timer;
  String otpCode = "";
  String type="";
  String from="";

  @override
  void onInit() {
    verifyOtpUseCase=Get.find<UsecaseVerifyOtp>();
    _forgotOtpUseCase=Get.find<UsecaseForgotOtp>();
    _resendOtpUseCase=Get.find<UsecaseResendOtp>();
    type = Get.arguments['type'];
    from=Get.arguments['from'];
    startTimer();
    super.onInit();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
      }
    });
  }


   verifyOtp(String email, String otp,context) async {
    try {
      isLoading.value = true;
      final result = await verifyOtpUseCase.call(email: email, otpCode: otp);
      result.fold(
            (error) {
          errorMessage.value = error.message;
          isLoading.value = false;
          MotionToast.error(
            title: const Label(
              txt: "Error",
              type: TextTypes.f_15_500,
              forceColor: AppColors.whiteColor,
            ),
            description: Label(
              txt: "Invalid OTP",
              type: TextTypes.f_13_500,
              forceColor: AppColors.whiteColor,
            ),
                  animationType: AnimationType.slideInFromBottom,
            toastAlignment: Alignment.topRight,
            dismissable: true,
          ).show(context);

        },
            (successData)async {
          verificationResult.value = successData;
          await UserStorage.con.saveToken(verificationResult.value?.data?.user?.token);
          Get.offAllNamed('/congratulations'); // Navigate on success
        },
      );
    } catch (e) {
      errorMessage.value = e.toString();
      MotionToast.error(
        title: const Label(
          txt: "Error",
          type: TextTypes.f_15_500,
          forceColor: AppColors.whiteColor,
        ),
        description: Label(
          txt:"Invalid OTP",
          type: TextTypes.f_13_500,
          forceColor: AppColors.whiteColor,
        ),
        animationType: AnimationType.slideInFromBottom,
        toastAlignment: Alignment.topRight,
        dismissable: true,
      ).show(context);
      isLoading.value = false;

    } finally {
      isLoading.value = false;
      isLoading.refresh();
      pinController.clear();
    }
    isLoading.value = false;
    print(">>>>>>>>>>>Prewwwttttt>>>>>>>>>");
  }


  Future<void> resendOtp(context) async {
    try {
      _timer.cancel();
      isLoading.value = true;

      final data = await _resendOtpUseCase.call(email:type);

      data.fold(
            (error) {
          print("yes here error ${error.message}");
          isLoading.value = false;
        },
            (successData)async {
              secondsRemaining.value=30;
              secondsRemaining.refresh();

              startTimer();
              MotionToast.success(
                title: const Label(
                  txt: "Success",
                  type: TextTypes.f_15_500,
                  forceColor: AppColors.whiteColor,
                ),
                description: Label(
                  txt: successData.data?.response?.message ?? "OTP sent successfully",
                  type: TextTypes.f_13_500,
                  forceColor: AppColors.whiteColor,
                ),
                      animationType: AnimationType.slideInFromBottom,
                toastAlignment: Alignment.topRight,
                dismissable: true,
              ).show(context);
            });


    } catch (e) {
      errorMessage.value = e.toString();
      showErrorToast(e.toString());
    } finally {
      isLoading.value = false;
      pinController.clear();
    }
  }


  Future<void> resendForget(BuildContext context) async {
    isLoading.value = true;
    try {

      final headers = {
        'Content-Type': 'application/json',
        'role': 'admin',
        'x-client-type': 'mobile',
      };

      final body = jsonEncode({
        "email": type,

      });

      HttpWithMiddleware httpClient = HttpWithMiddleware.build(
        middlewares: [HttpLogger(logLevel: LogLevel.BODY)],
      );

      String uri = '${AppConfig.baseUrl}${AppConfig.forgetResend}';

      final response = await httpClient.post(
        Uri.parse(uri),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        secondsRemaining.value=30;
        secondsRemaining.refresh();
        startTimer();
        MotionToast.success(
          title: const Label(
            txt: "Success",
            type: TextTypes.f_15_500,
            forceColor: AppColors.whiteColor,
          ),
          description: Label(
            txt:  "OTP sent successfully",
            type: TextTypes.f_13_500,
            forceColor: AppColors.whiteColor,
          ),
          animationType: AnimationType.slideInFromBottom,
          toastAlignment: Alignment.topRight,
          dismissable: true,
        ).show(context);

      }
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

      print("Error: ${e.toString()}");
      throw e;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgetverifyOtp( String otp,context) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final data = await _forgotOtpUseCase.call(otpCode: otpCode);

      data.fold(
        (error) {
          print("yes here error ${error.message}");

          errorMessage.value = error.message;
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
          ).show(context);   //     error.message, StackTrace.fromString("Failed to fetch user"));
        },
            (successData)async {
              MotionToast.success(
                title: const Label(
                  txt: "Success",
                  type: TextTypes.f_15_500,
                  forceColor: AppColors.whiteColor,
                ),
                description: Label(
                  txt: successData.message ?? "OTP sent successfully",
                  type: TextTypes.f_13_500,
                  forceColor: AppColors.whiteColor,
                ),
                      animationType: AnimationType.slideInFromBottom,
                toastAlignment: Alignment.topRight,
                dismissable: true,
              ).show(context);
              showModalBottomSheet(
                backgroundColor: AppColors.background,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                isScrollControlled: true,
                builder: (context) {
                  _timer.cancel();
                  secondsRemaining.value=0;
                  return  ChangePassSheet(otp: otpCode);
                },
              );
           },
      );
    } catch (e) {
      errorMessage.value = e.toString();
      MotionToast.success(
        title: const Label(
          txt: "Success",
          type: TextTypes.f_15_500,
          forceColor: AppColors.whiteColor,
        ),
        description: Label(
          txt: "Invalid OTP",
          type: TextTypes.f_13_500,
          forceColor: AppColors.whiteColor,
        ),
        animationType: AnimationType.slideInFromBottom,
        toastAlignment: Alignment.topRight,
        dismissable: true,
      ).show(context);

    } finally {

      isLoading.value = false;
      pinController.clear();
    }
  }



  void showErrorToast(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.red,
      colorText: AppColors.whiteColor,
      titleText: const Label(
        txt: "Error",
        type: TextTypes.f_15_500,
        forceColor: AppColors.whiteColor,
      ),
      messageText: Label(
        txt: message,
        type: TextTypes.f_13_500,
        forceColor: AppColors.whiteColor,
      ),
    );
  }
}