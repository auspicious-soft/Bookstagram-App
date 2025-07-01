import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({
    super.key,
    required this.txt,
    required this.type,
    this.forceAlignment = TextAlign.start,
    this.scale,
    this.forceColor = AppColors.blackColor,
    this.maxWidth, // New parameter for maximum width
    this.maxLines = 2, // Default to 1 line, can be overridden
  });

  final String txt;
  final TextTypes type;
  final Color forceColor;
  final TextAlign forceAlignment;
  final TextScaler? scale;
  final double? maxWidth; // Maximum width for text
  final int? maxLines; // Maximum number of lines

  @override
  Widget build(BuildContext context) {
    Widget textWidget = Text(
      txt,
      textScaler: scale,
      textAlign: forceAlignment,
      style: fontStyle(),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      // Truncate with ellipsis if text overflows
      softWrap: true, // Allow wrapping if maxLines > 1
    );

    // Apply width constraint if maxWidth is provided
    if (maxWidth != null) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth!),
        child: textWidget,
      );
    }

    return textWidget;
  }

  TextStyle fontStyle() {
    FontWeight weight = FontWeight.normal;
    double size = 11.0;
    FontStyle fontStyle = FontStyle.normal;
    TextDecoration decoration = TextDecoration.none;
    switch (type) {
      case TextTypes.f_17_700:
        weight = FontWeight.w700;
        size = 17;
        break;
      case TextTypes.f_17_400:
        weight = FontWeight.w400;
        size = 17;
        break;
      case TextTypes.f_23_400:
        weight = FontWeight.w400;
        size = 23;
        break;
      case TextTypes.f_20_700:
        weight = FontWeight.w700;
        size = 20;
        break;
      case TextTypes.f_15_300:
        weight = FontWeight.w300;
        size = 15;
        break;
      case TextTypes.f_36_700:
        weight = FontWeight.w700;
        size = 36;
        break;
      case TextTypes.f_24_400:
        weight = FontWeight.w400;
        size = 24;
        break;
      case TextTypes.f_22_500:
        weight = FontWeight.w500;
        size = 22;
        break;
      case TextTypes.f_15_400:
        weight = FontWeight.w400;
        size = 15;
        break;
      case TextTypes.f_22_700:
        weight = FontWeight.w700;
        size = 22;
        break;
      case TextTypes.f_18_400:
        weight = FontWeight.w400;
        size = 18;
        break;
      case TextTypes.f_13_400:
        weight = FontWeight.w400;
        size = 13;
        break;
      case TextTypes.f_28_400:
        weight = FontWeight.w400;
        size = 28;
        break;
      case TextTypes.f_20_300:
        weight = FontWeight.w300;
        size = 20;
        break;
      case TextTypes.f_21_500:
        weight = FontWeight.w500;
        size = 21.5;
        break;
      case TextTypes.f_15_500:
        weight = FontWeight.w500;
        size = 15;
        break;
      case TextTypes.f_17_500:
        weight = FontWeight.w500;
        size = 17;
        break;
      case TextTypes.f_34_500:
        weight = FontWeight.w500;
        size = 34;
        break;
      case TextTypes.f_20_500:
        weight = FontWeight.w500;
        size = 20;
        break;
      case TextTypes.f_20_500i:
        weight = FontWeight.w500;
        size = 20;
        fontStyle = FontStyle.italic;
        break;
      case TextTypes.f_32_500:
        weight = FontWeight.w500;
        size = 32;
        break;
      case TextTypes.f_10_500:
        weight = FontWeight.w500;
        size = 10;
        break;
      case TextTypes.f_12_400:
        weight = FontWeight.w400;
        size = 12;
        break;
      case TextTypes.f_13_500:
        weight = FontWeight.w500;
        size = 13;
        break;
      case TextTypes.f_11_500:
        weight = FontWeight.w500;
        size = 11;
        break;
      case TextTypes.f_34_700:
        weight = FontWeight.w700;
        size = 34;
        break;
      case TextTypes.f_16_500:
        weight = FontWeight.w500;
        size = 16;
        break;
      case TextTypes.f_16_300:
        weight = FontWeight.w300;
        size = 16;
        break;
      case TextTypes.f_22_400:
        weight = FontWeight.w400;
        size = 22;
        break;
      case TextTypes.f_13_600:
        weight = FontWeight.w600;
        size = 13;
        break;
      case TextTypes.f_32_700:
        weight = FontWeight.w700;
        size = 32;
        break;
      case TextTypes.f_28_700:
        weight = FontWeight.w700;
        size = 28;
        break;
      case TextTypes.f_18_700:
        weight = FontWeight.w700;
        size = 18;
        break;
      case TextTypes.f_16_700:
        weight = FontWeight.w700;
        size = 16;
        break;
      case TextTypes.f_70_700:
        weight = FontWeight.w500;
        size = 72;
        break;
    }

    return TextStyle(
      color: forceColor,
      fontFamily: AppConst.fontFamily,
      fontWeight: weight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontSize: size,
    );
  }
}

enum TextTypes {
  f_17_700,
  f_17_400,
  f_23_400,
  f_20_700,
  f_20_300,
  f_15_300,
  f_36_700,
  f_24_400,
  f_22_500,
  f_15_400,
  f_22_700,
  f_18_400,
  f_18_700,
  f_13_400,
  f_28_400,
  f_28_700,
  f_21_500,
  f_15_500,
  f_17_500,
  f_34_500,
  f_34_700,
  f_32_500,
  f_20_500,
  f_20_500i,
  f_10_500,
  f_11_500,
  f_12_400,
  f_13_500,
  f_13_600,
  f_16_500,
  f_16_700,
  f_16_300,
  f_22_400,
  f_32_700,
  f_70_700,
}
