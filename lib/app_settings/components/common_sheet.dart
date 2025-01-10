import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/common_button.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // List of options to be shown with checkboxes
  // final List<String> _options = [
  //   'Option 1',
  //   'Option 2',
  //   'Option 3',
  //   'Option 4'
  // ];
  // Track selected options
  // Set<String> _selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtils.screenHeight(context) / 1.2,
      decoration: BoxDecoration(
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  '  ',
                ),
                const Label(
                  txt: 'Фильтр',
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
                )
              ]),
              const Label(
                txt: 'По языку',
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
                  Container(
                    height: 25,
                    width: 25,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(
                        8,
                      )),
                    ),
                    child: const Icon(
                      Icons.check_outlined,
                      size: 18,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
              padVertical(15),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Label(
                  txt: 'English',
                  type: TextTypes.f_16_500,
                ),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                    color: AppColors.tickbck,
                    borderRadius: const BorderRadius.all(Radius.circular(
                      8,
                    )),
                  ),
                )
              ]),
              padVertical(15),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Label(
                  txt: 'Русский',
                  type: TextTypes.f_16_500,
                ),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                    color: AppColors.tickbck,
                    borderRadius: const BorderRadius.all(Radius.circular(
                      8,
                    )),
                  ),
                )
              ]),
              padVertical(40),
              const Label(
                txt: 'Сортировка  ',
                forceColor: AppColors.buttongroupBorder,
                type: TextTypes.f_13_400,
              ),
              padVertical(20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Label(
                    txt: 'По умолчанию',
                    type: TextTypes.f_16_500,
                  ),
                  Icon(
                    Icons.radio_button_checked,
                    color: AppColors.primaryColor,
                    size: 26,
                  )
                ],
              ),
              padVertical(15),
              const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Label(
                      txt: 'По алфавиту',
                      type: TextTypes.f_16_500,
                    ),
                    Icon(
                      Icons.radio_button_off_outlined,
                      color: AppColors.primaryColor,
                      size: 26,
                    )
                  ]),
              padVertical(15),
              const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Label(
                      txt: 'По рейтингу',
                      type: TextTypes.f_16_500,
                    ),
                    Icon(
                      Icons.radio_button_off_outlined,
                      color: AppColors.primaryColor,
                      size: 26,
                    )
                  ]),
              padVertical(15),
              const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Label(
                      txt: 'По новизне',
                      type: TextTypes.f_16_500,
                    ),
                    Icon(
                      Icons.radio_button_off_outlined,
                      color: AppColors.primaryColor,
                      size: 26,
                    )
                  ]),
              padVertical(100),
              commonButton(
                  context: context,
                  onPressed: () {},
                  txt: AppLocalization.of(context).translate('Filter'))
            ],
          )),
    );
  }
}
