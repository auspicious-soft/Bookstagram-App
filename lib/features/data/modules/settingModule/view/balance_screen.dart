import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/features/presentation/Pages/TopUp/pg_top_up.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../app_settings/components/loader.dart';
import '../controllers/balance_controller.dart';

class PgBalanceScreen extends GetView<PgBalanceScreenController> {
  const PgBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? savedSelectedDate;

    Future<void> pickMonthYear(BuildContext context) async {
      int selectedMonth = savedSelectedDate?.month ?? DateTime.now().month;
      int selectedYear = savedSelectedDate?.year ?? DateTime.now().year;

      final yearController = ScrollController(
          initialScrollOffset:
              ((selectedYear - 2000) * 78).toDouble()); // 70 width + 8 margin

      final result = await showDialog<DateTime>(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Select Month & Year",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      // Months horizontal grid
                      SizedBox(
                        height: 100,
                        child: GridView.count(
                          crossAxisCount: 6,
                          scrollDirection: Axis.vertical,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          children: List.generate(12, (index) {
                            final monthNumber = index + 1;
                            final monthName = DateFormat('MMM')
                                .format(DateTime(0, monthNumber));
                            final isSelected = monthNumber == selectedMonth;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedMonth = monthNumber;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  monthName,
                                  style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Years horizontal slider with focus
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          controller: yearController,
                          scrollDirection: Axis.horizontal,
                          itemCount: DateTime.now().year - 1999,
                          itemBuilder: (context, index) {
                            final year = 2000 + index;
                            final isSelected = year == selectedYear;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedYear = year;
                                });
                              },
                              child: Container(
                                width: 40,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  year.toString(),
                                  style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, null),
                            child: const Text("Cancel",
                                style: TextStyle(color: Colors.red)),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(
                                context, DateTime(selectedYear, selectedMonth)),
                            child: const Text("OK"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      );

      if (result != null) {
        savedSelectedDate = result;
        final month = DateFormat('MMM').format(result);
        final year = DateFormat('yyyy').format(result);
        print("Selected: $month $year");

        controller.fetchWalletHistory(year: year, month: month);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: WidgetGlobalMargin(
          child: Obx(() => controller.isLoading.value == true
              ? Container(
                  height: Get.height,
                  width: Get.width,
                  child: Center(child: LoadingScreen()))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            padVertical(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back),
                                ),
                                Label(
                                  txt: AppLocalization.of(context)
                                      .translate('balance'),
                                  type: TextTypes.f_20_500,
                                ),
                                const Label(
                                    txt: "   ", type: TextTypes.f_20_500),
                              ],
                            ),
                            padVertical(20),
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    AppAssets.walletback,
                                    fit: BoxFit.cover,
                                    height: Get.height * 0.2,
                                    width: Get.width,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.2,
                                  width: Get.width,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AppAssets.wallet,
                                          width: 30,
                                          height: 35,
                                          fit: BoxFit.contain,
                                        ),
                                        Obx(
                                          () => Label(
                                            txt:
                                                '${controller.walletHistory.value?.data?.wallet?.toStringAsFixed(2) ?? 0} ₸',
                                            type: TextTypes.f_36_700,
                                            forceColor: AppColors.whiteColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                // Positioned(
                                //   top: 55,
                                //   left: 145,
                                //   child: Obx(
                                //     () => Label(
                                //       txt: '${controller.balance.value} ₸',
                                //       type: TextTypes.f_36_700,
                                //       forceColor: AppColors.whiteColor,
                                //     ),
                                //   ),
                                // ),
                                padVertical(10),
                                // Positioned(
                                //   bottom: 14,
                                //   left: 30,
                                //   right: 30,
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       color: AppColors.purple,
                                //       borderRadius: BorderRadius.circular(40),
                                //     ),
                                //     padding: const EdgeInsets.symmetric(
                                //         vertical: 15, horizontal: 40),
                                //     child: Column(
                                //       mainAxisAlignment: MainAxisAlignment.center,
                                //       crossAxisAlignment: CrossAxisAlignment.center,
                                //       mainAxisSize: MainAxisSize.max,
                                //       children: [
                                //         Obx(
                                //           () => Label(
                                //             txt: '${controller.cashback.value}',
                                //             type: TextTypes.f_15_400,
                                //             forceColor: AppColors.whiteColor,
                                //           ),
                                //         ),
                                //         Label(
                                //           txt: AppLocalization.of(context)
                                //               .translate('cashback'),
                                //           type: TextTypes.f_15_400,
                                //           forceColor: AppColors.whiteColor,
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            padVertical(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Label(
                                  txt: AppLocalization.of(context)
                                      .translate('history'),
                                  type: TextTypes.f_16_700,
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      await pickMonthYear(
                                          context); // ✅ call function here
                                    },
                                    child:
                                        const Icon(Icons.calendar_month_sharp)),
                              ],
                            ),
                            padVertical(20),
                            Obx(
                              () {
                                final history = controller
                                        .walletHistory.value?.data?.history ??
                                    [];

                                if (history.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 50),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            AppAssets.noData,
                                            height: 100,
                                            width: 100,
                                          ),
                                          padVertical(10),
                                          Label(
                                            txt: AppLocalization.of(context)
                                                .translate('no_transactions'),
                                            // Add translations in your localization files
                                            type: TextTypes.f_16_500,
                                            forceColor: AppColors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                return SingleChildScrollView(
                                  child: Column(
                                    children: history.map<Widget>((item) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Label(
                                                        txt:
                                                            "${AppLocalization.of(context).translate('TransactionId')}:",
                                                        type:
                                                            TextTypes.f_13_600,
                                                        forceColor:
                                                            AppColors.grey,
                                                      ),
                                                      Label(
                                                        txt:
                                                            "${item.orderId?.transactionId}",
                                                        type:
                                                            TextTypes.f_13_600,
                                                      )
                                                    ],
                                                  ),
                                                  Label(
                                                    txt: item.orderId
                                                                ?.createdAt !=
                                                            null
                                                        ? DateFormat(
                                                                "dd MMM yyyy, hh:mm a")
                                                            .format(DateTime.parse(item
                                                                    .orderId!
                                                                    .createdAt!
                                                                    .toString())
                                                                .toLocal())
                                                        : "",
                                                    type: TextTypes.f_12_400,
                                                    forceColor: AppColors.grey,
                                                  ),
                                                ],
                                              ),
                                              item.type == "earn"
                                                  ? Label(
                                                      txt:
                                                          "+${item.orderId?.paymentAmount ?? 0} ₸",
                                                      type: TextTypes.f_16_500,
                                                      forceColor:
                                                          AppColors.green,
                                                    )
                                                  : Label(
                                                      txt:
                                                          "-${item.orderId?.paymentAmount ?? 0} ₸",
                                                      type: TextTypes.f_16_500,
                                                      forceColor: AppColors.red,
                                                    ),
                                            ],
                                          ),
                                          padVertical(10),
                                          const Divider(
                                            color: AppColors.divider,
                                            thickness: 2,
                                          ),
                                          padVertical(10),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
        ),
      ),
    );
  }
}
