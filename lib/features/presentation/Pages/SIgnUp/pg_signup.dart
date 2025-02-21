import 'dart:io';
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
import 'package:bookstagram/features/data/datasources/user_storage.dart';
import 'package:bookstagram/features/data/models/login_model.dart';
import 'package:bookstagram/features/data/models/signup_model.dart';
import 'package:bookstagram/features/presentation/Pages/Congratulation/pg_congratulation.dart';
import 'package:bookstagram/features/presentation/Pages/Login/pg_login.dart';
import 'package:bookstagram/features/presentation/Pages/OtpVerification/pg_otp_verification.dart';
import 'package:bookstagram/features/presentation/providers/auth_google_service.dart';
import 'package:bookstagram/features/presentation/providers/login_provider.dart';
import 'package:bookstagram/features/presentation/providers/signup_provider.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';

class PgSignup extends ConsumerStatefulWidget {
  const PgSignup({super.key});

  @override
  PgSignupState createState() => PgSignupState();
}

class PgSignupState extends ConsumerState<PgSignup> {
  int selectedIndex = 0;
  bool passEye = true;
  bool comPassEye = true;
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final AuthGoogleService _authService = AuthGoogleService();
  bool isEmailError = false;
  bool isNameError = false;
  bool isLastNameError = false;
  bool isPassError = false;
  bool isConfPass = false;
  bool isPhoneError = false;
  String countryCode = "";
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final formState = ref.watch(signUpFormNotifierProvider);
    final signUpState = ref.watch(stateSignUpNotifierProvider);
    final loginState = ref.watch(stateLoginNotifierProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (signUpState.hasError) {
        // print('${signUpState}error');
        MotionToast.error(
          title: const Label(
            txt: "Error",
            type: TextTypes.f_15_500,
            forceColor: AppColors.whiteColor,
          ),
          description: Label(
            txt: "${signUpState.error}",
            type: TextTypes.f_13_500,
            forceColor: AppColors.whiteColor,
          ),
          animationType: AnimationType.fromTop,
          position: MotionToastPosition.top,
          dismissable: true,
        ).show(context);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loginState.hasError) {
        MotionToast.error(
          title: const Label(
            txt: "Error",
            type: TextTypes.f_15_500,
            forceColor: AppColors.whiteColor,
          ),
          description: Label(
            txt: "${loginState.error}",
            type: TextTypes.f_13_500,
            forceColor: AppColors.whiteColor,
          ),
          animationType: AnimationType.fromTop, // Use the prefix here
          position: MotionToastPosition.top,
          dismissable: true,
        ).show(context);
      }
    });
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
            child: Stack(children: [
          WidgetGlobalMargin(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                    padVertical(30),
                    Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Label(
                            txt: AppLocalization.of(context)
                                .translate('Mailorwhatsup'),
                            type: TextTypes.f_21_500)),
                    padVertical(30),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedIndex = 0),
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalization.of(context).translate('email'),
                                style: TextStyle(
                                  fontFamily: AppConst.fontFamily,
                                  fontSize: 16,
                                  fontWeight: selectedIndex == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: selectedIndex == 0
                                      ? AppColors.primaryColor
                                      : AppColors.buttongroupBorder,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedIndex = 1),
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalization.of(context)
                                    .translate('WhatsApp'),
                                style: TextStyle(
                                  fontFamily: AppConst.fontFamily,
                                  fontSize: 16,
                                  fontWeight: selectedIndex == 1
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: selectedIndex == 1
                                      ? AppColors.primaryColor
                                      : AppColors.buttongroupBorder,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Bottom Border line
                    Stack(
                      children: [
                        Container(
                          width: screenWidth,
                          height: 2,
                          color: Colors.grey.shade300,
                        ),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          left: selectedIndex == 0 ? 0 : screenWidth / 2,
                          width: screenWidth / 2,
                          height: 2,
                          child: Container(color: AppColors.primaryColor),
                        ),
                      ],
                    ),

                    padVertical(30),
                    selectedIndex == 0
                        ? Column(children: [
                            commonTxtField(
                                controller: nameController,
                                isError: isNameError,
                                onChanged: (value) {
                                  setState(() {
                                    isNameError = value.isEmpty;
                                  });
                                },
                                hTxt: AppLocalization.of(context)
                                    .translate('name')),
                            padVertical(15),
                            commonTxtField(
                                controller: lastNameController,
                                isError: isLastNameError,
                                onChanged: (value) {
                                  setState(() {
                                    isLastNameError = value.isEmpty;
                                  });
                                },
                                hTxt: AppLocalization.of(context)
                                    .translate('surname')),
                            padVertical(15),
                            commonTxtField(
                                isError: isEmailError,
                                controller: emailController,
                                onChanged: (value) {
                                  setState(() {
                                    isEmailError =
                                        value.isEmpty || value.isInvalidEmail();
                                  });
                                },
                                hTxt: AppLocalization.of(context)
                                    .translate('Email'),
                                keyboardType: TextInputType.emailAddress),
                            padVertical(15),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isPassError
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
                                        setState(() {
                                          isPassError = value.isEmpty;
                                        });
                                      },
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: AppLocalization.of(context)
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
                                      )),
                                ],
                              ),
                            ),
                            padVertical(15),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isConfPass
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
                                        if (value != passwordController.text) {
                                          setState(() {
                                            isConfPass = true;
                                          });
                                        } else {
                                          setState(() {
                                            isConfPass = false;
                                          });
                                        }
                                      },
                                      controller: repPasswordController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: AppLocalization.of(context)
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
                                      obscureText: comPassEye,
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          comPassEye = !comPassEye;
                                        });
                                      },
                                      child: Icon(
                                        comPassEye
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: AppColors.buttongroupBorder,
                                        size: 20,
                                      )),
                                ],
                              ),
                            ),
                          ])
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonTxtField(
                                isError: isNameError,
                                onChanged: (value) {
                                  setState(() {
                                    isNameError = value.isEmpty;
                                  });
                                },
                                controller: nameController,
                                hTxt: AppLocalization.of(context)
                                    .translate('name'),
                              ),
                              padVertical(15),
                              commonTxtField(
                                  controller: lastNameController,
                                  isError: isLastNameError,
                                  onChanged: (value) {
                                    setState(() {
                                      isLastNameError = value.isEmpty;
                                    });
                                  },
                                  hTxt: AppLocalization.of(context)
                                      .translate('surname')),
                              padVertical(15),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
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
                                        setState(() {
                                          countryCode =
                                              country.dialCode.toString();
                                        });
                                        print(
                                            "Selected country code: ${country.dialCode}");
                                      },
                                      initialSelection: 'US',
                                      favorite: const ['+1', '+91'],
                                      showFlag: true,
                                      searchStyle: const TextStyle(
                                          fontFamily: AppConst.fontFamily,
                                          color: AppColors.blackColor,
                                          fontSize: 16),
                                      dialogTextStyle: const TextStyle(
                                          fontFamily: AppConst.fontFamily,
                                          color: AppColors.blackColor,
                                          fontSize: 15),
                                      headerTextStyle: const TextStyle(
                                          fontFamily: AppConst.fontFamily,
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      showDropDownButton: true,
                                      textStyle: const TextStyle(
                                          fontFamily: AppConst.fontFamily,
                                          color: AppColors.blackColor),
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
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppColors.inputBorder,
                                          width: 2,
                                        ),
                                      ),
                                      child: TextField(
                                        controller: phoneController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: AppLocalization.of(context)
                                              .translate('whatsup'),
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
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ])),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Column(children: [
                      padVertical(15),
                      commonButton(
                          context: context,
                          onPressed: () {
                            FocusScope.of(context).unfocus();

                            final isValid = !formState.isEmailError &&
                                !formState.isPasswordError &&
                                nameController.text.isNotEmpty &&
                                lastNameController.text.isNotEmpty &&
                                emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty &&
                                repPasswordController.text.isNotEmpty &&
                                !emailController.text.isInvalidEmail();
                            print(isValid);
                            if (isValid) {
                              ref
                                  .read(stateSignUpNotifierProvider.notifier)
                                  .signUp(
                                      email: emailController.text,
                                      countryCode: countryCode,
                                      phoneNumber: phoneController.text,
                                      fullname:
                                          "${nameController.text} ${lastNameController.text}",
                                      firstname: nameController.text,
                                      lastname: lastNameController.text,
                                      pass: passwordController.text,
                                      language: "eng",
                                      authType: selectedIndex == 0
                                          ? "Email"
                                          : "Whatsapp",
                                      onSuccess: (fineData) {
                                        goToOtpScreen(fineData, context);
                                      },
                                      context: context);
                            } else {
                              ref
                                  .read(signUpFormNotifierProvider.notifier)
                                  .validateForm(emailController.text,
                                      passwordController.text);
                              MotionToast.error(
                                title: const Label(
                                  txt: "Error",
                                  type: TextTypes.f_15_500,
                                  forceColor: AppColors.whiteColor,
                                ),
                                description: const Label(
                                  txt: "All feilds are required !!",
                                  type: TextTypes.f_13_500,
                                  forceColor: AppColors.whiteColor,
                                ),
                                animationType: AnimationType.fromTop,
                                position: MotionToastPosition.top,
                                dismissable: true,
                              ).show(context);
                            }
                          },
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         const PgOtpVerification(),
                          //   ),
                          // )

                          txt: AppLocalization.of(context).translate('signup')),
                      padVertical(10),
                      Align(
                          alignment: Alignment.center,
                          child: Label(
                            txt: AppLocalization.of(context)
                                .translate('orwithsocial'),
                            type: TextTypes.f_15_400,
                            forceColor: AppColors.socialTxt,
                          )),
                      padVertical(15),
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
                                onTap: () async {
                                  var user =
                                      await _authService.signInWithGoogle();
                                  // print(user);
                                  if (user != null) {
                                    ref
                                        .read(
                                            stateLoginNotifierProvider.notifier)
                                        .login(
                                            email: user.email.toString(),
                                            pass: " ",
                                            phoneNumber: "",
                                            language: "en",
                                            authType: "Google",
                                            onSuccess: (fineData) {
                                              goToDasboard(fineData, context);
                                            },
                                            context: context);
                                  }
                                },
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
                                )),
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
                      Align(
                          alignment: Alignment.topLeft,
                          child: Label(
                            txt: AppLocalization.of(context)
                                .translate('alreadyregister'),
                            type: TextTypes.f_17_400,
                            forceAlignment: TextAlign.left,
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PgLogin(),
                                  ),
                                );
                              },
                              child: Label(
                                txt: AppLocalization.of(context)
                                    .translate('loginInto'),
                                type: TextTypes.f_17_400,
                                forceColor: AppColors.primaryColor,
                              ))),
                      padVertical(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
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
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print("termofservice!");
                                    },
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
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print("privay!");
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
                          Label(
                            txt: AppLocalization.of(context)
                                .translate('support'),
                            type: TextTypes.f_15_400,
                            forceColor: AppColors.inputBorder,
                          ),
                        ],
                      ),
                      padVertical(10),
                    ])),
              ])),
          if (signUpState.isLoading) const LoadingScreen(),
          if (loginState.isLoading) const LoadingScreen(),
        ])));
  }

  void goToOtpScreen(SignUpModel fineData, BuildContext context) async {
    print(fineData.data);
    MotionToast.success(
      title: const Label(
        txt: "Success",
        type: TextTypes.f_15_500,
        forceColor: AppColors.whiteColor,
      ),
      description: Label(
        txt: "${fineData.message}",
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
          builder: (context) => PgOtpVerification(
              type: selectedIndex == 0
                  ? emailController.text
                  : phoneController.text)),
    );
  }

  void goToDasboard(LoginModel fineData, BuildContext context) async {
    await UserStorage.con.saveToken(fineData.data?.token);
    MotionToast.success(
      title: const Label(
        txt: "Success",
        type: TextTypes.f_15_500,
        forceColor: AppColors.whiteColor,
      ),
      description: Label(
        txt: "${fineData.message}",
        type: TextTypes.f_13_500,
        forceColor: AppColors.whiteColor,
      ),
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.top,
      dismissable: true,
    ).show(context);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PgCongratulation()),
    );
  }
}
