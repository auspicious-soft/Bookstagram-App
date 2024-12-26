import 'package:bookstagram/Pages/Congratulation/pg_congratulation.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PgOtpVerification extends StatefulWidget {
  const PgOtpVerification({super.key});

  @override
  State<PgOtpVerification> createState() => _PgOtpVerificationState();
}

class _PgOtpVerificationState extends State<PgOtpVerification> {
  String otpCode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                        txt: AppLocalization.of(context).translate('verify'),
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
              width: MediaQuery.of(context).size.width / 1.5,
              child: PinCodeTextField(
                appContext: context,
                length: 4,
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
                ),
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
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PgCongratulation(),
                        ),
                      )
                    },
                txt: AppLocalization.of(context).translate('confirm')),
          ])))
        ],
      )),
    );
  }
}
