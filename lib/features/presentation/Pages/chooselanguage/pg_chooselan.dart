import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/features/presentation/Pages/onboarding/pg_onboarding.dart';
import 'package:bookstagram/main.dart';
import 'package:flutter/material.dart';

class PgChooselan extends StatefulWidget {
  const PgChooselan({super.key});

  @override
  State<PgChooselan> createState() => _PgChooselanState();
}

class _PgChooselanState extends State<PgChooselan> {
  final List<Map<String, dynamic>> languages = [
    {"title": "Қазақ", "code": "kk"},
    {"title": "Русский", "code": "ru"},
    {"title": "English", "code": "en"},
  ];

  @override
  void initState() {
    super.initState();
  }

  String selectedLanguageCode = "en";

  void changeLanguage(String code) {
    Locale newLocale = Locale(code, '');
    setState(() {
      selectedLanguageCode = code;
    });
    MyApp.setLocale(context, newLocale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: WidgetGlobalMargin(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: languages.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      changeLanguage(languages[index]['code']),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    height: 67,
                                    decoration: BoxDecoration(
                                      color: selectedLanguageCode ==
                                              languages[index]['code']
                                          ? AppColors.selback
                                          : AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: AppColors.border,
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(width: 8),
                                            Label(
                                              txt: languages[index]["title"],
                                              type: TextTypes.f_17_400,
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          selectedLanguageCode ==
                                                  languages[index]['code']
                                              ? Icons.radio_button_checked_sharp
                                              : Icons.radio_button_off,
                                          color: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: commonButton(
                    arrow: true,
                    context: context,
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PgOnboarding(),
                        ),
                      )
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
