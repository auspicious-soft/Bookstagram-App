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
import 'package:bookstagram/features/presentation/Pages/Dashboard/pg_dasboard.dart';
import 'package:bookstagram/features/presentation/Pages/Login/Widgets/forgot_email_sheet.dart';
import 'package:bookstagram/features/presentation/Pages/SIgnUp/pg_signup.dart';
// import 'package:bookstagram/features/presentation/providers/auth_facebook_login.dart';
import 'package:bookstagram/features/presentation/providers/auth_google_service.dart';
import 'package:bookstagram/features/presentation/providers/login_provider.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class PgLogin extends ConsumerStatefulWidget {
  const PgLogin({super.key});

  @override
  PgLoginState createState() => PgLoginState();
}

class PgLoginState extends ConsumerState<PgLogin> {
  final AuthGoogleService _authService = AuthGoogleService();
  int selectedIndex = 0;
  bool passEye = true;
  final emailController = TextEditingController();
  final restoreEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  bool isEmailError = false;
  bool isResEmailError = false;
  bool isPassError = false;
  bool isPhoneError = false;
  String countryCode = "";

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(loginFormNotifierProvider);
    final loginState = ref.watch(stateLoginNotifierProvider);

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

    final screenWidth = MediaQuery.of(context).size.width;
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
                                .translate('logintxt'),
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

                    padVertical(15),
                    selectedIndex == 0
                        ? Column(children: [
                            padVertical(15),
                            commonTxtField(
                                isError: isEmailError,
                                onChanged: (value) {
                                  setState(() {
                                    isEmailError =
                                        value.isEmpty || value.isInvalidEmail();
                                  });
                                },
                                controller: emailController,
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
                                      //  isError: isError,
                                      onChanged: (value) {
                                        setState(() {
                                          isPassError = value.isEmpty;
                                        });
                                      },
                                      controller: passwordController,
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
                                      )),
                                ],
                              ),
                            ),
                          ])
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                          color: isPhoneError
                                              ? AppColors.red
                                              : AppColors.inputBorder,
                                          // color: AppColors.inputBorder,
                                          width: 2,
                                        ),
                                      ),
                                      child: TextField(
                                        onChanged: (value) {
                                          setState(() {
                                            isPhoneError = value.isEmpty ||
                                                value.length < 10;
                                          });
                                        },
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
                    padVertical(20),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Label(
                        txt:
                            AppLocalization.of(context).translate('forgetpass'),
                        type: TextTypes.f_15_400,
                        forceAlignment: TextAlign.left,
                      ),
                      padHorizontal(3),
                      // forgotEmailformState.is
                      //     ? const LoadingScreen()
                      //     :

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            restoreEmailController.text = "";
                          });
                          showModalBottomSheet(
                            backgroundColor: AppColors.background,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            isScrollControlled: true,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setModalState) {
                                  return const ForgotPasswordSheet();
                                },
                              );
                            },
                          );
                        },
                        child: Label(
                          txt: AppLocalization.of(context).translate('restore'),
                          type: TextTypes.f_15_400,
                          forceColor: AppColors.primaryColor,
                        ),
                      ),
                    ]),
                  ])),
                ),
                // ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Column(children: [
                      padVertical(15),
                      commonButton(
                          context: context,
                          onPressed: () {
                            print(
                              selectedIndex == 0 ? "Email" : "Whatsapp",
                            );
                            FocusScope.of(context).unfocus();

                            final isValid = !formState.isEmailError &&
                                !formState.isPasswordError &&
                                emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty &&
                                !emailController.text.isInvalidEmail();
                            print(isValid);
                            if (isValid) {
                              ref
                                  .read(stateLoginNotifierProvider.notifier)
                                  .login(
                                      email: emailController.text,
                                      pass: passwordController.text,
                                      phoneNumber: "8437622493",
                                      language: "en",
                                      authType: selectedIndex == 0
                                          ? "Email"
                                          : "Whatsapp",
                                      onSuccess: (fineData) {
                                        goToDasboard(fineData, context);
                                      },
                                      context: context);
                            } else {
                              ref
                                  .read(loginFormNotifierProvider.notifier)
                                  .validateForm(emailController.text,
                                      passwordController.text);
                              MotionToast.error(
                                title: const Label(
                                  txt: "Error",
                                  type: TextTypes.f_15_500,
                                  forceColor: AppColors.whiteColor,
                                ),
                                description: const Label(
                                  txt: "The email or password is incorrect",
                                  type: TextTypes.f_13_500,
                                  forceColor: AppColors.whiteColor,
                                ),
                                animationType: AnimationType.fromTop,
                                position: MotionToastPosition.top,
                                dismissable: true,
                              ).show(context);
                            }
                          },
                          // onPressed: () => {
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => const PgDashBoard(),
                          //         ),
                          //       )
                          //     },
                          txt: AppLocalization.of(context).translate('Login')),
                      padVertical(25),
                      Align(
                          alignment: Alignment.center,
                          child: Label(
                            txt: AppLocalization.of(context)
                                .translate('orwithsocial'),
                            type: TextTypes.f_15_400,
                            forceColor: AppColors.socialTxt,
                          )),
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
                          GestureDetector(
                              onTap: () async {
                                // signInWithFacebook();
                                UserCredential? user =
                                    await signInWithFacebook();
                                if (user != null) {
                                  ref
                                      .read(stateLoginNotifierProvider.notifier)
                                      .login(
                                          email: user.user!.email.toString(),
                                          pass: " ",
                                          phoneNumber: "",
                                          language: "en",
                                          authType: "Facebook",
                                          onSuccess: (fineData) {
                                            goToDasboard(fineData, context);
                                          },
                                          context: context);
                                  print('Login successful: ${user.user}');
                                } else {
                                  print('Login failed');
                                }
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
                              )),
                        ],
                      ),
                      padVertical(25),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Label(
                              txt: AppLocalization.of(context)
                                  .translate('notreg'),
                              type: TextTypes.f_15_400,
                              forceAlignment: TextAlign.left,
                            ),
                            padHorizontal(3),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PgSignup(),
                                    ),
                                  );
                                },
                                child: Label(
                                  txt: AppLocalization.of(context)
                                      .translate('openaccount'),
                                  type: TextTypes.f_15_400,
                                  forceColor: AppColors.primaryColor,
                                )),
                          ]),
                      padVertical(20),
                    ]))
              ])),
          if (loginState.isLoading) const LoadingScreen(),
        ])));
  }

  void goToDasboard(LoginModel fineData, BuildContext context) async {
    await UserStorage.con.saveToken(fineData.data?.token);
    MotionToast.success(
      title: const Label(
        txt: "Success",
        type: TextTypes.f_15_500,
        forceColor: AppColors.whiteColor,
      ),
      description: const Label(
        txt: "Logged in successfully",
        type: TextTypes.f_13_500,
        forceColor: AppColors.whiteColor,
      ),
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.top,
      dismissable: true,
    ).show(context);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PgDashBoard()),
    );
  }
}
