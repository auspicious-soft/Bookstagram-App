import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress; // Value between 0.0 and 1.0

  const CustomProgressBar({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.0,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: 8.0,
            decoration: BoxDecoration(
              color: AppColors.buttongroupBorder,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),

          FractionallySizedBox(
            widthFactor: progress,
            child: Container(
              height: 8.0,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          // Thumb circle
          Positioned(
            left: progress * MediaQuery.of(context).size.width / 1.1,
            child: Container(
              width: 16.0,
              height: 16.0,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
