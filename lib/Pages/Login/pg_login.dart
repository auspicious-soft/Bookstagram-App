import 'package:bookstagram/Pages/Dashboard/pg_dasboard.dart';
import 'package:bookstagram/Pages/SIgnUp/pg_signup.dart';
import 'package:bookstagram/app_settings/components/common_textfield.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgLogin extends StatefulWidget {
  const PgLogin({super.key});

  @override
  State<PgLogin> createState() => _PgLoginState();
}

class _PgLoginState extends State<PgLogin> {
  int selectedIndex = 0;
  bool passEye = true;

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
                    padVertical(20),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Label(
                        txt:
                            AppLocalization.of(context).translate('forgetpass'),
                        type: TextTypes.f_15_400,
                        forceAlignment: TextAlign.left,
                      ),
                      padHorizontal(3),
                      GestureDetector(
                        onTap: () {
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
                                  return SizedBox(
                                    height:
                                        ScreenUtils.screenHeight(context) / 1.1,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 16,
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            padVertical(10),
                                            Center(
                                              child: Label(
                                                txt: AppLocalization.of(context)
                                                    .translate(
                                                        'Passwordrecovery'),
                                                type: TextTypes.f_17_500,
                                              ),
                                            ),
                                            padVertical(15),
                                            Center(
                                                child: Label(
                                              txt: AppLocalization.of(context)
                                                  .translate('restoretxt'),
                                              forceAlignment: TextAlign.center,
                                              type: TextTypes.f_13_400,
                                            )),
                                            padVertical(20),
                                            commonTxtField(
                                              hTxt: AppLocalization.of(context)
                                                  .translate('Email'),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                            ),
                                            padVertical(15),
                                            padVertical(20),
                                            commonButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                showModalBottomSheet(
                                                  backgroundColor:
                                                      AppColors.background,
                                                  context: context,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    20)),
                                                  ),
                                                  isScrollControlled: true,
                                                  builder: (context) {
                                                    bool passEye2 = true;

                                                    return StatefulBuilder(
                                                      builder: (BuildContext
                                                              context,
                                                          StateSetter
                                                              setModalState) {
                                                        return SizedBox(
                                                          height: ScreenUtils
                                                                  .screenHeight(
                                                                      context) /
                                                              1.1,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 16,
                                                              right: 16,
                                                              top: 16,
                                                              bottom: MediaQuery
                                                                      .of(context)
                                                                  .viewInsets
                                                                  .bottom,
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                padVertical(10),
                                                                Center(
                                                                  child: Label(
                                                                    txt: AppLocalization.of(
                                                                            context)
                                                                        .translate(
                                                                            'newpassword'),
                                                                    type: TextTypes
                                                                        .f_17_500,
                                                                  ),
                                                                ),
                                                                padVertical(15),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                                  child: Center(
                                                                    child:
                                                                        Label(
                                                                      txt: AppLocalization.of(
                                                                              context)
                                                                          .translate(
                                                                              'setnewpassword'),
                                                                      forceAlignment:
                                                                          TextAlign
                                                                              .center,
                                                                      type: TextTypes
                                                                          .f_34_500,
                                                                    ),
                                                                  ),
                                                                ),
                                                                padVertical(20),
                                                                Label(
                                                                  txt: AppLocalization.of(
                                                                          context)
                                                                      .translate(
                                                                          'newpassword'),
                                                                  forceAlignment:
                                                                      TextAlign
                                                                          .center,
                                                                  type: TextTypes
                                                                      .f_13_400,
                                                                ),
                                                                padVertical(15),
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15),
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: AppColors
                                                                          .inputBorder,
                                                                      width: 2,
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            TextField(
                                                                          decoration:
                                                                              InputDecoration(
                                                                            border:
                                                                                InputBorder.none,
                                                                            hintText:
                                                                                AppLocalization.of(context).translate('Password'),
                                                                            hintStyle:
                                                                                const TextStyle(
                                                                              color: AppColors.inputBorder,
                                                                              fontFamily: AppConst.fontFamily,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                AppColors.blackColor,
                                                                            fontFamily:
                                                                                AppConst.fontFamily,
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                          ),
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          obscureText:
                                                                              passEye2,
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setModalState(
                                                                              () {
                                                                            passEye2 =
                                                                                !passEye2;
                                                                          });
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          passEye2
                                                                              ? Icons.visibility_off_outlined
                                                                              : Icons.visibility_outlined,
                                                                          color:
                                                                              AppColors.buttongroupBorder,
                                                                          size:
                                                                              20,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                padVertical(15),
                                                                Label(
                                                                  txt: AppLocalization.of(
                                                                          context)
                                                                      .translate(
                                                                          'repeatnewpassword'),
                                                                  forceAlignment:
                                                                      TextAlign
                                                                          .center,
                                                                  type: TextTypes
                                                                      .f_13_400,
                                                                ),
                                                                padVertical(15),
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15),
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: AppColors
                                                                          .inputBorder,
                                                                      width: 2,
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            TextField(
                                                                          decoration:
                                                                              InputDecoration(
                                                                            border:
                                                                                InputBorder.none,
                                                                            hintText:
                                                                                AppLocalization.of(context).translate('Password'),
                                                                            hintStyle:
                                                                                const TextStyle(
                                                                              color: AppColors.inputBorder,
                                                                              fontFamily: AppConst.fontFamily,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                AppColors.blackColor,
                                                                            fontFamily:
                                                                                AppConst.fontFamily,
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                          ),
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          obscureText:
                                                                              passEye2,
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setModalState(
                                                                              () {
                                                                            passEye2 =
                                                                                !passEye2;
                                                                          });
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          passEye2
                                                                              ? Icons.visibility_off_outlined
                                                                              : Icons.visibility_outlined,
                                                                          color:
                                                                              AppColors.buttongroupBorder,
                                                                          size:
                                                                              20,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                padVertical(40),
                                                                commonButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  context:
                                                                      context,
                                                                  txt: AppLocalization.of(
                                                                          context)
                                                                      .translate(
                                                                          'save'),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              context: context,
                                              txt: AppLocalization.of(context)
                                                  .translate('restore'),
                                            ),
                                          ],
                                        )),
                                  );
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
                                    builder: (context) => const PgDashBoard(),
                                  ),
                                )
                              },
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
        ));
  }
}
