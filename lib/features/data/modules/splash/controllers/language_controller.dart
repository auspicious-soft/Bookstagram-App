import 'dart:ui';
import 'package:bookstagram/main.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../localization/no_internet_screen.dart';

class LanguageController extends GetxController {

  final List<Map<String, dynamic>> languages = [
    {"title": "Қазақ", "code": "kk"},
    {"title": "Русский", "code": "ru"},
    {"title": "English", "code": "en"},
  ];

  var selectedLanguageCode = "en".obs;

  @override
  void onInit() {
    _loadSavedLanguage();
    Get.put(ConnectivityController());
    super.onInit();
  }

  void changeLanguage(String code) async {
    selectedLanguageCode.value = code;
    MyApp.setLocale(Get.context!, Locale(code, ''));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language_code', code);
  }

  void navigateBack() {
    changeLanguage(selectedLanguageCode.value);
    print(">>>>>>>>>${Get.previousRoute}");
    if (Get.previousRoute == "/splash"||Get.previousRoute == "/language") {
      print("back>>>>>>>>");
      Get.toNamed("/onboarding");
    } else if (Get.previousRoute == "/language") {
      print("back>>>>>>>>");
      Get.toNamed("/onboarding");
    }else {
      Get.back();
    }
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedCode = prefs.getString('selected_language_code');
    if (savedCode != null && savedCode != selectedLanguageCode.value) {
      selectedLanguageCode.value = savedCode;
      MyApp.setLocale(Get.context!, Locale(savedCode));
    }
  }
}
