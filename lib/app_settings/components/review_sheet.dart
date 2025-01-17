import 'package:bookstagram/app_settings/components/label.dart';

import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';

class ReviewSheet extends StatefulWidget {
  @override
  _ReviewSheetState createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<ReviewSheet> {
  double rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtils.screenHeight(context) / 1.1,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  padVertical(10),
                  Label(
                    txt: AppLocalization.of(context).translate('review'),
                    type: TextTypes.f_17_500,
                  ),
                  padVertical(60),
                  Label(
                    txt: AppLocalization.of(context).translate('enjoybook'),
                    type: TextTypes.f_22_400,
                  ),
                  padVertical(20),
                  RatingBar(
                    alignment: Alignment.center,
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star,
                    onRatingChanged: (value) {
                      setState(() {
                        rating = value;
                      });
                    },
                    initialRating: 0,
                    maxRating: 5,
                    filledColor: Colors.amber,
                    emptyColor: AppColors.inputBorder,
                    size: 35,
                  ),
                  padVertical(30),
                  Label(
                    txt: AppLocalization.of(context).translate('taptorate'),
                    type: TextTypes.f_12_400,
                  ),
                  padVertical(15),
                  TextField(
                    controller: _reviewController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText:
                          AppLocalization.of(context).translate('writereview'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.blackColor,
                      fontFamily: AppConst.fontFamily,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            commonButton(
              context: context,
              onPressed: () {
                Navigator.pop(context);
              },
              txt: AppLocalization.of(context).translate('next'),
            ),
            padVertical(30)
          ],
        ),
      ),
    );
  }
}
