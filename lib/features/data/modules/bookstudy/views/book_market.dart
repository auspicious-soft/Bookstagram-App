import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../app_settings/components/loader.dart';
import '../../../../../app_settings/constants/app_config.dart';
import '../../home_module/controller/searchcontroller.dart';
import '../../home_module/models/CollectionDataModel.dart';
import '../../home_module/view/search_screen.dart';
import '../controllers/book_market_controller.dart';

class PgBookmarket extends GetView<PgBookmarketController> {
  const PgBookmarket({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Initialize TextEditingController and sync with searchQuery
    final TextEditingController searchController = TextEditingController(
      text: controller.searchQuery.value,
    );

    // Listen to searchQuery changes to keep the TextField in sync
    ever(controller.searchQuery, (String value) {
      if (searchController.text != value) {
        searchController.text = value;
      }
    });

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Obx(() => controller.isLoading.value
            ? SizedBox(
                height: Get.height,
                width: Get.width,
                child: const Center(child: LoadingScreen()),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        AppAssets.bookmarkett,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 15,
                        left: 10,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.black),
                          onPressed: controller.goBack,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 4.1,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Label(
                          txt: AppLocalization.of(context)
                              .translate('boundlessbooks'),
                          type: TextTypes.f_34_700,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 50,
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
                                  onTap: () {
                                    Get.put(TabSearchController())
                                        .searchController
                                        .clear();
                                    Get.to(() => PgTabsearch());
                                  },
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: AppLocalization.of(context)
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
                        padVertical(15),
                        GestureDetector(
                          onTap: controller.navigateToCategory,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Label(
                                txt: AppLocalization.of(context)
                                    .translate('Categories'),
                                type: TextTypes.f_20_500,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: screenWidth * 0.045,
                              ),
                            ],
                          ),
                        ),
                        padVertical(15),
                        Obx(() => _buildButtonGrid(context)
                            .marginSymmetric(vertical: 20)),
                        padVertical(20),
                        _buildCollectionsTab(context),
                        if (controller.bookMarket.value?.data?.bestSellers
                                ?.isNotEmpty ??
                            false) ...[
                          padVertical(20),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed("/allcollections", arguments: {
                                "title":
                                    '${AppLocalization.of(context).translate('bestsellers')}🔥',
                                "id": "",
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Label(
                                  txt:
                                      '${AppLocalization.of(context).translate('bestsellers')}🔥',
                                  type: TextTypes.f_20_500,
                                ),
                                const Icon(Icons.arrow_forward_ios_rounded,
                                    size: 18),
                              ],
                            ),
                          ),
                          padVertical(20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                controller.bookMarket.value?.data?.bestSellers
                                        ?.length ??
                                    0,
                                (index) => GestureDetector(
                                  onTap: () {
                                    final book = controller.bookMarket.value
                                        ?.data?.bestSellers?[index]?.book;
                                    Get.toNamed(
                                      book?.type == "course"
                                          ? '/Course-detail'
                                          : '/book-detail',
                                      arguments: {"id": book?.sId},
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 144,
                                          width: 144,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              "${AppConfig.imgBaseUrl}${controller.bookMarket.value?.data?.bestSellers?[index]?.book?.image}",
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(AppAssets.book,
                                                      fit: BoxFit.contain),
                                            ),
                                          ),
                                        ),
                                        padVertical(5),
                                        Label(
                                          txt: controller.getBookTitle(
                                            name: controller
                                                .bookMarket
                                                .value
                                                ?.data
                                                ?.bestSellers?[index]
                                                ?.book
                                                ?.name,
                                          ),
                                          type: TextTypes.f_13_500,
                                        ),
                                        Label(
                                          txt: controller.getBookTitle(
                                            name: controller
                                                .bookMarket
                                                .value
                                                ?.data
                                                ?.bestSellers?[index]
                                                ?.book
                                                ?.authors
                                                ?.name,
                                          ),
                                          type: TextTypes.f_13_400,
                                          forceColor: AppColors.resnd,
                                        ),
                                        Label(
                                          txt: controller
                                                  .bookMarket
                                                  .value
                                                  ?.data
                                                  ?.bestSellers?[index]
                                                  ?.book
                                                  ?.genre
                                                  ?.first ??
                                              "",
                                          type: TextTypes.f_12_400,
                                          forceColor: AppColors.resnd,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          padVertical(20),
                        ],
                        if (controller.bookMarket.value?.data?.readProgress
                                ?.isNotEmpty ??
                            false) ...[
                          GestureDetector(
                            onTap: controller.navigateToCourses,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Label(
                                  txt:
                                      '${AppLocalization.of(context).translate('continuereading')} 💌',
                                  type: TextTypes.f_20_500,
                                ),
                                const Icon(Icons.arrow_forward_ios_rounded,
                                    size: 18),
                              ],
                            ),
                          ),
                          padVertical(10),
                          SizedBox(
                            height: 160,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.bookMarket.value?.data
                                      ?.readProgress?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                final book = controller.bookMarket.value?.data
                                    ?.readProgress?[index];
                                return Container(
                                  width: ScreenUtils.screenWidth(context) * 0.9,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: AppColors.border,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image.network(
                                          "${AppConfig.imgBaseUrl}${book?.bookId?.image}",
                                          width: 113,
                                          height: 144,
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            AppAssets.book,
                                            width: 113,
                                            height: 144,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Label(
                                              txt: controller.getBookTitle(
                                                  name: book?.bookId?.name),
                                              type: TextTypes.f_15_500,
                                            ),
                                            Label(
                                              txt: controller.getBookTitle(
                                                name: book?.bookId?.authorId
                                                    ?.first?.name,
                                              ),
                                              type: TextTypes.f_15_400,
                                              forceColor: AppColors.resnd,
                                            ),
                                            Label(
                                              txt: book?.bookId?.type ?? "",
                                              type: TextTypes.f_13_400,
                                              forceColor: AppColors.resnd,
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child:
                                                        LinearProgressIndicator(
                                                      value: (book?.progress ??
                                                              0) /
                                                          100,
                                                      backgroundColor:
                                                          AppColors.inputBorder,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              AppColors
                                                                  .primaryColor),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Label(
                                                  txt:
                                                      "${book?.progress?.toString()}%",
                                                  type: TextTypes.f_12_400,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 2),
                                            SizedBox(
                                              height: 38,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Get.toNamed(
                                                    book?.bookId?.type ==
                                                            "course"
                                                        ? '/Course-detail'
                                                        : '/book-detail',
                                                    arguments: {
                                                      "id": book?.bookId?.sId
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0.0,
                                                  backgroundColor:
                                                      AppColors.primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                child: Label(
                                                  txt: AppLocalization.of(
                                                          context)
                                                      .translate('continue'),
                                                  type: TextTypes.f_13_400,
                                                  forceColor:
                                                      AppColors.whiteColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          padVertical(30),
                        ],
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(2, (index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed("/Collection_Summary",
                                      arguments: {
                                        "title": index == 0
                                            ? AppLocalization.of(context)
                                                .translate('strAllCollections')
                                            : AppLocalization.of(context)
                                                .translate('strSummary'),
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Stack(
                                    children: [
                                      index == 1
                                          ? Container(
                                              width: ScreenUtils.screenWidth(
                                                      context) /
                                                  1.4,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8)),
                                              child: Image.asset(
                                                AppAssets.MarketSlider,
                                                width: ScreenUtils.screenWidth(
                                                        context) /
                                                    1.4,
                                                height: 80,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                      Label(
                                        txt: index == 0
                                            ? AppLocalization.of(context)
                                                .translate('strAllCollections')
                                            : AppLocalization.of(context)
                                                .translate('strSummary'),
                                        type: TextTypes.f_18_700,
                                        forceColor: AppColors.whiteColor,
                                        forceAlignment: TextAlign.center,
                                      ).marginSymmetric(
                                          horizontal: 30, vertical: 20),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        padVertical(25),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed("/allcollections", arguments: {
                              "title":
                                  '${AppLocalization.of(context).translate('Audiobooks')}🎧',
                              "id": "",
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Label(
                                txt:
                                    '${AppLocalization.of(context).translate('Audiobooks')}🎧',
                                type: TextTypes.f_20_500,
                              ),
                              const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 18),
                            ],
                          ),
                        ),
                        padVertical(15),
                        Obx(() => Column(
                              children: List.generate(
                                controller.bookMarket.value?.data?.audiobooks
                                        ?.length ??
                                    0,
                                (index) {
                                  final publisher = controller.bookMarket.value
                                      ?.data?.audiobooks?[index];
                                  return GestureDetector(
                                    onTap: () =>
                                        controller.navigateToAudioBook(index),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 12.0, top: 10),
                                      child: Row(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.white,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    "${AppConfig.imgBaseUrl}${publisher?.productId?.image}",
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(
                                                            AppAssets.book,
                                                            fit:
                                                                BoxFit.contain),
                                                  ),
                                                ),
                                              ),
                                              const Positioned(
                                                top: 40,
                                                left: 35,
                                                child: Icon(
                                                  Icons.play_circle_filled,
                                                  size: 28,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          padHorizontal(10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              padVertical(5),
                                              Label(
                                                txt: controller.getBookTitle(
                                                        name: publisher
                                                            ?.productId
                                                            ?.name) ??
                                                    'Unknown',
                                                type: TextTypes.f_13_500,
                                              ),
                                              Label(
                                                txt: controller.getBookTitle(
                                                      name: publisher
                                                          ?.productId
                                                          ?.authorId
                                                          ?.first
                                                          .name,
                                                    ) ??
                                                    'Unknown',
                                                type: TextTypes.f_12_400,
                                                forceColor: AppColors.resnd,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )),
                        padVertical(20),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed("/allcollections", arguments: {
                              "title":
                                  '${AppLocalization.of(context).translate('newbooks')}💌',
                              "id": "",
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Label(
                                txt:
                                    '${AppLocalization.of(context).translate('newbooks')}💌',
                                type: TextTypes.f_20_500,
                              ),
                              const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 18),
                            ],
                          ),
                        ),
                        padVertical(20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Obx(() => Row(
                                children: List.generate(
                                  controller.bookMarket.value?.data?.newBooks
                                          ?.length ??
                                      0,
                                  (index) {
                                    final publisher = controller.bookMarket
                                        .value?.data?.newBooks?[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                            publisher?.type == "course"
                                                ? '/Course-detail'
                                                : '/book-detail',
                                            arguments: {"id": publisher?.sId},
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 144,
                                              width: 144,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  "${AppConfig.imgBaseUrl}${publisher?.image}",
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Image.asset(
                                                          AppAssets.book,
                                                          fit: BoxFit.contain),
                                                ),
                                              ),
                                            ),
                                            padVertical(5),
                                            Label(
                                              txt: controller.getBookTitle(
                                                      name: publisher?.name) ??
                                                  'Unknown',
                                              type: TextTypes.f_13_500,
                                            ),
                                            Label(
                                              txt: controller.getBookTitle(
                                                    name: publisher?.authorId
                                                            ?.first.name ??
                                                        "",
                                                  ) ??
                                                  'Unknown',
                                              type: TextTypes.f_13_500,
                                            ),
                                            Label(
                                              txt: publisher?.genre?.first ??
                                                  "Unknown",
                                              type: TextTypes.f_13_500,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )),
                        ),
                        padVertical(30),
                        GestureDetector(
                          onTap: controller.navigateToTeachers,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Label(
                                txt: AppLocalization.of(context)
                                    .translate('Authors'),
                                type: TextTypes.f_20_500,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: screenWidth * 0.045,
                              ),
                            ],
                          ),
                        ),
                        padVertical(10),
                        Obx(() => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  controller.bookMarket.value?.data?.author
                                          ?.length ??
                                      0,
                                  (index) {
                                    final author = controller
                                        .bookMarket.value?.data?.author?[index];
                                    return GestureDetector(
                                      onTap: () {
                                        if (author?.sId != null) {
                                          Get.toNamed("/teacherDetail",
                                              arguments: {
                                                "teacherId": author?.sId
                                              });
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: screenWidth * 0.03),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      screenWidth * 0.14)),
                                              child: Image.network(
                                                "${AppConfig.imgBaseUrl}${author?.image}",
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Image.asset(
                                                  AppAssets.book,
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height: screenHeight * 0.01),
                                            Label(
                                              txt: controller.getBookTitle(
                                                  name: author?.name),
                                              type: TextTypes.f_13_500,
                                              forceAlignment: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )),
                        padVertical(30),
                        GestureDetector(
                          onTap: controller.navigateToPublishers,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Label(
                                txt: AppLocalization.of(context)
                                    .translate('Publishers'),
                                type: TextTypes.f_20_500,
                              ),
                              const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 18),
                            ],
                          ),
                        ),
                        padVertical(15),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Obx(() => Row(
                                children: List.generate(
                                  controller.bookMarket.value?.data?.publisher
                                          ?.length ??
                                      0,
                                  (index) {
                                    final publisher = controller.bookMarket
                                        .value?.data?.publisher?[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (publisher?.sId != null) {
                                            Get.toNamed('/publisherDetail',
                                                arguments: {
                                                  "teacherId": publisher?.sId
                                                });
                                          }
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 144,
                                              width: 144,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  "${AppConfig.imgBaseUrl}${publisher?.image}",
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Image.asset(
                                                          AppAssets.book,
                                                          fit: BoxFit.contain),
                                                ),
                                              ),
                                            ),
                                            padVertical(5),
                                            Label(
                                              txt: controller.getBookTitle(
                                                      name: publisher?.name) ??
                                                  'Unknown',
                                              type: TextTypes.f_13_500,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
      ),
    );
  }

  Widget _buildCollectionsTab(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.bookMarket.value?.data?.collections?.data?.mindBlowing
                    ?.isNotEmpty ==
                true &&
            controller.bookMarket.value?.data?.collections?.data?.mindBlowing
                    ?.first.booksId?.isNotEmpty ==
                true) ...[
          _buildSectionHeader(
            context,
            id: controller.bookMarket.value?.data?.collections?.data
                ?.mindBlowing?.first.sId,
            controller.getBookTitle(
                name: controller.bookMarket.value?.data?.collections?.data
                    ?.mindBlowing?.first.name),
          ),
          padVertical(15),
          Obx(() {
            final books = controller.bookMarket.value?.data?.collections?.data
                    ?.mindBlowing?.first.booksId ??
                [];
            return _buildCollectionRow(books);
          }),
          padVertical(15),
        ],
        if (controller.bookMarket.value?.data?.collections?.data
                    ?.popularCollections?.isNotEmpty ==
                true &&
            controller.bookMarket.value?.data?.collections?.data
                    ?.popularCollections?.first.booksId?.isNotEmpty ==
                true) ...[
          _buildSectionHeader(
            context,
            id: controller.bookMarket.value?.data?.collections?.data
                ?.popularCollections?.first.sId,
            controller.getBookTitle(
                name: controller.bookMarket.value?.data?.collections?.data
                    ?.popularCollections?.first.name),
          ),
          padVertical(15),
          Obx(() {
            final books = controller.bookMarket.value?.data?.collections?.data
                    ?.popularCollections?.first.booksId ??
                [];
            return _buildCollectionRow(books);
          }),
          padVertical(15),
        ],
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, {String? id}) {
    return id != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Label(txt: title, type: TextTypes.f_20_500),
              GestureDetector(
                onTap: () {
                  Get.toNamed("/allcollections",
                      arguments: {"title": title, "id": id});
                },
                child: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
              ),
            ],
          )
        : const SizedBox();
  }

  Widget _buildButtonGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Wrap(
      spacing: screenWidth * 0.015,
      runSpacing: screenWidth * 0.025,
      children: controller.bookMarket.value?.data?.categories
              ?.asMap()
              .entries
              .map((entry) {
            final index = entry.key;
            final item = entry.value;
            return IntrinsicWidth(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed("/categoryById", arguments: {
                    "teacherId": controller
                        .bookMarket.value?.data?.categories?[index].sId,
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.02,
                    horizontal: screenWidth * 0.04,
                  ),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        child: item.image != null
                            ? Image.network(
                                height: 20,
                                width: 20,
                                "${AppConfig.imgBaseUrl}${controller.bookMarket.value?.data?.categories?[index].image}",
                                errorBuilder: (context, error, stackTrace) =>
                                    const Label(
                                  txt: "📋",
                                  type: TextTypes.f_18_400,
                                ),
                              )
                            : const Label(txt: "📋", type: TextTypes.f_18_400),
                      ),
                      Flexible(
                        child: Label(
                          maxLines: 3,
                          txt: controller.getBookTitle(name: item.name) ??
                              'Unknown',
                          type: TextTypes.f_18_400,
                        ).marginSymmetric(horizontal: 8),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList() ??
          [],
    );
  }

  Widget _buildCollectionRow(List<BooksId> books) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: books.map((book) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(
                book.type == "course" ? '/Course-detail' : '/book-detail',
                arguments: {"id": book.sId},
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 144,
                    width: 144,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "${AppConfig.imgBaseUrl}${book.image}",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          AppAssets.book,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  padVertical(5),
                  Label(
                    txt: controller.getBookTitle(name: book.name) ?? 'Unknown',
                    type: TextTypes.f_13_500,
                  ),
                  Label(
                    txt: controller.getBookTitle(
                          name: book.authorId?.isNotEmpty == true
                              ? book.authorId?.first.name
                              : null,
                        ) ??
                        'Unknown',
                    type: TextTypes.f_13_400,
                    forceColor: AppColors.resnd,
                  ),
                  if (book.genre?.isNotEmpty == true)
                    Label(
                      txt: book.genre!.first,
                      type: TextTypes.f_12_400,
                      forceColor: AppColors.resnd,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
