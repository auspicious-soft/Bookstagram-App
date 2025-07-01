import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/features/presentation/Pages/About/Widgets/webview.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// Binding class for dependency injection
class AboutUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutUsController>(() => AboutUsController());
  }
}

// Controller for GetX
class AboutUsController extends GetxController {
  // Reactive variable to track language code
  final languageCode = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize language code based on current locale
    languageCode.value = Get.locale?.languageCode ?? '';
  }

  // Method to get web links based on language
  List<Map<String, String>> getWebLinks() {
    languageCode.value = Get.locale?.languageCode ?? '';
    switch (languageCode.value) {
      case 'en':
        return webLinksEnglish;
      case 'kk':
        return webLinksKazak;
      case 'ru':
        return webLinksrus;
      default:
        return webLinksEnglish; // Fallback to English
    }
  }

  // Optional: Method to update language
  void updateLanguage(String newLanguageCode) {
    languageCode.value = newLanguageCode;
  }
}

// Define web links
final List<Map<String, String>> webLinksEnglish = [
  {'title': 'aboutproject', 'url': 'https://bookstagram.kz/en/about'},
  {'title': 'Copyright', 'url': 'https://bookstagram.kz/en/copyright'},
  {'title': 'Partners', 'url': 'https://bookstagram.kz/en/partners'},
  {'title': 'privacypolicy', 'url': 'https://bookstagram.kz/en/privacy'},
  {'title': 'conditionsuse', 'url': 'https://bookstagram.kz/en/conditions-of-use'},
  {'title': 'offerta', 'url': 'https://bookstagram.kz/en/offerta'},
  {'title': 'forinvestors', 'url': 'https://bookstagram.kz/en/investors'},
  {'title': 'applicationcooperation', 'url': 'https://bookstagram.kz/en/cooperation'},
];

final List<Map<String, String>> webLinksKazak = [
  {'title': 'aboutproject', 'url': 'https://bookstagram.kz/kz/about'},
  {'title': 'Copyright', 'url': 'https://bookstagram.kz/kz/copyright'},
  {'title': 'Partners', 'url': 'https://bookstagram.kz/kz/partners'},
  {'title': 'privacypolicy', 'url': 'https://bookstagram.kz/kz/privacy'},
  {'title': 'conditionsuse', 'url': 'https://bookstagram.kz/kz/conditions-of-use'},
  {'title': 'offerta', 'url': 'https://bookstagram.kz/kz/offerta'},
  {'title': 'forinvestors', 'url': 'https://bookstagram.kz/kz/investors'},
  {'title': 'applicationcooperation', 'url': 'https://bookstagram.kz/kz/cooperation'},
];

final List<Map<String, String>> webLinksrus = [
  {'title': 'aboutproject', 'url': 'https://bookstagram.kz/ru/about'},
  {'title': 'Copyright', 'url': 'https://bookstagram.kz/ru/copyright'},
  {'title': 'Partners', 'url': 'https://bookstagram.kz/ru/partners'},
  {'title': 'privacypolicy', 'url': 'https://bookstagram.kz/ru/privacy'},
  {'title': 'conditionsuse', 'url': 'https://bookstagram.kz/ru/conditions-of-use'},
  {'title': 'offerta', 'url': 'https://bookstagram.kz/ru/offerta'},
  {'title': 'forinvestors', 'url': 'https://bookstagram.kz/ru/investors'},
  {'title': 'applicationcooperation', 'url': 'https://bookstagram.kz/ru/cooperation'},
];

// GetView for the About Us page
class PgAboutUs extends GetView<AboutUsController> {
  const PgAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    // Set full-screen mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Transparent status bar
          statusBarIconBrightness: Brightness.dark, // Dark icons for status bar
          systemNavigationBarColor: AppColors.background, // Match nav bar to background
        ),
        child: WidgetGlobalMargin(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// App Bar Row
              Padding(
                padding: const EdgeInsets.only(top: 16.0), // Adjust for status bar
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Restore system UI when navigating back
                        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Label(
                      txt: AppLocalization.of(context).translate('bookstagram_about'),
                      type: TextTypes.f_20_500,
                    ),
                    const Label(txt: "   ", type: TextTypes.f_20_500),
                  ],
                ),
              ),

              padVertical(20),

              /// Logo
              Center(
                child: Image.asset(
                  AppAssets.logo,
                  fit: BoxFit.contain,
                  width: ScreenUtils.screenWidth(context) / 1.6,
                  height: 175,
                ),
              ),

              padVertical(20),

              const Center(
                child: Label(
                  txt: "Bookstagram v1.1.1",
                  type: TextTypes.f_22_400,
                ),
              ),

              padVertical(5),
              const Divider(),
              padVertical(10),

              /// List of Links
              Expanded(
                child: Obx(() => ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: controller.getWebLinks().length,
                  separatorBuilder: (context, index) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final items = controller.getWebLinks()[index];

                    return GestureDetector(
                      onTap: ()async {
                        final item = controller.getWebLinks()[index];
                        print(item['url']);
                        if (item['url']!.startsWith('http')) {
                          Get.to(() => WebViewScreen(
                            title: AppLocalization.of(context).translate(item['title']!),
                            url: item['url']!,
                          ));
                        } else {
                          Get.snackbar('Error', 'Invalid URL');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Label(
                            txt: AppLocalization.of(context).translate(items['title']!),
                            type: TextTypes.f_17_500,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          ),
                        ],
                      ),
                    );
                  },
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}