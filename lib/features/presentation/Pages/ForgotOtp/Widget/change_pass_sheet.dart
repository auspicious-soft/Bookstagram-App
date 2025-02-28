import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/features/data/datasources/user_storage.dart';
import 'package:bookstagram/features/data/models/change_pass_model.dart';
import 'package:bookstagram/features/presentation/Pages/Dashboard/pg_dasboard.dart';
import 'package:bookstagram/features/presentation/providers/change_pass_provider.dart';
import 'package:bookstagram/features/presentation/providers/forgot_pass_email.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart' as motion_toast;
import 'package:motion_toast/motion_toast.dart';

class ChangePassSheet extends ConsumerStatefulWidget {
  final String otp;

  const ChangePassSheet({super.key, required this.otp});

  @override
  ChangePassSheetState createState() => ChangePassSheetState();
}

class ChangePassSheetState extends ConsumerState<ChangePassSheet> {
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController repPassController = TextEditingController();
  bool isResEmailError = false;
  bool isPassError = false;
  bool passEye2 = true;
  bool passEye = true;
  @override
  Widget build(BuildContext context) {
    final changePaaState = ref.watch(stateForgetEmailProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (changePaaState.hasError) {
        print('${changePaaState}error');
        motion_toast.MotionToast.error(
          title: const Label(
            txt: "Error",
            type: TextTypes.f_15_500,
            forceColor: AppColors.whiteColor,
          ),
          description: Label(
            txt: "${changePaaState.error}",
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
                    txt: AppLocalization.of(context).translate('newpassword'),
                    type: TextTypes.f_17_500,
                  ),
                ),
                padVertical(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Label(
                      txt: AppLocalization.of(context)
                          .translate('setnewpassword'),
                      forceAlignment: TextAlign.center,
                      type: TextTypes.f_34_500,
                    ),
                  ),
                ),
                padVertical(20),
                Label(
                  txt: AppLocalization.of(context).translate('newpassword'),
                  forceAlignment: TextAlign.center,
                  type: TextTypes.f_13_400,
                ),
                padVertical(15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.inputBorder,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: newPassController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: AppLocalization.of(context)
                                .translate('Password'),
                            hintStyle: const TextStyle(
                              color: AppColors.inputBorder,
                              fontFamily: AppConst.fontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontFamily: AppConst.fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: passEye,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            passEye = !passEye;
                          });
                        },
                        child: Icon(
                          passEye
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.buttongroupBorder,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                padVertical(15),
                Label(
                  txt: AppLocalization.of(context)
                      .translate('repeatnewpassword'),
                  forceAlignment: TextAlign.center,
                  type: TextTypes.f_13_400,
                ),
                padVertical(15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.inputBorder,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: repPassController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: AppLocalization.of(context)
                                .translate('Password'),
                            hintStyle: const TextStyle(
                              color: AppColors.inputBorder,
                              fontFamily: AppConst.fontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontFamily: AppConst.fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: passEye2,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            passEye2 = !passEye2;
                          });
                        },
                        child: Icon(
                          passEye2
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.buttongroupBorder,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                padVertical(40),
                changePaaState.isLoading
                    ? const Center(
                        child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )))
                    : commonButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();

                          if (newPassController.text.isEmpty &&
                              repPassController.text.isEmpty) {
                            motion_toast.MotionToast.error(
                              title: const Label(
                                txt: "Error",
                                type: TextTypes.f_15_500,
                                forceColor: AppColors.whiteColor,
                              ),
                              description: const Label(
                                txt: "All fields are required!!",
                                type: TextTypes.f_13_500,
                                forceColor: AppColors.whiteColor,
                              ),
                              animationType: motion_toast
                                  .AnimationType.fromTop, // Use the prefix here
                              position: motion_toast.MotionToastPosition.top,
                              dismissable: true,
                            ).show(context);
                          } else if (newPassController.text !=
                              repPassController.text) {
                            motion_toast.MotionToast.error(
                              title: const Label(
                                txt: "Error",
                                type: TextTypes.f_15_500,
                                forceColor: AppColors.whiteColor,
                              ),
                              description: const Label(
                                txt:
                                    "Enter same password, repeat password need to match",
                                type: TextTypes.f_13_500,
                                forceColor: AppColors.whiteColor,
                              ),
                              animationType: motion_toast
                                  .AnimationType.fromTop, // Use the prefix here
                              position: motion_toast.MotionToastPosition.top,
                              dismissable: true,
                            ).show(context);
                          } else {
                            print("ok");
                            ref
                                .read(stateChangePassProvider.notifier)
                                .changePassword(
                                    password: repPassController.text,
                                    otpCode: widget.otp,
                                    onSuccess: (fineData) {
                                      goToDasboard(fineData, context);
                                    },
                                    context: context);
                          }
                        },
                        context: context,
                        txt: AppLocalization.of(context).translate('save'),
                      ),
              ],
            ),
          ),
        )

        // if (forgotEmailState.isLoading)
      ],
    );
  }

  void goToDasboard(ChangePassModel fineData, BuildContext context) async {
    await UserStorage.con.saveToken(fineData.data?.token);
    Navigator.pop(context);
    MotionToast.success(
      title: const Label(
        txt: "Success",
        type: TextTypes.f_15_500,
        forceColor: AppColors.whiteColor,
      ),
      description: const Label(
        txt: "Password changed successfully",
        type: TextTypes.f_13_500,
        forceColor: AppColors.whiteColor,
      ),
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.top,
      dismissable: true,
      // ignore: use_build_context_synchronously
    ).show(context);

    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const PgDashBoard()),
    );
  }
}
