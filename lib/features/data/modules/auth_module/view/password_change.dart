// views/change_pass_sheet.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';

import 'package:bookstagram/features/data/models/change_pass_model.dart';
import 'package:bookstagram/localization/app_localization.dart';

import '../controller/password_change_controller.dart';

class ChangePassSheet extends StatefulWidget {
  final String otp;


  const ChangePassSheet({super.key, required this.otp});

  @override
  State<ChangePassSheet> createState() => _ChangePassSheetState();
}

class _ChangePassSheetState extends State<ChangePassSheet> {
  final controller = Get.put(ChangePassController());

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
        child: SingleChildScrollView(
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
              Obx(() => _buildPasswordField(
                controller.newPassController,
                AppLocalization.of(context).translate('Password'),
                controller.passEye.value,
                controller.togglePassEye,
              )),
              padVertical(15),
              Label(
                txt: AppLocalization.of(context)
                    .translate('repeatnewpassword'),
                forceAlignment: TextAlign.center,
                type: TextTypes.f_13_400,
              ),
              padVertical(15),
              Obx(() => _buildPasswordField(
                controller.repPassController,
                AppLocalization.of(context).translate('Password'),
                controller.passEye2.value,
                controller.togglePassEye2,
              )),
              padVertical(40),
              Obx(() => controller.isLoading.value
                  ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              )
                  : commonButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  controller.changePassword(widget.otp, context);
                },
                context: context,
                txt: AppLocalization.of(context).translate('save'),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String hint,
      bool obscureText, VoidCallback toggleEye) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.inputBorder, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
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
              obscureText: obscureText,
            ),
          ),
          GestureDetector(
            onTap: toggleEye,
            child: Icon(
              obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.buttongroupBorder,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
