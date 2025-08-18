import 'dart:convert';

import 'package:bookstagram/app_settings/components/label.dart';

import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../features/data/modules/CourseModule/models/ReviewsModel.dart';
import '../constants/app_config.dart';

class ReviewSheet extends StatefulWidget {
  @override
  _ReviewSheetState createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<ReviewSheet> {
  double rating = 0;

  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  // Future<void> fetchReviews(String? id) async {
  //
  //   try {
  //     var data = await getReviewsDetail(id);
  //     ReviewResponse.value = data;
  //     ReviewResponse.refresh();
  //   } catch (e) {
  //     print("Error fetching books: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //
  // Future<Ratings> getReviewsDetail(String? id) async {
  //   try {
  //     final token = await getToken();
  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //       'role': 'admin',
  //       'x-client-type': 'mobile',
  //     };
  //
  //     HttpWithMiddleware httpClient = HttpWithMiddleware.build(
  //       middlewares: [HttpLogger(logLevel: LogLevel.BODY)],
  //     );
  //
  //     // Build the base URI string
  //     // String uri =
  //     //     '${AppConfig.baseUrl}${AppConfig.getBookMarketHome}?lang=${Uri.encodeComponent(selectedLanguage == "en" ? "eng" : selectedLanguage == "ru" ? "rus" : "kaz")}';
  //
  //     String uri = '${AppConfig.baseUrl}${AppConfig.ReviewsEndPoints}/$id';
  //
  //     final response = await httpClient.get(
  //       Uri.parse(uri),
  //       headers: headers,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final jsonBody = json.decode(response.body);
  //       return Ratings.fromJson(jsonBody);
  //     } else {
  //       throw Exception('Failed to fetch books: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print("API Error: $e");
  //     throw e;
  //   }
  // }
  //
  // Future<String> getToken() async {
  //   const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  //   final fullToken = await secureStorage.read(key: 'token');
  //   return fullToken ?? "";
  // }

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
