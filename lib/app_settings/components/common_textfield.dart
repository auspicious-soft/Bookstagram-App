import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:flutter/material.dart';

Widget commonTxtField({
  String? hTxt,
  keyboardType,
  controller,
  bool isError = false,
  Function(String)? onChanged,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: isError ? AppColors.red : AppColors.inputBorder,
        width: 2,
      ),
    ),
    child: TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hTxt,
        hintStyle: const TextStyle(
          fontSize: 15,
          color: AppColors.inputBorder,
          fontFamily: AppConst.fontFamily,
          fontWeight: FontWeight.w400,
        ),
      ),
      style: const TextStyle(
        fontSize: 15,
        color: AppColors.blackColor,
        fontFamily: AppConst.fontFamily,
        fontWeight: FontWeight.w400,
      ),
      keyboardType: keyboardType,
    ),
  );
}
