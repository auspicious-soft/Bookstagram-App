import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/review_sheet.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/features/presentation/Pages/AuthorDetail/pg_authordetail.dart';
import 'package:bookstagram/features/presentation/Pages/Cart/pg_cartscreen.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../app_settings/constants/app_config.dart';
import '../controller/bookdetail.controller.dart';

class PgBookView extends GetView<PgBookViewController> {
  const PgBookView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Set status bar color
        statusBarIconBrightness:
            Brightness.dark, // Ensure icons are visible on white
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.background.withOpacity(0.3),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.2),
                        //     spreadRadius: 1,
                        //     blurRadius: 4,
                        //     offset: const Offset(0, 2),
                        //   ),
                        // ],
                      ),
                      child: Stack(
                        children: [
                          // controller.bookStudy.value?.data?.image !=
                          //         null
                          //     ? Image.network(
                          //         height: Get.height * 0.4,
                          //         width: Get.width,
                          //         "${AppConfig.imgBaseUrl}${controller.bookStudy.value?.data?.image}",
                          //         fit: BoxFit.fill,
                          //         errorBuilder:
                          //             (context, error, stackTrace) =>
                          //                 Image.asset(
                          //           height: Get.height * 0.4,
                          //           width: Get.width,
                          //           AppAssets.book,
                          //           fit: BoxFit.contain,
                          //         ),
                          //       )
                          //     : Image.asset(
                          //         height: Get.height * 0.4,
                          //         width: Get.width,
                          //         AppAssets.book,
                          //         fit: BoxFit.contain,
                          //       ),
                          // // White shading at the bottom
                          // // Image with full height
                          Container(
                            height: Get.height * 0.4,
                            width: Get.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: controller.bookDetailResponseModel.value
                                            ?.data?.book?.image !=
                                        null
                                    ? NetworkImage(
                                        "${AppConfig.imgBaseUrl}${controller.bookDetailResponseModel.value?.data?.book?.image}",
                                      )
                                    : AssetImage(
                                        AppAssets.book,
                                      ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Gradient overlay to create fading effect
                          Container(
                            height: Get.height * 0.4,
                            width: Get.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.background.withOpacity(0.0),
                                  // Transparent at top
                                  AppColors.background.withOpacity(0.3),
                                  // Subtle fade
                                  AppColors.background.withOpacity(0.8),
                                  // Stronger fade
                                  AppColors.background,
                                  // Fully match background
                                ],
                                stops: const [0.0, 0.5, 0.8, 1.0],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.white),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          Obx(() => Label(
                                txt: controller.getBookTitle(
                                    name: controller.bookDetailResponseModel
                                        .value?.data?.book?.name),
                                type: TextTypes.f_20_500,
                                forceColor: AppColors.whiteColor,
                              ).marginOnly(left: 100)),
                        ],
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 3,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 120,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.white.withOpacity(0.9),
                            ],
                          ),
                        ),
                      ),
                    ),
                    WidgetGlobalMargin(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        padVertical(10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Label(
                                        txt: "Жүректің көзі ашылса...",
                                        type: TextTypes.f_22_700),
                                    Text(
                                      'Абай Құнанбайұлы',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: AppConst.fontFamily,
                                          decoration: TextDecoration.underline,
                                          color: AppColors.resnd),
                                    ),
                                    Text(
                                      'Абай баспасы',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: AppConst.fontFamily,
                                          decoration: TextDecoration.underline,
                                          color: AppColors.resnd),
                                    ),
                                  ]),
                              Obx(() => IconButton(
                                    onPressed: () {
                                      controller.toggleLike();
                                    },
                                    icon: Image.asset(
                                      controller.selLike.value
                                          ? AppAssets.liked
                                          : AppAssets.unliked,
                                      fit: BoxFit.contain,
                                      width: 52,
                                      height: 55,
                                    ),
                                  )),
                            ]),
                        padVertical(25),
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
                                          for (int index = 0;
                                              index < 2;
                                              index++)
                                            GestureDetector(
                                              onTap: () => controller
                                                  .setSelectedIndex(index),
                                              child: Container(
                                                width: tabWidth,
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  AppLocalization.of(context)
                                                      .translate(
                                                    [
                                                      AppLocalization.of(
                                                              context)
                                                          .translate(
                                                              'aboutbook'),
                                                      "${AppLocalization.of(context).translate('reviews')}(52)",
                                                    ][index],
                                                  ),
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppConst.fontFamily,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: controller
                                                                .selectedIndex
                                                                .value ==
                                                            index
                                                        ? AppColors.primaryColor
                                                        : AppColors.inputBorder,
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
                                          height: 2,
                                          color: Colors.grey.shade300,
                                        ),
                                        Obx(() => AnimatedPositioned(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              left: controller
                                                      .selectedIndex.value *
                                                  tabWidth,
                                              width: tabWidth,
                                              height: 2,
                                              child: Container(
                                                  color:
                                                      AppColors.primaryColor),
                                            )),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                        padVertical(20),
                        Obx(() => controller.selectedIndex.value == 0
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppColors.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        height: 30,
                                                        width: 30,
                                                        AppAssets.category,
                                                        fit: BoxFit.contain,
                                                      ),
                                                      padVertical(3),
                                                      Label(
                                                          txt: AppLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'category'),
                                                          type: TextTypes
                                                              .f_12_400)
                                                    ]))),
                                        Container(
                                            height: 75,
                                            width: 75,
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    height: 30,
                                                    width: 30,
                                                    AppAssets.audioebook,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  padVertical(3),
                                                  Label(
                                                      txt: AppLocalization.of(
                                                              context)
                                                          .translate(
                                                              'audio&ebook'),
                                                      type: TextTypes.f_12_400)
                                                ])),
                                        Container(
                                            height: 75,
                                            width: 75,
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    height: 30,
                                                    width: 30,
                                                    AppAssets.language,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  padVertical(3),
                                                  Label(
                                                      txt: AppLocalization.of(
                                                              context)
                                                          .translate(
                                                              'language'),
                                                      type: TextTypes.f_12_400)
                                                ])),
                                        Container(
                                            height: 75,
                                            width: 75,
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    height: 30,
                                                    width: 30,
                                                    AppAssets.reader,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  padVertical(3),
                                                  const Label(
                                                      txt: "0 Читатели",
                                                      type: TextTypes.f_12_400)
                                                ])),
                                      ],
                                    ),
                                    padVertical(20),
                                    const Label(
                                      txt:
                                          "Қоғам қайраткері, қазақ ақыны, жазушы, лингвист-ғалым, Қазақ КСР Халық жазушысы (1990), Қазақстанның Еңбек Ері (2016)[1]. Халықаралық антиядролық қозғалысының негізін салушысы.",
                                      type: TextTypes.f_16_500,
                                      forceColor: AppColors.resnd,
                                    ),
                                    padVertical(10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Label(
                                          txt: AppLocalization.of(context)
                                              .translate('readmore'),
                                          type: TextTypes.f_15_400,
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                          size: 30,
                                        )
                                      ],
                                    ),
                                    padVertical(10),
                                    Label(
                                      txt: AppLocalization.of(context)
                                          .translate('relatedgenres'),
                                      type: TextTypes.f_15_500,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(3, (index) {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12.0,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                  color: AppColors.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 4,
                                                      offset: Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: const Label(
                                                  txt: "🔍 Поэзия",
                                                  type: TextTypes.f_18_400,
                                                ),
                                              ));
                                        }),
                                      ),
                                    ),
                                    padVertical(20),
                                    Label(
                                      txt: AppLocalization.of(context)
                                          .translate('author'),
                                      type: TextTypes.f_15_500,
                                    ),
                                    padVertical(10),
                                    GestureDetector(
                                        onTap: () {
                                          // Get.to(() => const PgAuthordetail());
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              ClipOval(
                                                child: Image.asset(
                                                  AppAssets.book,
                                                  width: 85,
                                                  height: 85,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              padHorizontal(15),
                                              const Label(
                                                txt: "Абай Құнанбайұлы",
                                                type: TextTypes.f_15_500,
                                              ),
                                            ]),
                                            const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 18,
                                            )
                                          ],
                                        )),
                                    padVertical(20),
                                    GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Label(
                                                txt: AppLocalization.of(context)
                                                    .translate('relatedbooks'),
                                                type: TextTypes.f_15_500),
                                            const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 18,
                                            )
                                          ],
                                        )),
                                    padVertical(10),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(6, (index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  // Get.to(() => const PgBookView());
                                                },
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: 144,
                                                        width: 144,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          child: Center(
                                                            child: Image.asset(
                                                              AppAssets.book,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      padVertical(5),
                                                      const Label(
                                                          txt: "Көксерек",
                                                          type: TextTypes
                                                              .f_13_500),
                                                      const Label(
                                                        txt: "Мұхтар Әуезов",
                                                        type:
                                                            TextTypes.f_13_400,
                                                        forceColor:
                                                            AppColors.resnd,
                                                      ),
                                                    ])),
                                          );
                                        }),
                                      ),
                                    ),
                                    padVertical(10),
                                    Label(
                                        txt: AppLocalization.of(context)
                                            .translate('tags'),
                                        type: TextTypes.f_16_500),
                                    const Label(
                                        txt:
                                            "#Абай #поэзия #өлең #кітап #даналық #қазақша",
                                        type: TextTypes.f_16_300),
                                    padVertical(10),
                                  ])
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.bottomSheet(
                                        ReviewSheet(),
                                        isScrollControlled: true,
                                        backgroundColor: AppColors.whiteColor,
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 0.6,
                                        ),
                                      ),
                                      child: Center(
                                        child: Label(
                                          txt: AppLocalization.of(context)
                                              .translate('leavereview'),
                                          forceColor: AppColors.primaryColor,
                                          type: TextTypes.f_17_400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  padVertical(20),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.background,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(5, (index) {
                                            final rating = 5 - index;
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: Row(
                                                children: [
                                                  Label(
                                                    txt: '$rating',
                                                    type: TextTypes.f_15_400,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  const Icon(Icons.star,
                                                      color: Colors.amber,
                                                      size: 16),
                                                  const SizedBox(width: 8),
                                                  SizedBox(
                                                    width: 100,
                                                    child:
                                                        LinearProgressIndicator(
                                                      value: (5 - index) * 0.2,
                                                      color: AppColors
                                                          .starprogress,
                                                      backgroundColor:
                                                          AppColors.background,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Label(
                                                txt: '4.0',
                                                type: TextTypes.f_34_700),
                                            Row(
                                              children: List.generate(
                                                5,
                                                (index) => Icon(
                                                  index < 4
                                                      ? Icons.star
                                                      : Icons.star_border,
                                                  color: Colors.amber,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Label(
                                              txt:
                                                  '52 ${AppLocalization.of(context).translate('reviews')}',
                                              type: TextTypes.f_15_400,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: List.generate(3, (index) {
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12.0, top: 10),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(children: [
                                                      ClipOval(
                                                        child: Image.asset(
                                                          AppAssets.book,
                                                          width: 38,
                                                          height: 38,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      padHorizontal(10),
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Label(
                                                              txt: "Камила Н.",
                                                              type: TextTypes
                                                                  .f_16_500,
                                                            ),
                                                            Row(
                                                              children:
                                                                  List.generate(
                                                                5,
                                                                (index) => Icon(
                                                                  index < 4
                                                                      ? Icons
                                                                          .star
                                                                      : Icons
                                                                          .star_border,
                                                                  color: Colors
                                                                      .amber,
                                                                  size: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ]),
                                                    ]),
                                                    Image.asset(
                                                      AppAssets.dots2,
                                                      width: 4,
                                                      height: 16,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ],
                                                ),
                                                padVertical(10),
                                                const Label(
                                                  txt: "Өте тамаша кітап. ",
                                                  type: TextTypes.f_13_400,
                                                ),
                                                padVertical(10),
                                                const Divider()
                                              ]));
                                    }),
                                  ),
                                ],
                              )),
                      ],
                    )).marginOnly(top: Get.height * 0.25),
                  ],
                ),
              ],
            )),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Label(
                  txt: AppLocalization.of(context).translate('price'),
                  type: TextTypes.f_15_400,
                  forceColor: AppColors.resnd,
                ),
                const Label(
                  txt: "2500₸",
                  type: TextTypes.f_20_500,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const PgCartscreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Label(
                txt: AppLocalization.of(context).translate('buynow'),
                type: TextTypes.f_17_500,
                forceColor: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
