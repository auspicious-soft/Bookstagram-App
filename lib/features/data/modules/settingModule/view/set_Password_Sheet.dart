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
import '../controllers/setPassword.dart';

class SetPasswordSheet extends StatefulWidget {
  const SetPasswordSheet({super.key});

  @override
  State<SetPasswordSheet> createState() => SetPassSheetState();
}

class SetPassSheetState extends State<SetPasswordSheet> {
  final controller = Get.put(Setpassword());
  final _formKey = GlobalKey<FormState>(); // Added for form validation
  String? _errorMessage; // To store error message for display

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
          child: Form(
            key: _formKey, // Wrap content in Form for validation
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                padVertical(10),
                Center(
                  child: Label(
                    txt: AppLocalization.of(context).translate('changepass'),
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
                if (_errorMessage != null) ...[
                  padVertical(10),
                  Center(
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: Colors.red, // Define error color in AppColors
                        fontSize: 13,
                        fontFamily: AppConst.fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
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
                          setState(() {
                            _errorMessage = _validatePasswords(context);
                          });
                          if (_errorMessage == null) {
                            controller.ChangePassword();
                          }
                        },
                        context: context,
                        txt: AppLocalization.of(context).translate('save'),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validatePasswords(BuildContext context) {
    final newPassword = controller.newPassController.text;
    final repeatPassword = controller.repPassController.text;

    if (newPassword.isEmpty || repeatPassword.isEmpty) {
      return AppLocalization.of(context).translate('password_empty');
    }
    if (newPassword != repeatPassword) {
      return AppLocalization.of(context).translate('password_mismatch');
    }
    return null;
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
