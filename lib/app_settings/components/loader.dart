import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background, // Background color
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Lottie.asset(
          delegates: LottieDelegates(
            values: [
              ValueDelegate.color(
                const ['**'],
                value: AppColors.primaryColor,
              ),
            ],
          ),
          AppAssets.loader,
          width: 150,
          height: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
