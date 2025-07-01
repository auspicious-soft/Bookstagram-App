import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:flutter/material.dart';

Widget commonButton(
    {VoidCallback? onPressed,
    String? txt,
    context,
    Color? forceColor,
    bool? arrow}) {
  return Align(
      alignment: Alignment.center,
      child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width / 1.1,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              backgroundColor: forceColor ?? AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: arrow == true
                ? const Icon(
                    Icons.arrow_forward,
                    color: AppColors.whiteColor,
                  )
                : Label(
                    txt: txt!,
                    type: TextTypes.f_17_500,
                    forceColor: AppColors.whiteColor,
                  ),
          )));
}
