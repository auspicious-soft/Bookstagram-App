import 'package:bookstagram/app_settings/components/common_sheet.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/features/data/modules/bookstudy/controllers/book_life_controller.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app_settings/components/loader.dart';
import '../../../../../app_settings/constants/app_config.dart';
import '../../../../../app_settings/constants/app_const.dart';
import '../../../../../app_settings/constants/common_button.dart';
import '../controllers/book_event_controller.dart';

class BookLifeView extends GetView<BookLifeController> {
  const BookLifeView({super.key});

  @override
  Widget build(BuildContext context) {
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.arrow_back_ios,
                                            color: Colors.black),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Label(
                                          txt:
                                              '💡 ${AppLocalization.of(context).translate('Booklife')}',
                                          type: TextTypes.f_20_500),
                                      GestureDetector(
                                        onTap: () {
                                          Get.bottomSheet(
                                            StatefulBuilder(
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
                                                // Define state variables

                                                return SingleChildScrollView(
                                                  child: Container(
                                                    height: Get.height / 1.2,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color:
                                                          AppColors.whiteColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(20),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          // Header
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text('  '),
                                                              Label(
                                                                txt: AppLocalization.of(
                                                                        context)
                                                                    .translate(
                                                                        'Filter'),
                                                                type: TextTypes
                                                                    .f_17_500,
                                                              ),
                                                              IconButton(
                                                                onPressed: () {
                                                                  controller
                                                                      .getListBooks();
                                                                  Get.back(); // Close the bottom sheet
                                                                },
                                                                icon:
                                                                    Image.asset(
                                                                  width: 30,
                                                                  height: 30,
                                                                  AppAssets
                                                                      .close,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // Sorting Section
                                                          Label(
                                                            txt: AppLocalization
                                                                    .of(context)
                                                                .translate(
                                                                    'sorting'),
                                                            forceColor: AppColors
                                                                .buttongroupBorder,
                                                            type: TextTypes
                                                                .f_13_400,
                                                          ),
                                                          padVertical(20),
                                                          // Default
                                                          GestureDetector(
                                                            onTap: () {
                                                              controller.filter
                                                                      .value =
                                                                  AppLocalization.of(
                                                                          context)
                                                                      .translate(
                                                                          'thedefault');
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Label(
                                                                  txt: AppLocalization.of(
                                                                          context)
                                                                      .translate(
                                                                          'thedefault'),
                                                                  type: TextTypes
                                                                      .f_16_500,
                                                                ),
                                                                Obx(() => controller
                                                                            .filter
                                                                            .value !=
                                                                        AppLocalization.of(context)
                                                                            .translate('thedefault')
                                                                    ? Icon(
                                                                        Icons
                                                                            .radio_button_off_outlined,
                                                                        color: Colors
                                                                            .orange,
                                                                      )
                                                                    : Icon(
                                                                        Icons
                                                                            .radio_button_checked,
                                                                        color: Colors
                                                                            .orange,
                                                                      ))
                                                              ],
                                                            ),
                                                          ),
                                                          padVertical(15),
                                                          // Alphabetically
                                                          GestureDetector(
                                                            onTap: () {
                                                              controller.filter
                                                                      .value =
                                                                  AppLocalization.of(
                                                                          context)
                                                                      .translate(
                                                                          'alphabetically');
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Label(
                                                                  txt: AppLocalization.of(
                                                                          context)
                                                                      .translate(
                                                                          'alphabetically'),
                                                                  type: TextTypes
                                                                      .f_16_500,
                                                                ),
                                                                Obx(() => controller
                                                                            .filter
                                                                            .value !=
                                                                        AppLocalization.of(context)
                                                                            .translate('alphabetically')
                                                                    ? Icon(
                                                                        Icons
                                                                            .radio_button_off_outlined,
                                                                        color: Colors
                                                                            .orange,
                                                                      )
                                                                    : Icon(
                                                                        Icons
                                                                            .radio_button_checked,
                                                                        color: Colors
                                                                            .orange,
                                                                      ))
                                                              ],
                                                            ),
                                                          ),
                                                          padVertical(15),
                                                          // // By Rating
                                                          // GestureDetector(
                                                          //   onTap: () {
                                                          //     controller.filter
                                                          //             .value =
                                                          //         AppLocalization.of(
                                                          //                 context)
                                                          //             .translate(
                                                          //                 'byrating');
                                                          //   },
                                                          //   child: Row(
                                                          //     mainAxisAlignment:
                                                          //         MainAxisAlignment
                                                          //             .spaceBetween,
                                                          //     children: [
                                                          //       Label(
                                                          //         txt: AppLocalization
                                                          //                 .of(
                                                          //                     context)
                                                          //             .translate(
                                                          //                 'byrating'),
                                                          //         type: TextTypes
                                                          //             .f_16_500,
                                                          //       ),
                                                          //       Obx(() => controller
                                                          //                   .filter
                                                          //                   .value !=
                                                          //               AppLocalization.of(
                                                          //                       context)
                                                          //                   .translate(
                                                          //                       'byrating')
                                                          //           ? Icon(
                                                          //               Icons
                                                          //                   .radio_button_off_outlined,
                                                          //               color: Colors
                                                          //                   .orange,
                                                          //             )
                                                          //           : Icon(
                                                          //               Icons
                                                          //                   .radio_button_checked,
                                                          //               color: Colors
                                                          //                   .orange,
                                                          //             ))
                                                          //     ],
                                                          //   ),
                                                          // ),
                                                          // padVertical(15),
                                                          // By Novelty
                                                          GestureDetector(
                                                            onTap: () {
                                                              controller.filter
                                                                      .value =
                                                                  AppLocalization.of(
                                                                          context)
                                                                      .translate(
                                                                          'bynovelty');
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Label(
                                                                  txt: AppLocalization.of(
                                                                          context)
                                                                      .translate(
                                                                          'bynovelty'),
                                                                  type: TextTypes
                                                                      .f_16_500,
                                                                ),
                                                                Obx(() => controller
                                                                            .filter
                                                                            .value !=
                                                                        AppLocalization.of(context)
                                                                            .translate('bynovelty')
                                                                    ? Icon(
                                                                        Icons
                                                                            .radio_button_off_outlined,
                                                                        color: Colors
                                                                            .orange,
                                                                      )
                                                                    : Icon(
                                                                        Icons
                                                                            .radio_button_checked,
                                                                        color: Colors
                                                                            .orange,
                                                                      ))
                                                              ],
                                                            ),
                                                          ),
                                                          padVertical(15),
                                                          SizedBox(
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.2),
                                                          commonButton(
                                                            context: context,
                                                            onPressed: () {
                                                              controller
                                                                  .fetchBookStudy();
                                                              Get.back();
                                                            },
                                                            txt: AppLocalization
                                                                    .of(context)
                                                                .translate(
                                                                    'Filter'),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            isScrollControlled: true,
                                            backgroundColor:
                                                AppColors.whiteColor,
                                          );
                                        },
                                        child: Image.asset(
                                          AppAssets.categoryfil,
                                          width: 25,
                                          height: 25,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  padVertical(15),
                                  Column(
                                    children: [
                                      Column(
                                        children: [
                                          LayoutBuilder(
                                            builder: (context, constraints) {
                                              final screenWidth =
                                                  constraints.maxWidth;
                                              const tabWidth =
                                                  200.0; // Fixed width for each tab
                                              final RxDouble scrollOffset = 0.0
                                                  .obs; // Track scroll offset
                                              final ScrollController
                                                  scrollController =
                                                  ScrollController();

                                              // Update scroll offset when the ListView scrolls
                                              scrollController.addListener(() {
                                                scrollOffset.value =
                                                    scrollController.offset;
                                              });

                                              // Scroll to the selected tab when it changes
                                              void scrollToSelectedTab(
                                                  int index) {
                                                if (scrollController
                                                    .hasClients) {
                                                  final targetOffset =
                                                      index * tabWidth;
                                                  final maxScrollExtent =
                                                      scrollController.position
                                                          .maxScrollExtent;
                                                  final adjustedOffset =
                                                      targetOffset >
                                                              maxScrollExtent
                                                          ? maxScrollExtent
                                                          : targetOffset;
                                                  scrollController.animateTo(
                                                    adjustedOffset,
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.easeInOut,
                                                  );
                                                }
                                              }

                                              // Listen to selectedIndex changes and scroll to the selected tab
                                              ever(controller.selectedIndex,
                                                  (int index) {
                                                scrollToSelectedTab(index);
                                                controller
                                                    .updateIndicatorPosition(
                                                        index);
                                                controller.setCategory();
                                              });

                                              return Column(
                                                children: [
                                                  SizedBox(
                                                    height: 40,
                                                    // Height for the tab bar
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      controller:
                                                          scrollController,
                                                      itemCount: controller
                                                              .bookevent
                                                              .value
                                                              ?.data
                                                              ?.categories
                                                              ?.length ??
                                                          0,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final categories =
                                                            controller
                                                                    .bookevent
                                                                    .value
                                                                    ?.data
                                                                    ?.categories?[
                                                                index];
                                                        return GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .selectedIndex
                                                                .value = index;
                                                            controller
                                                                .selectedIndex
                                                                .refresh();
                                                            controller
                                                                .updateIndicatorPosition(
                                                                    index);
                                                            controller
                                                                .setCategory();
                                                          },
                                                          child: Container(
                                                            width: tabWidth,
                                                            key: controller
                                                                .tabKeys[index],
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom: 10),
                                                            child:
                                                                Obx(() => Text(
                                                                      controller.getBookTitle(
                                                                          name:
                                                                              categories?.name),
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            AppConst.fontFamily,
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: controller.selectedIndex.value ==
                                                                                index
                                                                            ? AppColors.primaryColor
                                                                            : AppColors.blackColor,
                                                                      ),
                                                                    )),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        width: screenWidth,
                                                        height: 2,
                                                        color: Colors
                                                            .grey.shade300,
                                                      ),
                                                      Obx(
                                                        () =>
                                                            AnimatedPositioned(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      300),
                                                          left: (controller
                                                                      .selectedIndex
                                                                      .value *
                                                                  tabWidth) -
                                                              scrollOffset
                                                                  .value,
                                                          width: tabWidth,
                                                          height: 2,
                                                          child: Container(
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
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
                                      // SizedBox(
                                      //   height: 80,
                                      //   child: ListView.builder(
                                      //     scrollDirection: Axis.horizontal,
                                      //     itemCount: controller.bookevent.value
                                      //         ?.data?.categories?.length,
                                      //     padding: const EdgeInsets.symmetric(
                                      //         horizontal: 10),
                                      //     itemBuilder: (context, index) {
                                      //       // Define the list of category names
                                      //       final categories = controller
                                      //           .bookevent
                                      //           .value
                                      //           ?.data
                                      //           ?.categories?[index];
                                      //       return Padding(
                                      //         padding:
                                      //             const EdgeInsets.symmetric(
                                      //                 horizontal: 10),
                                      //         child: GestureDetector(
                                      //           onTap: () {
                                      //             controller.selectedIndex
                                      //                 .value = index;
                                      //             controller.selectedIndex
                                      //                 .refresh();
                                      //             controller
                                      //                 .updateIndicatorPosition(
                                      //                     index);
                                      //             controller.setCategory();
                                      //           },
                                      //           child: Obx(() => Container(
                                      //                 width: Get.width * 0.25,
                                      //                 key: controller
                                      //                     .tabKeys[index],
                                      //                 alignment:
                                      //                     Alignment.center,
                                      //                 padding:
                                      //                     const EdgeInsets.only(
                                      //                         bottom: 10),
                                      //                 child: Text(
                                      //                   controller.getBookTitle(
                                      //                       name: categories
                                      //                           ?.name),
                                      //                   // Display the corresponding category name
                                      //                   style: TextStyle(
                                      //                     fontFamily: AppConst
                                      //                         .fontFamily,
                                      //                     fontSize: 17,
                                      //                     fontWeight:
                                      //                         FontWeight.w500,
                                      //                     color: controller
                                      //                                 .selectedIndex
                                      //                                 .value ==
                                      //                             index
                                      //                         ? AppColors
                                      //                             .primaryColor
                                      //                         : AppColors
                                      //                             .blackColor,
                                      //                   ),
                                      //                 ),
                                      //               )),
                                      //         ),
                                      //       );
                                      //     },
                                      //   ),
                                      // ),
                                      // Stack(
                                      //   children: [
                                      //     Container(
                                      //       height: 2,
                                      //       color: Colors.grey.shade300,
                                      //     ),
                                      //     AnimatedPositioned(
                                      //       duration: const Duration(
                                      //           milliseconds: 300),
                                      //       left:
                                      //           controller.indicatorLeft.value,
                                      //       width: Get.width * 0.2,
                                      //       height: 2,
                                      //       child: Container(
                                      //         color: AppColors.primaryColor,
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                  padVertical(10),
                                  Obx(
                                    () => controller.isload.value == true
                                        ? Container(
                                            height: Get.height * 0.6,
                                            width: Get.width,
                                            child:
                                                Center(child: LoadingScreen()))
                                        : Column(
                                            children: List.generate(
                                                controller.bookevent.value?.data
                                                        ?.blogs?.length ??
                                                    0, (index) {
                                              final event = controller.bookevent
                                                  .value?.data?.blogs?[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  controller.goToEventDetail(
                                                      event?.sId);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10, top: 10),
                                                  child: Column(
                                                    children: [
                                                      padVertical(5),
                                                      Row(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Container(
                                                                height: 100,
                                                                width: 100,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                  ),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                    child: Image
                                                                        .network(
                                                                      height:
                                                                          100,
                                                                      width:
                                                                          100,
                                                                      "${AppConfig.imgBaseUrl}${event?.image}",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                          height:
                                                                              100,
                                                                          width:
                                                                              100,
                                                                          AppAssets
                                                                              .book,
                                                                          fit: BoxFit
                                                                              .contain),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          padHorizontal(10),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              padVertical(5),
                                                              SizedBox(
                                                                width: ScreenUtils
                                                                        .screenWidth(
                                                                            context) /
                                                                    1.8,
                                                                child: Label(
                                                                  txt: event
                                                                          ?.name ??
                                                                      "",
                                                                  type: TextTypes
                                                                      .f_18_700,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: ScreenUtils
                                                                        .screenWidth(
                                                                            context) /
                                                                    1.8,
                                                                child: Label(
                                                                  txt: event
                                                                          ?.shortDescription ??
                                                                      "",
                                                                  type: TextTypes
                                                                      .f_13_400,
                                                                  forceColor:
                                                                      AppColors
                                                                          .resnd,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      padVertical(5),
                                                      Obx(
                                                        () => index ==
                                                                ((controller
                                                                            .bookevent
                                                                            .value
                                                                            ?.data
                                                                            ?.blogs
                                                                            ?.length ??
                                                                        0) -
                                                                    1)
                                                            ? SizedBox()
                                                            : const Divider(),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                  ),
                                ])))
                          ])))));
  }
}
