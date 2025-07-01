import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bookstagram/app_settings/components/common_textfield.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/extensions/extend_string.dart';
import 'package:bookstagram/localization/app_localization.dart';

import '../../../../../app_settings/constants/helpers.dart';
import '../controller/forget_password_controller.dart';

class ForgotPasswordSheet extends StatelessWidget {
  ForgotPasswordSheet({Key? key}) : super(key: key);

  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtils.screenHeight(context) / 1.1,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            padVertical(10),
            Center(
              child: Label(
                txt: AppLocalization.of(context).translate('Passwordrecovery'),
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
            Obx(() => commonTxtField(
              isError: controller.isEmailError.value,
              onChanged: (value) {
                controller.isEmailError.value =
                    value.isEmpty || value.isInvalidEmail();
              },
              controller: controller.emailController,
              hTxt: AppLocalization.of(context).translate('Email'),
              keyboardType: TextInputType.emailAddress,
            )),
            padVertical(15),
            Obx(() => controller.isLoading.value
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
                controller.forgotPassEmail(context: context);
              },
              context: context,
              txt: AppLocalization.of(context).translate('restore'),
            )),
          ],
        ),
      ),
    );
  }
}
