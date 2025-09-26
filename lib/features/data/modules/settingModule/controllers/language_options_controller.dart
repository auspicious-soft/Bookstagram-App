import 'dart:convert';

import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../models/level_Response_Model.dart';

class LanguageOptionsController extends GetxController {
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }
}
