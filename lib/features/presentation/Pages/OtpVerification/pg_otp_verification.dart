import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/loader.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/features/data/datasources/user_storage.dart';
import 'package:bookstagram/features/data/models/verification_otp_model.dart';
import 'package:bookstagram/features/presentation/Pages/Congratulation/pg_congratulation.dart';
import 'package:bookstagram/features/presentation/providers/otp_provider.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart' as motion_toast;
import 'package:pin_code_fields/pin_code_fields.dart';

class PgOtpVerification extends ConsumerStatefulWidget {
  final String type;
  const PgOtpVerification({super.key, required this.type});

  @override
  PgOtpVerificationState createState() => PgOtpVerificationState();
}

class PgOtpVerificationState extends ConsumerState<PgOtpVerification> {
  String otpCode = "";

  @override
  Widget build(BuildContext context) {
    print(widget.type);
    final otpVerifyState = ref.watch(stateVerifyCodeNotifierProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (otpVerifyState.hasError) {
        // print('${signUpState}error');
        motion_toast.MotionToast.error(
          title: const Label(
            txt: "Error",
            type: TextTypes.f_15_500,
            forceColor: AppColors.whiteColor,
          ),
          description: Label(
            txt: "${otpVerifyState.error}",
            type: TextTypes.f_13_500,
            forceColor: AppColors.whiteColor,
          ),
          animationType:
              motion_toast.AnimationType.fromTop, // Use the prefix here
          position: motion_toast.MotionToastPosition.top,
          dismissable: true,
        ).show(context);
      }
    });
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
                                Navigator.pop(context);
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
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      onChanged: (value) {
                        setState(() {
                          otpCode = value;
                        });
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
                          fieldHeight: 47,
                          fieldWidth: 47,
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
                  Label(
                    txt: AppLocalization.of(context).translate('resend'),
                    type: TextTypes.f_15_500,
                    forceAlignment: TextAlign.center,
                    forceColor: AppColors.resnd,
                  ),
                  padVertical(20),
                  Label(
                    txt: AppLocalization.of(context).translate('changemail'),
                    type: TextTypes.f_15_400,
                    forceAlignment: TextAlign.center,
                    forceColor: AppColors.resnd,
                  ),
                  padVertical(50),
                  commonButton(
                      context: context,
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        final isValid = otpCode.isNotEmpty;
                        print(isValid);

                        if (isValid && otpCode.length == 6) {
                          ref
                              .read(stateVerifyCodeNotifierProvider.notifier)
                              .verificationSignupOtp(
                                  email: widget.type,
                                  otpCode: otpCode,
                                  onSuccess: (fineData) {
                                    goToNext(fineData, context);
                                  },
                                  context: context);
                        } else {
                          // ref
                          //     .read(signUpFormNotifierProvider.notifier)
                          //     .validateForm(emailController.text,
                          //         passwordController.text);
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
                                .AnimationType.fromTop, // Use the prefix here
                            position: motion_toast.MotionToastPosition.top,
                            dismissable: true,
                          ).show(context);
                        }
                      },
                      txt: AppLocalization.of(context).translate('confirm')),
                ])))
              ],
            ),
            if (otpVerifyState.isLoading) const LoadingScreen(),
          ]),
        ));
  }

  void goToNext(VerificationOtpModel fineData, BuildContext context) async {
    print(fineData.data);
    await UserStorage.con.saveToken(fineData.data?.user?.token);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const PgCongratulation(),
      ),
    );
  }
}
