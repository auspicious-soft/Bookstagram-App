import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:url_launcher/url_launcher.dart';

void openUrl(String url, BuildContext context) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    MotionToast.error(
      title: const Label(
        txt: "Error",
        type: TextTypes.f_15_500,
        forceColor: AppColors.whiteColor,
      ),
      description: Label(
        txt: "Could not launch $url",
        type: TextTypes.f_13_500,
        forceColor: AppColors.whiteColor,
      ),
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.top,
      dismissable: true,
    ).show(context);
  }
  // });
  print("Could not launch $url");
}

Widget buildContactItem(
    IconData icon, String label, String url, BuildContext context) {
  return GestureDetector(
    onTap: () => openUrl(url, context),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.border,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon),
            padHorizontal(10),
            Label(txt: label, type: TextTypes.f_18_700),
          ],
        ),
      ),
    ),
  );
}
