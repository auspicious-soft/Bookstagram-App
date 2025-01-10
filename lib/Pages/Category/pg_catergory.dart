import 'package:bookstagram/Pages/SubCategory/pg_subcategory.dart';
import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';

import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/localization/app_localization.dart';

import 'package:flutter/material.dart';

class PgCatergory extends StatefulWidget {
  const PgCatergory({super.key});

  @override
  State<PgCatergory> createState() => _PgCatergoryState();
}

class _PgCatergoryState extends State<PgCatergory> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
            child: WidgetGlobalMargin(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                padVertical(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Label(
                        txt:
                            AppLocalization.of(context).translate('Categories'),
                        type: TextTypes.f_20_500),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: AppColors.whiteColor,
                          builder: (BuildContext context) {
                            return FilterBottomSheet();
                          },
                        );
                      },
                      child: Image.asset(
                        width: 16,
                        height: 20,
                        AppAssets.categoryfil,
                        fit: BoxFit.contain,
                      ),
                    )
                  ],
                ),
                padVertical(10),
                _buildButtonGrid(context)
              ])))
            ]))));
  }
}

Widget _buildButtonGrid(context) {
  final List<Map<String, dynamic>> items = [
    {'label': '📋 Расказы'},
    {'label': '👤 Биография'},
    {'label': '💼 Мастер-класстар'},
    {'label': '🎙️ Подкастар'},
    {'label': '💡 Пайдалы ақпараттар'},
    {'label': '📚 Нон-фикшн'},
    {'label': '✨ Ғылым'},
    {'label': '🏛️ Тарих'},
    {'label': '♟️ Әңгімелер'},
    {'label': '📖 Фикшн'},
  ];

  return Wrap(
    spacing: 10.0,
    runSpacing: 10.0,
    children: items.asMap().entries.map((entry) {
      // int index = entry.key;
      Map<String, dynamic> item = entry.value;

      return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PgSubcategory(label: item['label']),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
          ));
    }).toList(),
  );
}
