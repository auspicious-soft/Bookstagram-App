import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/features/presentation/Pages/onboarding/Widgets/scrolling_text_widget.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/onboarding_controller.dart';



class PgOnboarding extends GetView<OnboardingController> {
  const PgOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.background,
              fit: BoxFit.cover,
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                padVertical(80),
                const Spacer(),
                ScrollingTextRow(items: [
                  '🎧 ${AppLocalization.of(context).translate('Audiobooks')}',
                  '📖 ${AppLocalization.of(context).translate('ebooks')}',
                  '📔 ${AppLocalization.of(context).translate('magazines')}'
                ], moveLeft: true),
                ScrollingTextRow(items: [
                  '🎓 ${AppLocalization.of(context).translate('Courses')}',
                  '💼 ${AppLocalization.of(context).translate('masterclasses')}',
                  '🎙️ ${AppLocalization.of(context).translate('podcasts')}',
                ], moveLeft: true),
                ScrollingTextRow(items: [
                  '🔖 ${AppLocalization.of(context).translate('events')}',
                  '💡 ${AppLocalization.of(context).translate('lifehacks')}',
                  '📚 ${AppLocalization.of(context).translate('summary')}'
                ], moveLeft: true),
                const Spacer(),
                padVertical(20),
                _buildTextSection(context),
                padVertical(20),
                const Spacer(),
                _buildBottomButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextSection(BuildContext context) {
    return Column(
      children: [
        padVertical(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Label(
            txt: AppLocalization.of(context).translate('bookchange'),
            forceAlignment: TextAlign.center,
            type: TextTypes.f_28_700,
            forceColor: AppColors.browsetxt,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Column(
      children: [
        commonButton(
          txt: AppLocalization.of(Get.context!).translate('Login'),
          context: Get.context!,
          onPressed: controller.navigateToLogin,
        ),
        padVertical(10),
        GestureDetector(
          onTap: controller.navigateToSignup,
          child: Label(
            txt: AppLocalization.of(Get.context!).translate('Registration'),
            type: TextTypes.f_17_400,
            forceColor: AppColors.primaryColor,
          ),
        ),
        padVertical(10),
      ],
    );
  }
}