import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../app_settings/components/label.dart';
import '../../../../../app_settings/components/loader.dart';
import '../../../../../app_settings/components/widget_global_margin.dart';
import '../../../../../app_settings/constants/app_assets.dart';
import '../../../../../app_settings/constants/app_colors.dart';
import '../../../../../app_settings/constants/app_dim.dart';
import '../../../../../localization/app_localization.dart';
import '../../../../presentation/Pages/Support/pg_support.dart';
import '../controller/profile_controller.dart';
import 'aboutus_screen.dart';

class PgTabprofile extends GetView<ProfileController> {
  const PgTabprofile({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.background, // Set status bar color
        statusBarIconBrightness:
            Brightness.dark, // Ensure icons are visible on white
      ),
    );
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
                            Center(
                              child: Label(
                                txt: AppLocalization.of(context)
                                    .translate('profile'),
                                type: TextTypes.f_20_500,
                              ),
                            ),
                            padVertical(10),
                            GestureDetector(
                                onTap: () async {
                                  await Get.toNamed("/editProfile");
                                  controller.getProfileApiCall();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      ClipOval(
                                          child: controller
                                                          .proileData
                                                          .value
                                                          ?.data
                                                          ?.data
                                                          ?.profilePic !=
                                                      null ||
                                                  controller
                                                          .proileData
                                                          .value
                                                          ?.data
                                                          ?.data
                                                          ?.profilePic
                                                          ?.isNotEmpty ==
                                                      true
                                              ? Image.network(
                                                  controller
                                                              .proileData
                                                              .value
                                                              ?.data
                                                              ?.data
                                                              ?.profilePic!
                                                              .startsWith(
                                                                  'http') ==
                                                          true
                                                      ? controller
                                                              .proileData
                                                              .value
                                                              ?.data
                                                              ?.data
                                                              ?.profilePic ??
                                                          ""
                                                      : "${AppConfig.imgBaseUrl}${controller.proileData.value?.data?.data?.profilePic}",
                                                  fit: BoxFit.cover,
                                                  height: 100,
                                                  width: 100,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Container(
                                                      color: AppColors.grey,
                                                      child: Icon(
                                                        Icons
                                                            .person, // Error image/icon
                                                        size: 60,
                                                        color: AppColors.grey,
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(
                                                  color: AppColors.grey,
                                                  child: Icon(
                                                    Icons
                                                        .person, // Error image/icon
                                                    size: 60,
                                                    color: AppColors.grey,
                                                  ),
                                                )),
                                      padHorizontal(15),
                                      Obx(() => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Label(
                                                  txt:
                                                      "${controller.getBookTitle(name: controller?.proileData?.value?.data?.data?.fullName)}",
                                                  type: TextTypes.f_20_500,
                                                ),
                                                Label(
                                                  txt:
                                                      "${controller.proileData.value?.data?.data?.email ?? ""}",
                                                  type: TextTypes.f_13_400,
                                                  forceColor:
                                                      AppColors.smallTxt,
                                                ),
                                              ]))
                                    ]),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 18,
                                    )
                                  ],
                                )),
                            padVertical(20),
                            Obx(() => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: Get.height * 0.1,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            gradient: const LinearGradient(
                                              colors: [
                                                AppColors.blueLinear,
                                                AppColors.greenLinear
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(
                                                  1), // Gradient border width
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: AppColors.background,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      AppAssets.readbook,
                                                      width: 45,
                                                      height: 45,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    padHorizontal(20),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Label(
                                                              txt:
                                                                  "${controller.proileData?.value?.data?.booksReadCount?.toString()}",
                                                              type: TextTypes
                                                                  .f_17_500,
                                                            ),
                                                            Label(
                                                              txt: AppLocalization
                                                                      .of(
                                                                          context)
                                                                  .translate(
                                                                      'books'),
                                                              type: TextTypes
                                                                  .f_13_400,
                                                            ),
                                                          ],
                                                        ),
                                                        Label(
                                                          txt: AppLocalization
                                                                  .of(context)
                                                              .translate(
                                                                  'read'),
                                                          type: TextTypes
                                                              .f_13_400,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                      padHorizontal(20),
                                      Expanded(
                                          child: Container(
                                        height: Get.height * 0.1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          gradient: const LinearGradient(
                                            colors: [
                                              AppColors.linearLightOrg,
                                              AppColors.linearDarkOrg
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(1),
                                            child: Container(
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: AppColors.background,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    AppAssets.level,
                                                    width: 45,
                                                    height: 45,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  padHorizontal(30),
                                                  Column(
                                                    children: [
                                                      const Label(
                                                        txt: "0",
                                                        type:
                                                            TextTypes.f_16_500,
                                                      ),
                                                      Label(
                                                        txt: AppLocalization.of(
                                                                context)
                                                            .translate('level'),
                                                        type:
                                                            TextTypes.f_13_400,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )),
                                      ))
                                    ])),
                            padVertical(25),
                            Row(
                              children: [
                                Label(
                                  txt: AppLocalization.of(context)
                                      .translate('general'),
                                  type: TextTypes.f_13_400,
                                  forceColor: AppColors.resnd,
                                ),
                                padHorizontal(20),
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.3, color: AppColors.resnd)),
                                ))
                              ],
                            ),
                            padVertical(25),
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed("/balanceScreen");
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Image.asset(
                                        AppAssets.blance,
                                        width: 22,
                                        height: 22,
                                        fit: BoxFit.contain,
                                      ),
                                      padHorizontal(15),
                                      Label(
                                        txt: AppLocalization.of(context)
                                            .translate('balance'),
                                        type: TextTypes.f_17_500,
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
                              onTap: () {
                                Get.toNamed("/levels");
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Image.asset(
                                      AppAssets.levels,
                                      width: 22,
                                      height: 22,
                                      fit: BoxFit.contain,
                                    ),
                                    padHorizontal(15),
                                    Label(
                                      txt: AppLocalization.of(context)
                                          .translate('levels'),
                                      type: TextTypes.f_17_500,
                                    ),
                                  ]),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                            padVertical(15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                    AppAssets.noti,
                                    width: 22,
                                    height: 22,
                                    fit: BoxFit.contain,
                                  ),
                                  padHorizontal(15),
                                  Label(
                                    txt: AppLocalization.of(context)
                                        .translate('notifications'),
                                    type: TextTypes.f_17_500,
                                  ),
                                ]),
                                Obx(() => SizedBox(
                                      height: 50,
                                      width: 70, // give desired width here
                                      child: Transform.scale(
                                        scale: 0.7,
                                        // Increase/decrease to adjust visual size
                                        child: Switch(
                                          value: controller.isSwitched.value,
                                          onChanged: controller.toggleSwitch,
                                          activeColor: AppColors.toggleBtn,
                                          thumbColor:
                                              WidgetStateColor.transparent,
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                            padVertical(15),
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed("/language");
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Image.asset(
                                        AppAssets.lang,
                                        width: 22,
                                        height: 22,
                                        fit: BoxFit.contain,
                                      ),
                                      padHorizontal(15),
                                      Label(
                                        txt: AppLocalization.of(context)
                                            .translate('languages'),
                                        type: TextTypes.f_17_500,
                                      ),
                                    ]),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 18,
                                    )
                                  ],
                                )),
                            padVertical(25),
                            Row(
                              children: [
                                Label(
                                  txt: AppLocalization.of(context)
                                      .translate('about'),
                                  type: TextTypes.f_13_400,
                                  forceColor: AppColors.resnd,
                                ),
                                padHorizontal(20),
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.3, color: AppColors.resnd)),
                                ))
                              ],
                            ),
                            padVertical(25),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PgSupport(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Image.asset(
                                        AppAssets.support,
                                        width: 22,
                                        height: 22,
                                        fit: BoxFit.contain,
                                      ),
                                      padHorizontal(15),
                                      Label(
                                        txt: AppLocalization.of(context)
                                            .translate('support'),
                                        type: TextTypes.f_17_500,
                                      ),
                                    ]),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 18,
                                    )
                                  ],
                                )),
                            padVertical(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset(
                                    AppAssets.privacy,
                                    width: 22,
                                    height: 22,
                                    fit: BoxFit.contain,
                                  ),
                                  padHorizontal(15),
                                  Label(
                                    txt: AppLocalization.of(context)
                                        .translate('privacypolicy'),
                                    type: TextTypes.f_17_500,
                                  ),
                                ]),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                )
                              ],
                            ),
                            padVertical(20),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PgAboutUs(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Image.asset(
                                        AppAssets.about,
                                        width: 22,
                                        height: 22,
                                        fit: BoxFit.contain,
                                      ),
                                      padHorizontal(15),
                                      Label(
                                        txt: AppLocalization.of(context)
                                            .translate('about'),
                                        type: TextTypes.f_17_500,
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
                              onTap: controller.logout,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Image.asset(AppAssets.logout,
                                        width: 22, height: 22),
                                    padHorizontal(15),
                                    Label(
                                      txt: AppLocalization.of(context)
                                          .translate('logout'),
                                      type: TextTypes.f_17_500,
                                      forceColor: AppColors.red,
                                    ),
                                  ]),
                                  const Icon(Icons.arrow_forward_ios_rounded,
                                      size: 18),
                                ],
                              ),
                            ),
                            padVertical(20),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
        ),
      ),
    );
  }
}
