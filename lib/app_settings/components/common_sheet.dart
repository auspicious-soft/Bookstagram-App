import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  FilterBottomSheetState createState() => FilterBottomSheetState();
}

class FilterBottomSheetState extends State<FilterBottomSheet> {
  // State variables for checkboxes (languages)
  bool isKazakhSelected = true;
  bool isEnglishSelected = false;
  bool isRussianSelected = false;

  // State variable for radio buttons (sorting)
  String selectedSortOption = 'thedefault'; // Default sorting option

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtils.screenHeight(context) / 1.2,
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('  '),
                Label(
                  txt: AppLocalization.of(context).translate('Filter'),
                  type: TextTypes.f_17_500,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    width: 30,
                    height: 30,
                    AppAssets.close,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            Label(
              txt: AppLocalization.of(context).translate('bylanguage'),
              forceColor: AppColors.buttongroupBorder,
              type: TextTypes.f_13_400,
            ),
            padVertical(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Label(
                  txt: 'Қазақша',
                  type: TextTypes.f_16_500,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isKazakhSelected = !isKazakhSelected;
                    });
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: isKazakhSelected
                          ? AppColors.primaryColor
                          : AppColors.tickbck,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: isKazakhSelected
                        ? const Icon(
                            Icons.check_outlined,
                            size: 18,
                            color: AppColors.whiteColor,
                          )
                        : null,
                  ),
                ),
              ],
            ),
            padVertical(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Label(
                  txt: 'English',
                  type: TextTypes.f_16_500,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isEnglishSelected = !isEnglishSelected;
                    });
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: isEnglishSelected
                          ? AppColors.primaryColor
                          : AppColors.tickbck,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: isEnglishSelected
                        ? const Icon(
                            Icons.check_outlined,
                            size: 18,
                            color: AppColors.whiteColor,
                          )
                        : null,
                  ),
                ),
              ],
            ),
            padVertical(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Label(
                  txt: 'Русский',
                  type: TextTypes.f_16_500,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isRussianSelected = !isRussianSelected;
                    });
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: isRussianSelected
                          ? AppColors.primaryColor
                          : AppColors.tickbck,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: isRussianSelected
                        ? const Icon(
                            Icons.check_outlined,
                            size: 18,
                            color: AppColors.whiteColor,
                          )
                        : null,
                  ),
                ),
              ],
            ),
            padVertical(40),
            Label(
              txt: AppLocalization.of(context).translate('sorting'),
              forceColor: AppColors.buttongroupBorder,
              type: TextTypes.f_13_400,
            ),
            padVertical(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Label(
                  txt: AppLocalization.of(context).translate('thedefault'),
                  type: TextTypes.f_16_500,
                ),
                Radio<String>(
                  value: 'thedefault',
                  groupValue: selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      selectedSortOption = value!;
                    });
                  },
                  activeColor: AppColors.primaryColor,
                ),
              ],
            ),
            padVertical(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Label(
                  txt: AppLocalization.of(context).translate('alphabetically'),
                  type: TextTypes.f_16_500,
                ),
                Radio<String>(
                  value: 'alphabetically',
                  groupValue: selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      selectedSortOption = value!;
                    });
                  },
                  activeColor: AppColors.primaryColor,
                ),
              ],
            ),
            padVertical(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Label(
                  txt: AppLocalization.of(context).translate('byrating'),
                  type: TextTypes.f_16_500,
                ),
                Radio<String>(
                  value: 'byrating',
                  groupValue: selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      selectedSortOption = value!;
                    });
                  },
                  activeColor: AppColors.primaryColor,
                ),
              ],
            ),
            padVertical(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Label(
                  txt: AppLocalization.of(context).translate('bynovelty'),
                  type: TextTypes.f_16_500,
                ),
                Radio<String>(
                  value: 'bynovelty',
                  groupValue: selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      selectedSortOption = value!;
                    });
                  },
                  activeColor: AppColors.primaryColor,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.05,
            ),
            commonButton(
              context: context,
              onPressed: () {
                // Apply filter logic here
                // Example: Pass selected languages and sort option back
                Navigator.pop(context, {
                  'languages': {
                    'kazakh': isKazakhSelected,
                    'english': isEnglishSelected,
                    'russian': isRussianSelected,
                  },
                  'sort': selectedSortOption,
                });
              },
              txt: AppLocalization.of(context).translate('Filter'),
            ),
          ],
        ),
      ),
    );
  }
}
