import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart' as motion_toast;
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../app_settings/components/loader.dart';
import '../controller/otp_verification_Controller.dart';

class PgOtpVerification extends GetView<OtpVerificationController> {
  // final String type;

  const PgOtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                        child:
                        Column(mainAxisSize: MainAxisSize.min, children: [
                          Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                       Get.back();
                                      },
                                      child: const Icon(Icons.arrow_back_ios_new)),
                                  Label(
                                      txt: AppLocalization.of(context)
                                          .translate('verify'),
                                      type: TextTypes.f_17_500),
                                  const SizedBox(),
                                ],
                              )),
                          const Divider(),
                          Padding(
                              padding: const EdgeInsets.all(30),
                              child: Label(
                                txt: AppLocalization.of(context).translate('codesend'),
                                type: TextTypes.f_34_500,
                                forceAlignment: TextAlign.center,
                              )),
                          Label(
                            txt: AppLocalization.of(context).translate('entercode'),
                            type: TextTypes.f_17_400,
                            forceAlignment: TextAlign.center,
                            forceColor: AppColors.resnd,
                          ),
                          padVertical(30),
                          SizedBox(
                            width: MediaQuery.of(context).size.width-80 ,
                            child: PinCodeTextField(
                              appContext: context,
                              length: 6,
                              controller: controller
                                  .pinController,
                              onChanged: (value) {
                               controller.otpCode=value;
                              },
                              cursorColor: Colors.black,
                              textStyle: const TextStyle(
                                  fontFamily: AppConst.fontFamily,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                              keyboardType: TextInputType.number,
                              pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(10),
                                  fieldHeight: 40,
                                  fieldWidth: 40,
                                  activeFillColor: AppColors.background,
                                  inactiveFillColor: AppColors.background,
                                  activeColor: AppColors.primaryColor,
                                  selectedFillColor: AppColors.background,
                                  inactiveColor: AppColors.inputBorder,
                                  selectedColor: AppColors.primaryColor,
                                  errorBorderColor: AppColors.red),
                              enableActiveFill: true,
                            ),
                          ),
                          padVertical(20),
                          GestureDetector(
                            onTap:() {

                           if(controller.secondsRemaining.value==0){
                             if(controller.from=="forget"){

                               controller.resendForget(context);

                             }else {
                               controller.resendOtp(Get.context);
                             }
                           }

                              },

                            child: Obx(() {
                              if (controller.secondsRemaining.value > 0) {
                                return Label(
                                  txt: "${AppLocalization.of(context).translate('resend')} 00:${controller.secondsRemaining.value}s",
                                  type: TextTypes.f_15_500,
                                  forceAlignment: TextAlign.center,
                                  forceColor: AppColors.resnd,
                                );
                              } else {
                                return Label(
                                  txt: AppLocalization.of(context).translate('resend'),
                                  type: TextTypes.f_15_500,
                                  forceAlignment: TextAlign.center,
                                  forceColor: AppColors.resnd,
                                );
                              }
                            }),
                          ),
                          padVertical(20),
                          GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: Label(
                              txt: AppLocalization.of(context).translate('changemail'),
                              type: TextTypes.f_15_400,
                              forceAlignment: TextAlign.center,
                              forceColor: AppColors.resnd,
                            ),
                          ),
                          padVertical(50),
                          commonButton(
                              context: context,
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                final isValid = controller.otpCode.isNotEmpty;


                                if (isValid && controller.otpCode.length == 6) {
                                  print("${controller.from}");
                                  if(controller.from=="forget"){
                                    print("it is from forget >>>>>>>>");
                                    controller.forgetverifyOtp(controller.otpCode,Get.context);

                                  }else if(controller.from=="signup"){
                                    controller.verifyOtp(controller.type, controller.otpCode,Get.context);

                                  }

                                } else {
                                  motion_toast.MotionToast.error(
                                    title: const Label(
                                      txt: "Error",
                                      type: TextTypes.f_15_500,
                                      forceColor: AppColors.whiteColor,
                                    ),
                                    description: const Label(
                                      txt: "Enter valid Otp !!",
                                      type: TextTypes.f_13_500,
                                      forceColor: AppColors.whiteColor,
                                    ),
                                    animationType: motion_toast
                                        .AnimationType.slideInFromTop, // Use the prefix here
                                    toastAlignment: Alignment.topRight,
                                    dismissable: true,
                                  ).show(context);
                                }
                              },
                              txt: AppLocalization.of(context).translate('confirm')),
                        ])))
              ],
            ),
         Obx(()=>controller.isLoading.value==true?LoadingScreen():Container()),
          ]),
        ));
  }
}