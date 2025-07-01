import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:bookstagram/app_settings/components/common_textfield.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/loader.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';

import 'package:bookstagram/features/presentation/providers/auth_google_service.dart';
import 'package:bookstagram/localization/app_localization.dart';

import '../controller/forget_password_controller.dart';
import '../controller/login_controller.dart';
import 'forget_password_sheet.dart';

class PgLogin extends GetView<LoginController> {
  PgLogin({Key? key}) : super(key: key);

  final AuthGoogleService _authService = AuthGoogleService();

  // Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    // final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //   FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
  //
  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.background, // Set status bar color
        statusBarIconBrightness: Brightness.dark, // Ensure icons are visible on white
      ),
    );
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
            child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Label(
                                        txt: AppLocalization.of(context).translate('logintxt'),
                                        type: TextTypes.f_21_500
                                    )
                                ),
                                padVertical(30),
                                // Tab selection removed as per your commented code, but can be added back if needed
                    
                                Obx(() =>
                                controller.selectedIndex.value == 0
                                    ? _buildEmailSection(context)
                                    : _buildPhoneSection(context)
                                ),
                                padVertical(20),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Label(
                                        txt: AppLocalization.of(context).translate('forgetpass'),
                                        type: TextTypes.f_15_400,
                                        forceAlignment: TextAlign.left,
                                      ),
                                      padHorizontal(3),
                                      GestureDetector(
                                        onTap: () {
                                          controller.emailController.text = "";
                                          controller.passwordController.text = "";
                                          controller.restoreEmailController.text = "";
                                          final forgetPass = Get.put(ForgotPasswordController());
                                          forgetPass.emailController.text="";
                                          showModalBottomSheet(
                                            backgroundColor: AppColors.background,
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                            ),
                                            isScrollControlled: true,
                                            builder: (context) {
                                              controller.emailController.text='';
                                              controller.passwordController.text='';

                                               return  ForgotPasswordSheet();
                                            },
                                          );
                                        },
                                        child: Label(
                                          txt: AppLocalization.of(context).translate('restore'),
                                          type: TextTypes.f_15_400,
                                          forceColor: AppColors.primaryColor,
                                        ),
                                      ),
                                    ]
                                ),
                    
                                Column(
                                    children: [
                                     SizedBox(height: Get.height*0.15,),
                                      commonButton(
                                          context: context,
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            controller.validateForm();
                    
                                            if (controller.isFormValid) {
                                              controller.login(
                                                  authType: "Email",
                                                  language: "en",
                                                  context: context
                                              );
                                            } else {
                                              controller.showErrorToast(
                                                  context,
                                                  "The email or password is incorrect"
                                              );
                                            }
                                          },
                                          txt: AppLocalization.of(context).translate('Login')
                                      ),
                                      padVertical(25),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Label(
                                            txt: AppLocalization.of(context).translate('orwithsocial'),
                                            type: TextTypes.f_15_400,
                                            forceColor: AppColors.socialTxt,
                                          )
                                      ),
                                      padVertical(20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          if (Platform.isIOS)
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: AppColors.inputBorder,
                                                  width: 2,
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.apple,
                                                color: AppColors.blackColor,
                                                size: 32,
                                              ),
                                            ),
                                          if (Platform.isAndroid)
                                            GestureDetector(
                                                onTap: () => controller.signInWithGoogle(context),
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(
                                                      color: AppColors.inputBorder,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: SizedBox(
                                                    height: 32,
                                                    width: 32,
                                                    child: Image.asset(
                                                      AppAssets.google,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                )
                                            ),
                                          padHorizontal(20),
                                          GestureDetector(
                                              onTap: () async {
                                                // UserCredential? user = await signInWithFacebook();
                                                // if (user != null && user.user?.email != null) {
                                                //   controller.loginWithSocial(
                                                //       email: user.user!.email.toString(),
                                                //       authType: "Facebook",
                                                //       language: "en",
                                                //       context: context
                                                //   );
                                                // }
                                              },
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: AppColors.inputBorder,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: const Icon(
                                                  Icons.facebook,
                                                  color: AppColors.facebook,
                                                  size: 32,
                                                ),
                                              )
                                          ),
                                        ],
                                      ),
                                      padVertical(25),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Label(
                                              txt: AppLocalization.of(context).translate('notreg'),
                                              type: TextTypes.f_15_400,
                                              forceAlignment: TextAlign.left,
                                            ),
                                            padHorizontal(3),
                                            GestureDetector(
                                                onTap: () {
                                                  controller.emailController.text='';
                                                  controller.passwordController.text='';
                                                  Get.toNamed("/signup");
                                                },
                                                child: Label(
                                                  txt: AppLocalization.of(context).translate('openaccount'),
                                                  type: TextTypes.f_15_400,
                                                  forceColor: AppColors.primaryColor,
                                                )
                                            ),
                                          ]
                                      ),
                                      padVertical(20),
                                    ]
                                )
                              ]
                          ),
                    
                        ]
                    ).marginSymmetric(horizontal: 20,vertical: 40),
                  ),
                  Obx(() => controller.isLoading.value ? const LoadingScreen() : const SizedBox()),
                ]
            )
        )
    );
  }

  Widget _buildEmailSection(BuildContext context) {
    return Column(
        children: [
          padVertical(15),
          Obx(() => commonTxtField(
              isError: controller.isEmailError.value,
              onChanged: (value) {
                controller.isEmailError.value = value.isEmpty ||
                    !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
              },
              controller: controller.emailController,
              hTxt: AppLocalization.of(context).translate('Email'),
              keyboardType: TextInputType.emailAddress
          )),
          padVertical(15),
          Obx(() => Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: controller.isPasswordError.value
                    ? AppColors.red
                    : AppColors.inputBorder,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      controller.isPasswordError.value = value.isEmpty;
                    },
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppLocalization.of(context).translate('Password'),
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
                    obscureText: controller.passEye.value,
                  ),
                ),
                GestureDetector(
                  onTap: controller.togglePassEye,
                  child: Obx(() => Icon(
                    controller.passEye.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.buttongroupBorder,
                    size: 20,
                  )),
                ),
              ],
            ),
          )),
        ]
    );
  }

  Widget _buildPhoneSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        padVertical(15),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.inputBorder,
                  width: 2,
                ),
              ),
              child: CountryCodePicker(
                onChanged: (country) {
                  controller.setCountryCode(country.dialCode.toString());
                },
                initialSelection: 'US',
                favorite: const ['+1', '+91'],
                showFlag: true,
                searchStyle: const TextStyle(
                    fontFamily: AppConst.fontFamily,
                    color: AppColors.blackColor,
                    fontSize: 16
                ),
                dialogTextStyle: const TextStyle(
                    fontFamily: AppConst.fontFamily,
                    color: AppColors.blackColor,
                    fontSize: 15
                ),
                headerTextStyle: const TextStyle(
                    fontFamily: AppConst.fontFamily,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
                showDropDownButton: true,
                textStyle: const TextStyle(
                    fontFamily: AppConst.fontFamily,
                    color: AppColors.blackColor
                ),
                padding: const EdgeInsets.symmetric(horizontal: 0),
              ),
            ),
            padHorizontal(10),
            Expanded(
              child: Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: controller.isPhoneError.value
                        ? AppColors.red
                        : AppColors.inputBorder,
                    width: 2,
                  ),
                ),
                child: TextField(
                  onChanged: (value) {
                    controller.isPhoneError.value = value.isEmpty || value.length < 10;
                  },
                  controller: controller.phoneController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: AppLocalization.of(context).translate('whatsup'),
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
                  keyboardType: TextInputType.phone,
                ),
              )),
            ),
          ],
        ),
      ],
    );
  }
}