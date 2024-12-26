import 'package:bookstagram/Pages/Login/pg_login.dart';
import 'package:bookstagram/Pages/SIgnUp/pg_signup.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgOnboarding extends StatefulWidget {
  const PgOnboarding({super.key});

  @override
  State<PgOnboarding> createState() => _PgOnboardingState();
}

class _PgOnboardingState extends State<PgOnboarding> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.background,
              fit: BoxFit.cover,
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTopSkipButton(),
                const SizedBox(height: 70),
                _buildButtonGrid(),
                const Spacer(),
                _buildTextSection(),
                const SizedBox(height: 20),
                const Spacer(),
                _buildBottomButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Skip Button (top right)
  Widget _buildTopSkipButton() {
    return const Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Label(
          txt: "Skip",
          type: TextTypes.f_13_400,
        ),
      ),
    );
  }

  Widget _buildButtonGrid() {
    final List<Map<String, dynamic>> items = [
      {'label': '🎧 Аудиокітаптар'},
      {'label': '📖 Электронды кітаптар'},
      {'label': '💼 Мастер-класстар'},
      {'label': '🎙️ Подкастар'},
      {'label': '💡 Пайдалы ақпараттар'},
      {'label': '📔 Журналдар'},
      {'label': '🎓 Курстар'},
      {'label': '🔖 Іс-шаралар'},
      {'label': '📚 Саммарилер'},
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      runSpacing: 10.0,
      children: items.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Label(
            txt: item['label'],
            type: TextTypes.f_18_400,
          ),
        );
      }).toList(),
    );
  }

  // Text Section
  Widget _buildTextSection() {
    return Column(
      children: [
        Label(
          txt: AppLocalization.of(context).translate('Discoverbook'),
          type: TextTypes.f_28_400,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Label(
            txt: AppLocalization.of(context).translate('catalogtxt'),
            forceAlignment: TextAlign.center,
            type: TextTypes.f_20_300,
            forceColor: AppColors.browsetxt,
          ),
        ),
      ],
    );
  }

  // Bottom Buttons
  Widget _buildBottomButtons() {
    return Column(
      children: [
        commonButton(
          txt: AppLocalization.of(context).translate('Login'),
          context: context,
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PgLogin(),
              ),
            )
          },
        ),
        padVertical(10),
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PgSignup(),
                ),
              );
            },
            child: Label(
              txt: AppLocalization.of(context).translate('Registration'),
              type: TextTypes.f_17_400,
              forceColor: AppColors.primaryColor,
            )),
        padVertical(10),
      ],
    );
  }
}
