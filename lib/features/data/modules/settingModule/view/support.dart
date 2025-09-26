import 'dart:async';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/features/presentation/Pages/Support/Widgets/social_list_widget.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app_settings/components/loader.dart';
import '../controllers/SupportController.dart';

class PgSupport extends GetView<SupportController> {
  final int? initialTabIndex;

  const PgSupport({super.key, this.initialTabIndex});

  @override
  Widget build(BuildContext context) {
    controller.setInitialTab(initialTabIndex ?? 0);

    // Initialize ScrollController for infinite scrolling
    final ScrollController scrollController = ScrollController();

    // Add listener to detect when the user reaches the end of the list
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !controller.isLoadingMore.value &&
          controller.hasMore.value) {
        controller.fetchFAQs(loadMore: true);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back),
                ),
                Label(
                  txt: AppLocalization.of(context).translate('support'),
                  type: TextTypes.f_20_500,
                ),
                const Label(txt: "   ", type: TextTypes.f_20_500),
              ],
            ),
            padVertical(20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final screenWidth = constraints.maxWidth;
                            final tabWidth = screenWidth / 2;
                            return Column(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (int index = 0; index < 2; index++)
                                        GestureDetector(
                                          onTap: () => controller.setTab(index),
                                          child: Container(
                                            width: tabWidth,
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            alignment: Alignment.center,
                                            child: Text(
                                              AppLocalization.of(context)
                                                  .translate(
                                                ['faq', 'contacts'][index],
                                              ),
                                              style: TextStyle(
                                                fontFamily: AppConst.fontFamily,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: controller.selectedIndex
                                                            .value ==
                                                        index
                                                    ? AppColors.primaryColor
                                                    : AppColors.blackColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      width: screenWidth,
                                      height: 4,
                                      color: Colors.grey.shade300,
                                    ),
                                    Obx(
                                      () => AnimatedPositioned(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        left: controller.selectedIndex.value *
                                            tabWidth,
                                        width: tabWidth,
                                        height: 4,
                                        child: Container(
                                            color: AppColors.primaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    padVertical(20),
                    Obx(
                      () => controller.selectedIndex.value == 0
                          ? Column(
                              children: [
                                Obx(() {
                                  final types =
                                      controller.walletHistory.value?.types ??
                                          [];

                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children:
                                          List.generate(types.length, (index) {
                                        final type = types[index];
                                        final isSelected =
                                            controller.selectedType.value ==
                                                type;

                                        return Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                controller.selectedType.value =
                                                    type;
                                                controller.fetchFAQs(
                                                    type: controller
                                                        .selectedType.value);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? AppColors.primaryColor
                                                      : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: isSelected
                                                      ? null
                                                      : Border.all(
                                                          width: 1,
                                                          color: AppColors
                                                              .primaryColor),
                                                ),
                                                child: Label(
                                                  txt: type,
                                                  type: TextTypes.f_15_400,
                                                  forceColor: isSelected
                                                      ? AppColors.whiteColor
                                                      : AppColors.primaryColor,
                                                ),
                                              ),
                                            ),
                                            if (index != types.length - 1)
                                              padHorizontal(5),
                                          ],
                                        );
                                      }),
                                    ),
                                  );
                                }),
                                padVertical(20),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: AppColors.border,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        height: 20,
                                        width: 20,
                                        AppAssets.search,
                                        fit: BoxFit.contain,
                                      ),
                                      padHorizontal(10),
                                      Expanded(
                                        child: TextField(
                                          onChanged: (value) {
                                            if (controller.debounce?.isActive ??
                                                false)
                                              controller.debounce!.cancel();
                                            controller.debounce = Timer(
                                                const Duration(
                                                    milliseconds: 600), () {
                                              debugPrint("User typed: $value");
                                              controller.fetchFAQs(
                                                  search: value);
                                            });
                                          },
                                          controller:
                                              controller.faqsearchController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                AppLocalization.of(context)
                                                    .translate('search'),
                                            hintStyle: const TextStyle(
                                              color: AppColors.inputBorder,
                                              fontFamily: AppConst.fontFamily,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          style: const TextStyle(
                                            color: AppColors.blackColor,
                                            fontFamily: AppConst.fontFamily,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                padVertical(20),
                                Obx(() {
                                  if (controller.isLoading.value &&
                                      controller.faqs.isEmpty) {
                                    return SizedBox(
                                      height: Get.height * 0.5,
                                      child: const Center(
                                          child: CircularProgressIndicator()),
                                    );
                                  }

                                  return Column(
                                    children: [
                                      ListView.builder(
                                        controller: scrollController,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: controller.faqs.length,
                                        itemBuilder: (context, index) {
                                          if (index >=
                                              controller.expanded.length) {
                                            return const SizedBox
                                                .shrink(); // Prevent index out of range
                                          }
                                          final item = controller.faqs[index];
                                          final isExpanded =
                                              controller.expanded[index];

                                          return Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () => controller
                                                    .toggleItem(index),
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 20,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.border,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          const Radius.circular(
                                                              8),
                                                      topRight:
                                                          const Radius.circular(
                                                              8),
                                                      bottomLeft:
                                                          Radius.circular(
                                                              isExpanded
                                                                  ? 0
                                                                  : 8),
                                                      bottomRight:
                                                          Radius.circular(
                                                              isExpanded
                                                                  ? 0
                                                                  : 8),
                                                    ),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: Colors.black12,
                                                          blurRadius: 3,
                                                          offset: Offset(0, 2))
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Label(
                                                            txt:
                                                                item.question ??
                                                                    '',
                                                            type: TextTypes
                                                                .f_17_500),
                                                      ),
                                                      Icon(
                                                        isExpanded
                                                            ? Icons
                                                                .arrow_drop_up_outlined
                                                            : Icons
                                                                .arrow_drop_down_outlined,
                                                        color: AppColors
                                                            .primaryColor,
                                                        size: 30,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Obx(() => index ==
                                                      controller.openIndex.value
                                                  ? Container(
                                                      width: double.infinity,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 15),
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: AppColors.border,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            8)),
                                                      ),
                                                      child: Label(
                                                          txt:
                                                              item.answer ?? '',
                                                          maxLines: 1000,
                                                          type: TextTypes
                                                              .f_15_400),
                                                    )
                                                  : SizedBox()),
                                              const SizedBox(height: 8),
                                            ],
                                          );
                                        },
                                      ),
                                      // Show loading indicator when loading more
                                      Obx(() => controller.isLoadingMore.value
                                          ? const Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : const SizedBox.shrink()),
                                    ],
                                  );
                                }),
                              ],
                            )
                          : Column(
                              children: [
                                buildContactItem(
                                    Icons.camera_alt,
                                    "Instagram",
                                    "https://instagram.com/bookstagram.online",
                                    context),
                                buildContactItem(
                                    Icons.facebook,
                                    "Facebook",
                                    "https://facebook.com/bookstagram.kz",
                                    context),
                                buildContactItem(Icons.telegram, "Telegram",
                                    "https://t.me/bookstagram_kz", context),
                                buildContactItem(Icons.mail, "Mail",
                                    "mailto:info@bookstagram.kz", context),
                                buildContactItem(
                                    Icons.music_note,
                                    "TikTok",
                                    "https://tiktok.com/@bookstagram.kz",
                                    context),
                                buildContactItem(Icons.call, "WhatsApp",
                                    "https://wa.me/77758133887", context),
                                buildContactItem(Icons.public, "Website",
                                    "https://bookstagram.kz", context),
                                buildContactItem(Icons.help, "FAQ",
                                    "https://bookstagram.kz/faq", context),
                              ],
                            ),
                    ),
                  ],
                ).marginSymmetric(horizontal: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
