import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';

class PgNotification extends StatefulWidget {
  const PgNotification({super.key});

  @override
  State<PgNotification> createState() => _PgNotificationState();
}

class _PgNotificationState extends State<PgNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: WidgetGlobalMargin(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                    ),
                    Label(
                      txt:
                          AppLocalization.of(context).translate('notification'),
                      type: TextTypes.f_20_500,
                    ),
                    const Icon(Icons.delete),
                  ],
                ),
                Column(
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        // height: 35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1, color: AppColors.border),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Label(
                                txt: "dcscsdcsdcsdcsdcsd",
                                type: TextTypes.f_16_500),
                            Label(
                              txt: "dcscsdcsdcsdcsdcsd",
                              type: TextTypes.f_10_500,
                              forceColor: AppColors.grey,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
