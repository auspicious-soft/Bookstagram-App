import 'package:bookstagram/app_settings/components/common_textfield.dart';
import 'package:bookstagram/app_settings/components/label.dart';

import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/app_settings/extensions/extend_string.dart';
import 'package:bookstagram/features/data/models/forgot_email_model.dart';
import 'package:bookstagram/features/presentation/Pages/ForgotOtp/pg_forgot_otp.dart';
import 'package:bookstagram/features/presentation/providers/forgot_pass_email.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart' as motion_toast;
import 'package:motion_toast/motion_toast.dart';

class ForgotPasswordSheet extends ConsumerStatefulWidget {
  const ForgotPasswordSheet({super.key});

  @override
  ForgotPasswordSheetState createState() => ForgotPasswordSheetState();
}

class ForgotPasswordSheetState extends ConsumerState<ForgotPasswordSheet> {
  final TextEditingController restoreEmailController = TextEditingController();
  bool isResEmailError = false;

  @override
  Widget build(BuildContext context) {
    final forgotEmailState = ref.watch(stateForgetEmailProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (forgotEmailState.hasError) {
        print('${forgotEmailState}error');
        motion_toast.MotionToast.error(
          title: const Label(
            txt: "Error",
            type: TextTypes.f_15_500,
            forceColor: AppColors.whiteColor,
          ),
          description: Label(
            txt: "${forgotEmailState.error}",
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
    return Stack(
      children: [
        SizedBox(
          height: ScreenUtils.screenHeight(context) / 1.1,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                padVertical(10),
                Center(
                  child: Label(
                    txt: AppLocalization.of(context)
                        .translate('Passwordrecovery'),
                    type: TextTypes.f_17_500,
                  ),
                ),
                padVertical(15),
                Center(
                  child: Label(
                    txt: AppLocalization.of(context).translate('restoretxt'),
                    forceAlignment: TextAlign.center,
                    type: TextTypes.f_13_400,
                  ),
                ),
                padVertical(20),
                commonTxtField(
                  isError: isResEmailError,
                  onChanged: (value) {
                    setState(() {
                      isResEmailError = value.isEmpty || value.isInvalidEmail();
                    });
                  },
                  controller: restoreEmailController,
                  hTxt: AppLocalization.of(context).translate('Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                padVertical(15),
                forgotEmailState.isLoading
                    ? const Center(
                        child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )))
                    : commonButton(
                        onPressed: () {
                          final isValid =
                              restoreEmailController.text.isNotEmpty &&
                                  !restoreEmailController.text.isInvalidEmail();
                          if (isValid) {
                            ref
                                .read(stateForgetEmailProvider.notifier)
                                .forgotPassEmail(
                                    email: restoreEmailController.text,
                                    onSuccess: (fineData) {
                                      successOtpSend(fineData, context);
                                    },
                                    context: context);
                          } else {
                            MotionToast.error(
                              title: const Label(
                                txt: "Error",
                                type: TextTypes.f_15_500,
                                forceColor: AppColors.whiteColor,
                              ),
                              description: const Label(
                                txt: "The email incorrect !!",
                                type: TextTypes.f_13_500,
                                forceColor: AppColors.whiteColor,
                              ),
                              animationType: AnimationType.fromTop,
                              position: MotionToastPosition.top,
                              dismissable: true,
                            ).show(context);
                          }
                        },
                        context: context,
                        txt: AppLocalization.of(context).translate('restore'),
                      ),
              ],
            ),
          ),
        ),
        // if (forgotEmailState.isLoading)
      ],
    );
  }

  void successOtpSend(ForgotEmailModel fineData, BuildContext context) async {
    Navigator.pop(context);
    MotionToast.success(
      title: const Label(
        txt: "Success",
        type: TextTypes.f_15_500,
        forceColor: AppColors.whiteColor,
      ),
      description: const Label(
        txt: "Password reset email sent with otp!!",
        type: TextTypes.f_13_500,
        forceColor: AppColors.whiteColor,
      ),
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.top,
      dismissable: true,
    ).show(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PgForgotOtp(
          type: restoreEmailController.text,
        ),
      ),
    );
  }
}
