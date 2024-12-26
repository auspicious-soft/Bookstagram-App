import 'package:bookstagram/Pages/Login/pg_login.dart';
import 'package:bookstagram/Pages/OtpVerification/pg_otp_verification.dart';
import 'package:bookstagram/app_settings/components/common_textfield.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PgSignup extends StatefulWidget {
  const PgSignup({super.key});

  @override
  State<PgSignup> createState() => _PgSignupState();
}

class _PgSignupState extends State<PgSignup> {
  int selectedIndex = 0;
  bool passEye = true;
  bool comPassEye = true;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: WidgetGlobalMargin(
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
                                hTxt: AppLocalization.of(context)
                                    .translate('name')),
                            padVertical(15),
                            commonTxtField(
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
                                  color: AppColors.inputBorder,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
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
                                  color: AppColors.inputBorder,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
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
                                hTxt: AppLocalization.of(context)
                                    .translate('name'),
                              ),
                              padVertical(15),
                              Row(
                                children: [
                                  Container(
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
                                    child: const Align(
                                        alignment: Alignment.center,
                                        child: Label(
                                          txt: "+7",
                                          type: TextTypes.f_15_500,
                                        )),
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
                          onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PgOtpVerification(),
                                  ),
                                )
                              },
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
                          padHorizontal(20),
                          Container(
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
                    ]))
              ])),
        ));
  }
}
