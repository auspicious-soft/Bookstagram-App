import 'dart:io';
import 'package:bookstagram/features/data/modules/auth_module/controller/signup_controller.dart';
import 'package:bookstagram/features/presentation/Pages/Support/pg_support.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:bookstagram/app_settings/components/common_textfield.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/loader.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/app_settings/extensions/extend_string.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:motion_toast/motion_toast.dart';

class PgSignup extends GetView<SignUpController> {
  const PgSignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.background, // Set status bar color
        statusBarIconBrightness:
            Brightness.dark, // Ensure icons are visible on white
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            WidgetGlobalMargin(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          padVertical(30),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Label(
                              txt: AppLocalization.of(context)
                                  .translate('Mailorwhatsup'),
                              type: TextTypes.f_21_500,
                            ),
                          ),
                          // padVertical(30),

                          // Email/WhatsApp row (commented out in your original code)
                          // Obx(() => Row(
                          //   children: [
                          //     Expanded(
                          //       child: GestureDetector(
                          //         onTap: () => controller.setSelectedIndex(0),
                          //         child: Container(
                          //           padding: const EdgeInsets.only(bottom: 10),
                          //           alignment: Alignment.center,
                          //           child: Text(
                          //             AppLocalization.of(context).translate('email'),
                          //             style: TextStyle(
                          //               fontFamily: AppConst.fontFamily,
                          //               fontSize: 16,
                          //               fontWeight: controller.selectedIndex.value == 0
                          //                 ? FontWeight.bold
                          //                 : FontWeight.normal,
                          //               color: controller.selectedIndex.value == 0
                          //                 ? AppColors.primaryColor
                          //                 : AppColors.buttongroupBorder,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     Expanded(
                          //       child: GestureDetector(
                          //         onTap: () => controller.setSelectedIndex(1),
                          //         child: Container(
                          //           padding: const EdgeInsets.only(bottom: 10),
                          //           alignment: Alignment.center,
                          //           child: Text(
                          //             AppLocalization.of(context).translate('WhatsApp'),
                          //             style: TextStyle(
                          //               fontFamily: AppConst.fontFamily,
                          //               fontSize: 16,
                          //               fontWeight: controller.selectedIndex.value == 1
                          //                 ? FontWeight.bold
                          //                 : FontWeight.normal,
                          //               color: controller.selectedIndex.value == 1
                          //                 ? AppColors.primaryColor
                          //                 : AppColors.buttongroupBorder,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // )),

                          // Bottom Border line (commented out)
                          // Obx(() => Stack(
                          //   children: [
                          //     Container(
                          //       width: screenWidth,
                          //       height: 2,
                          //       color: Colors.grey.shade300,
                          //     ),
                          //     AnimatedPositioned(
                          //       duration: const Duration(milliseconds: 300),
                          //       left: controller.selectedIndex.value == 0 ? 0 : screenWidth / 2,
                          //       width: screenWidth / 2,
                          //       height: 2,
                          //       child: Container(color: AppColors.primaryColor),
                          //     ),
                          //   ],
                          // )),

                          padVertical(30),

                          // Form fields
                          Obx(() => Column(
                                children: [
                                  commonTxtField(
                                    controller: controller.nameController,
                                    isError: controller.isNameError.value,
                                    onChanged: controller.validateName,
                                    hTxt: AppLocalization.of(context)
                                        .translate('name'),
                                  ),
                                  padVertical(15),
                                  commonTxtField(
                                    controller: controller.lastNameController,
                                    isError: controller.isLastNameError.value,
                                    onChanged: controller.validateLastName,
                                    hTxt: AppLocalization.of(context)
                                        .translate('surname'),
                                  ),
                                  padVertical(15),
                                  commonTxtField(
                                    isError: controller.isEmailError.value,
                                    controller: controller.emailController,
                                    onChanged: controller.validateEmail,
                                    hTxt: AppLocalization.of(context)
                                        .translate('Email'),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  padVertical(15),
                                  // Password field
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: controller.isPassError.value
                                            ? AppColors.red
                                            : AppColors.inputBorder,
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller:
                                                controller.passwordController,
                                            onChanged:
                                                controller.validatePassword,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: AppLocalization.of(
                                                      context)
                                                  .translate('Makepassword'),
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
                                            obscureText:
                                                controller.passEye.value,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: controller.togglePassEye,
                                          child: Icon(
                                            controller.passEye.value
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
                                  // Confirm Password field
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: controller.isConfPass.value
                                            ? AppColors.red
                                            : AppColors.inputBorder,
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: controller
                                                .repPasswordController,
                                            onChanged: controller
                                                .validateConfirmPassword,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: AppLocalization.of(
                                                      context)
                                                  .translate('Repeatpassword'),
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
                                            obscureText:
                                                controller.comPassEye.value,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: controller.toggleComPassEye,
                                          child: Icon(
                                            controller.comPassEye.value
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: AppColors.buttongroupBorder,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Show phone field only if WhatsApp option is selected
                                  if (controller.selectedIndex.value == 1) ...[
                                    padVertical(15),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0),
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: AppColors.inputBorder,
                                              width: 2,
                                            ),
                                          ),
                                          child: CountryCodePicker(
                                            onChanged: (country) {
                                              controller.setCountryCode(
                                                  country.dialCode ?? "+1");
                                            },
                                            initialSelection: 'US',
                                            favorite: const ['+1', '+91'],
                                            showFlag: true,
                                            searchStyle: const TextStyle(
                                              fontFamily: AppConst.fontFamily,
                                              color: AppColors.blackColor,
                                              fontSize: 16,
                                            ),
                                            dialogTextStyle: const TextStyle(
                                              fontFamily: AppConst.fontFamily,
                                              color: AppColors.blackColor,
                                              fontSize: 15,
                                            ),
                                            headerTextStyle: const TextStyle(
                                              fontFamily: AppConst.fontFamily,
                                              color: AppColors.blackColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                            showDropDownButton: true,
                                            textStyle: const TextStyle(
                                              fontFamily: AppConst.fontFamily,
                                              color: AppColors.blackColor,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0),
                                          ),
                                        ),
                                        padHorizontal(10),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: AppColors.inputBorder,
                                                width: 2,
                                              ),
                                            ),
                                            child: TextField(
                                              controller:
                                                  controller.phoneController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    AppLocalization.of(context)
                                                        .translate('whatsup'),
                                                hintStyle: const TextStyle(
                                                  color: AppColors.inputBorder,
                                                  fontFamily:
                                                      AppConst.fontFamily,
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
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: Column(
                              children: [
                                padVertical(15),
                                // Signup button
                                commonButton(
                                  context: context,
                                  onPressed: () async {
                                    final connectivityResult =
                                        await Connectivity()
                                            .checkConnectivity();
                                    bool hasInternet = false;

                                    // Check if connected to Wi-Fi or mobile data
                                    if (connectivityResult.contains(
                                            ConnectivityResult.wifi) ||
                                        connectivityResult.contains(
                                            ConnectivityResult.mobile)) {
                                      try {
                                        // Verify actual internet access by pinging a server
                                        final result =
                                            await InternetAddress.lookup(
                                                'google.com');
                                        if (result.isNotEmpty &&
                                            result[0].rawAddress.isNotEmpty) {
                                          hasInternet = true;
                                        }
                                      } catch (_) {
                                        hasInternet = false;
                                      }
                                    }
                                    if (hasInternet) {
                                      FocusScope.of(context).unfocus();
                                      controller.signUp(context);
                                    } else {
                                      MotionToast.error(
                                        title: const Label(
                                          txt: "Signup Failed",
                                          type: TextTypes.f_15_500,
                                          forceColor: AppColors.whiteColor,
                                        ),
                                        description: Label(
                                          txt: "No Internet Connection",
                                          type: TextTypes.f_13_500,
                                          forceColor: AppColors.whiteColor,
                                        ),
                                        animationType:
                                            AnimationType.slideInFromBottom,
                                        toastAlignment: Alignment.topRight,
                                        dismissable: true,
                                      ).show(context);
                                    }
                                  },
                                  txt: AppLocalization.of(context)
                                      .translate('signup'),
                                ),
                                padVertical(10),
                                Align(
                                  alignment: Alignment.center,
                                  child: Label(
                                    txt: AppLocalization.of(context)
                                        .translate('orwithsocial'),
                                    type: TextTypes.f_15_400,
                                    forceColor: AppColors.socialTxt,
                                  ),
                                ),
                                padVertical(15),

                                // Social login options
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (Platform.isIOS)
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                        onTap: () => controller
                                            .signInWithGoogle(context),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                        ),
                                      ),
                                    padHorizontal(20),
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
                                        Icons.facebook,
                                        color: AppColors.facebook,
                                        size: 32,
                                      ),
                                    ),
                                  ],
                                ),
                                padVertical(15),

                                // Already registered section
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Label(
                                    txt: AppLocalization.of(context)
                                        .translate('alreadyregister'),
                                    type: TextTypes.f_17_400,
                                    forceAlignment: TextAlign.left,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: GestureDetector(
                                    onTap: () => {
                                      controller.emailController.text = "",
                                      controller.passwordController.text = "",
                                      controller.nameController.text = "",
                                      controller.lastNameController.text = "",
                                      controller.repPasswordController.text =
                                          "",
                                      Get.toNamed('/login')
                                    },
                                    child: Label(
                                      txt: AppLocalization.of(context)
                                          .translate('loginInto'),
                                      type: TextTypes.f_17_400,
                                      forceColor: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                                padVertical(15),

                                // Terms and conditions section
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          text: AppLocalization.of(context)
                                              .translate('byregister'),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: AppConst.fontFamily,
                                            color: AppColors.blackColor,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: AppLocalization.of(context)
                                                  .translate('agree'),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: AppConst.fontFamily,
                                              ),
                                            ),
                                            TextSpan(
                                              text: AppLocalization.of(context)
                                                  .translate('termofservice'),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: AppConst.fontFamily,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                Get.toNamed("/privacy",arguments: {"title":"Terms and Conditions"});

                                                }
                                            ),
                                            TextSpan(
                                              text: AppLocalization.of(context)
                                                  .translate('and'),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: AppConst.fontFamily,
                                              ),
                                            ),
                                            TextSpan(
                                              text: AppLocalization.of(context)
                                                  .translate('PrivacyPolicy'),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: AppConst.fontFamily,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Get.toNamed("/privacy",arguments: {"title":"Privacy Policy"});


                                                },
                                            ),
                                            TextSpan(
                                              text: AppLocalization.of(context)
                                                  .translate('byagree'),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: AppConst.fontFamily,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const PgSupport(),
                                          ),
                                        );
                                      },
                                      child: Label(
                                        txt: AppLocalization.of(context)
                                            .translate('support'),
                                        type: TextTypes.f_15_400,
                                        forceColor: AppColors.inputBorder,
                                      ),
                                    ),
                                  ],
                                ),
                                padVertical(10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom section with buttons
                ],
              ),
            ),

            // Loading overlay
            Obx(() => controller.isLoading.value
                ? const LoadingScreen()
                : Container()),
          ],
        ),
      ),
    );
  }
}
