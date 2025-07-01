import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../app_settings/constants/app_colors.dart';
import '../../../localization/app_localization.dart';

class FeatureButton extends StatelessWidget {
  final String imagePath;
  final String labelKey;
  final VoidCallback onTap;
  final double? size; // Optional, will fallback to screen width

  const FeatureButton({
    super.key,
    required this.imagePath,
    required this.labelKey,
    required this.onTap,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width-80;
    final double buttonSize = size ?? screenWidth * 0.25; // 28% of screen width

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: buttonSize,
        width: buttonSize,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: buttonSize * 0.20,
              width: buttonSize * 0.20,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 6),
            Text(
              AppLocalization.of(context).translate(labelKey),
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(fontSize: 12),
            ).paddingSymmetric(horizontal: 10),
          ],
        ),
      ),
    );
  }
}
