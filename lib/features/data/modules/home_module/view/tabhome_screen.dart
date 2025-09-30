import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/loader.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/features/data/models/homedata_model.dart';
import 'package:bookstagram/features/presentation/Pages/Notification/pg_notification.dart';
import 'package:bookstagram/features/presentation/Pages/StoryScreen/pg_storyscreen.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../app_settings/constants/app_dim.dart';
import '../../../../../app_settings/constants/helpers.dart';
import '../../../../presentation/widgets/home_subwidget.dart';
import '../Players/views/epub_reader.dart';
import '../controller/dashboard_controller.dart';
import '../controller/searchcontroller.dart';
import '../controller/tabhome_controller.dart';
import '../models/homeProductModel.dart';

class TabhomeScreen extends GetView<HomeDataController> {
  const TabhomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;

    // Call getHomeData when the page is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getHomeData(context: context);
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() => controller.isLoading.value
            ? SizedBox(
                height: Get.height,
                width: Get.width,
                child: const Center(child: LoadingScreen()))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await controller.refreshData(Get.context!);
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            padVertical(20),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(children: [
                                    Label(
                                        txt:
                                            "${AppLocalization.of(context).translate('hello')},",
                                        type: TextTypes.f_20_700),
                                    const Label(
                                      txt: "Duman!",
                                      type: TextTypes.f_20_500i,
                                      forceAlignment: TextAlign.center,
                                      forceColor: AppColors.primaryColor,
                                    )
                                  ]),
                                  GestureDetector(
                                      onTap: () {
                                        Get.toNamed("/Notifications");
                                      },
                                      child: const Icon(
                                          Icons.notifications_none_outlined))
                                ]),
                            padVertical(15),
                            _buildStories(controller.homeData.value),
                            padVertical(15),
                            GestureDetector(
                                onTap: () {
                                  final dashboardController =
                                      Get.find<DashboardController>();
                                  dashboardController.changeTab(1);
                                },
                                child: _buildSearchBar(context)),
                            padVertical(15),
                            _buildFeatureButtons(context),
                            padVertical(15),
                            _buildContinueReading(),
                            padVertical(15),
                            _buildCarouselSlider(controller.homeData.value),
                            padVertical(15),
                            _buildTabContent(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ).marginSymmetric(horizontal: 20)),
      ),
    );
  }

  Widget _buildStories(HomeDataModel? findata) {
    // Handle null or empty stories
    if (findata == null ||
        findata.data == null ||
        findata.data!.stories == null ||
        findata.data!.stories!.isEmpty) {
      return const SizedBox
          .shrink(); // Or a placeholder like Text("No stories available")
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          findata.data!.stories!.length,
          (index) {
            final Story? story = findata.data!.stories![index];
            if (story == null || story.file == null || story.file!.isEmpty) {
              return const SizedBox.shrink();
            }
            String? firstImageKey = story.file!.keys.first;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => PgStoryscreen(story: story));
                },
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.centerLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: firstImageKey != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "${AppConfig.imgBaseUrl}$firstImageKey",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.image_not_supported,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : const Icon(
                                Icons.image_not_supported,
                                size: 30,
                                color: Colors.grey,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        filled: true,
        enabled: false,
        fillColor: AppColors.border,
        hintText: AppLocalization.of(context).translate('search'),
        hintStyle: const TextStyle(
          color: AppColors.inputBorder,
          fontFamily: AppConst.fontFamily,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Image.asset(
            height: 15,
            width: 15,
            AppAssets.search,
            fit: BoxFit.contain,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border2, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border2, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border2, width: 2),
        ),
      ),
      style: const TextStyle(
        color: AppColors.blackColor,
        fontFamily: AppConst.fontFamily,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildFeatureButtons(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FeatureButton(
              imagePath: AppAssets.bookmarket,
              labelKey: 'Bookmarket',
              onTap: () => Get.toNamed("bookMarket"),
            ),
            FeatureButton(
              imagePath: AppAssets.room,
              labelKey: 'Bookroom',
              onTap: () => Get.toNamed("/book_room"),
            ),
            FeatureButton(
                imagePath: AppAssets.school,
                labelKey: 'Bookschool',
                onTap: () => {
                      if (controller.homeData.value?.data?.userSchoolVoucher ==
                          true)
                        {Get.toNamed("/book-school-List")}
                      else
                        {Get.toNamed("/book-schoolCoupon")}
                    }),
            FeatureButton(
              imagePath: AppAssets.study,
              labelKey: 'Bookstudy',
              onTap: () => Get.toNamed("/bookstudy"),
            ),
          ],
        ),
        padVertical(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FeatureButton(
              imagePath: AppAssets.uni,
              labelKey: 'Bookuniversity',
              onTap: () => Get.toNamed("/bookuniversity"),
            ),
            FeatureButton(
              imagePath: AppAssets.master,
              labelKey: 'Bookmasters',
              onTap: () => Get.toNamed("/bookmaster"),
            ),
            FeatureButton(
              imagePath: AppAssets.event,
              labelKey: 'Bookrvents',
              onTap: () => Get.toNamed("/bookevent"),
            ),
            FeatureButton(
              imagePath: AppAssets.booklife,
              labelKey: 'Booklife',
              onTap: () => Get.toNamed("/booklife"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContinueReading() {
    final readProgress = controller.homeData.value?.data?.readProgress;
    if (readProgress == null || readProgress.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: readProgress.length,
        itemBuilder: (context, index) {
          final book = readProgress[index];
          if (book?.bookId == null) {
            return const SizedBox.shrink();
          }
          return Container(
            width: ScreenUtils.screenWidth(context) * 0.9,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: book.bookId!.image != null
                      ? Image.network(
                          width: 113,
                          height: 144,
                          "${AppConfig.imgBaseUrl}${book.bookId!.image}",
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            AppAssets.book,
                            width: 113,
                            height: 144,
                            fit: BoxFit.fill,
                          ),
                        )
                      : Image.asset(
                          width: 113,
                          height: 144,
                          AppAssets.book,
                          fit: BoxFit.fill,
                        ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Label(
                        txt: controller.getBookTitle(name: book.bookId!.name),
                        type: TextTypes.f_15_500,
                      ),
                      Label(
                        txt: controller.getBookTitle(
                            name: book.bookId!.authorId?.first?.name ?? ''),
                        type: TextTypes.f_15_400,
                        forceColor: AppColors.resnd,
                      ),
                      Label(
                        txt: book.bookId!.type ?? "",
                        type: TextTypes.f_13_400,
                        forceColor: AppColors.resnd,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: LinearProgressIndicator(
                                value: (book.progress ?? 0) / 100,
                                backgroundColor: AppColors.inputBorder,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primaryColor),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Label(
                            txt: "${book.progress?.toString() ?? '0'}%",
                            type: TextTypes.f_12_400,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      SizedBox(
                        height: 38,
                        child: ElevatedButton(
                          onPressed: () {
                            if (book.bookId!.type == "course") {
                              Get.toNamed('/Course-detail',
                                  arguments: {"id": book.bookId!.sId});
                            } else {
                              Get.toNamed('/book-detail',
                                  arguments: {"id": book.bookId!.sId});
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Label(
                            txt: AppLocalization.of(context)
                                .translate('continue'),
                            type: TextTypes.f_13_400,
                            forceColor: AppColors.whiteColor,
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
    );
  }

  Widget _buildCarouselSlider(HomeDataModel? findata) {
    if (findata?.data?.banners == null || findata!.data!.banners!.isEmpty) {
      return const SizedBox.shrink();
    }

    return CarouselSlider.builder(
      itemCount: findata.data!.banners!.length,
      itemBuilder: (context, index, realIndex) {
        final banner = findata.data!.banners![index];
        if (banner.image == null || banner.image!.isEmpty) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black,
            ),
            child: const Center(
              child: Label(
                txt: "No Image",
                type: TextTypes.f_13_600,
                forceColor: Colors.white,
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: () async {
            final Uri url = Uri.parse(banner.link ?? "");
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              print("Could not launch $url");
            }
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage("${AppConfig.imgBaseUrl}${banner.image}"),
                fit: BoxFit.cover,
              ),
            ),
          ).marginSymmetric(horizontal: 10),
        );
      },
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        enlargeCenterPage: false,
        viewportFraction: 1.0,
        padEnds: false,
      ),
    );
  }

  Widget _buildTabContent(BuildContext context) {
    return Obx(() {
      final selectedIndex = controller.selectedTabIndex.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () {
                              controller.setSelectedTab(index);
                              controller.updateIndicatorPosition(index);
                              if (index == 0) {
                                controller.fetchBooks("stock");
                              } else if (index == 1) {
                                controller.fetchBooks("collections");
                              } else {
                                controller.fetchBooks("blog");
                              }
                            },
                            child: Container(
                              key: controller.tabKeys[index],
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                AppLocalization.of(context).translate(
                                  [
                                    '🔥${AppLocalization.of(context).translate('Stock')}',
                                    '📚${AppLocalization.of(context).translate('Collections')}',
                                    '💡${AppLocalization.of(context).translate('Blog')}',
                                  ][index],
                                ),
                                style: TextStyle(
                                  fontFamily: AppConst.fontFamily,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: selectedIndex == index
                                      ? AppColors.primaryColor
                                      : AppColors.blackColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Obx(() => Stack(
                        children: [
                          Container(
                            height: 2,
                            color: Colors.grey.shade300,
                          ),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            left: controller.indicatorLeft.value,
                            width: controller.indicatorWidth.value,
                            height: 2,
                            child: Container(color: AppColors.primaryColor),
                          ),
                        ],
                      )),
                ],
              );
            },
          ),
          padVertical(15),
          if (selectedIndex == 0)
            Obx(() => controller.isloadlist.value
                ? SizedBox(
                    height: Get.height * 0.3,
                    child: const Center(child: CircularProgressIndicator()))
                : _buildStockTab(context)),
          if (selectedIndex == 1)
            Obx(() => controller.isloadlist.value
                ? SizedBox(
                    height: Get.height * 0.3,
                    child: const Center(child: CircularProgressIndicator()))
                : _buildCollectionsTab(context)),
          if (selectedIndex == 2)
            Obx(() => controller.isloadlist.value
                ? SizedBox(
                    height: Get.height * 0.3,
                    child: const Center(child: CircularProgressIndicator()))
                : _buildBlogTab(context)),
        ],
      );
    });
  }

  Widget _buildStockTab(BuildContext context) {
    return Obx(() {
      final books = controller.homeProducts.value?.data.data.books ?? [];
      final courses = controller.homeProducts.value?.data.data.courses ?? [];

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (books.isEmpty && courses.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.noData,
                height: 100,
                width: 100,
              ),
              padVertical(10),
              Label(
                txt: "Nothing found on this request",
                type: TextTypes.f_13_500,
              ),
            ],
          ),
        );
      }

      return Column(
        children: [
          if (books.isNotEmpty) ...[
            _buildSectionHeader(context, 'Books'),
            padVertical(15),
            _buildBooksRow(books),
            padVertical(15),
          ],
          if (courses.isNotEmpty) ...[
            _buildSectionHeader(context, 'Courselect'),
            padVertical(15),
            _buildCoursesRow(courses),
            padVertical(15),
          ],
        ],
      );
    });
  }

  Widget _buildCollectionsTab(BuildContext context) {
    return Obx(() {
      final mindBlowing =
          controller.collectiondata.value?.data?.data?.mindBlowing ?? [];
      final newCollections =
          controller.collectiondata.value?.data?.data?.newCollections ?? [];
      final popularCollections =
          controller.collectiondata.value?.data?.data?.popularCollections ?? [];

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (mindBlowing.isEmpty &&
          newCollections.isEmpty &&
          popularCollections.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.noData,
                height: 100,
                width: 100,
              ),
              padVertical(10),
              Label(
                txt: "Nothing found on this request",
                type: TextTypes.f_13_500,
              ),
            ],
          ),
        );
      }

      return Column(
        children: [
          if (mindBlowing.isNotEmpty) ...[
            _buildSectionHeader(
              context,
              controller.getBookTitle(
                  language: controller.language.value,
                  name: mindBlowing[0].name),
              id: mindBlowing[0].sId,
            ),
            padVertical(15),
            _builCollectioinRow(mindBlowing.first.booksId ?? []),
            padVertical(15),
          ],
          if (newCollections.isNotEmpty) ...[
            _buildSectionHeader(
              context,
              controller.getBookTitle(
                  language: controller.language.value,
                  name: newCollections[0].name),
              id: newCollections[0].sId,
            ),
            padVertical(15),
            _builCollectioinRow(newCollections.first.booksId ?? []),
            padVertical(15),
          ],
          if (popularCollections.isNotEmpty) ...[
            _buildSectionHeader(
              context,
              controller.getBookTitle(
                  language: controller.language.value,
                  name: popularCollections[0].name),
              id: popularCollections[0].sId,
            ),
            padVertical(15),
            _builCollectioinRow(popularCollections.first.booksId ?? []),
            padVertical(15),
          ],
        ],
      );
    });
  }

  Widget _buildBlogTab(BuildContext context) {
    return Obx(() {
      final articles =
          controller.blogcollectiondata.value?.data?.data?.blogs ?? [];

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (articles.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.noData,
                height: 100,
                width: 100,
              ),
              padVertical(10),
              Label(
                txt: "Nothing found on this request",
                type: TextTypes.f_13_500,
              ),
            ],
          ),
        );
      }

      return Column(
        children: [
          _buildSectionHeader(context, 'Blogs'),
          padVertical(15),
          _buildArticlesRow(articles),
          padVertical(15),
        ],
      );
    });
  }

  Widget _buildSectionHeader(BuildContext context, String titleKey,
      {String emoji = '', String? id}) {
    String title = emoji.isEmpty
        ? AppLocalization.of(context).translate(titleKey)
        : '$emoji${AppLocalization.of(context).translate(titleKey)}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Label(txt: title, type: TextTypes.f_20_500),
        GestureDetector(
            onTap: () {
              final searchController = Get.put(TabSearchController());
              if (title == AppLocalization.of(context).translate("Books")) {
                searchController.selectedIndex.value = 0;
                Get.toNamed("/searchscreen");
              } else if (title ==
                  AppLocalization.of(context).translate("Courselect")) {
                searchController.selectedIndex.value = 3;
                Get.toNamed("/searchscreen");
              } else if (title ==
                      controller.getBookTitle(
                          language: controller.language.value,
                          name: controller.collectiondata.value?.data?.data
                              ?.mindBlowing?[0].name) ||
                  title ==
                      controller.getBookTitle(
                          language: controller.language.value,
                          name: controller.collectiondata.value?.data?.data
                              ?.newCollections?[0].name) ||
                  title ==
                      controller.getBookTitle(
                          language: controller.language.value,
                          name: controller.collectiondata.value?.data?.data
                              ?.popularCollections?[0].name)) {
                Get.toNamed("/allcollections",
                    arguments: {"title": title, "id": id});
              }
            },
            child: title.isNotEmpty
                ? const Icon(Icons.arrow_forward_ios_rounded, size: 18)
                : const SizedBox.shrink())
      ],
    );
  }

  Widget _builCollectioinRow(List<dynamic> books) {
    return SizedBox(
      height: Get.height * 0.3,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () => Get.toNamed(
              "/book-detail",
              arguments: {"id": book?.sId},
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: book.image != null
                        ? Image.network(
                            "${AppConfig.imgBaseUrl}${book.image}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(AppAssets.book,
                                    fit: BoxFit.contain),
                          )
                        : Image.asset(AppAssets.book, fit: BoxFit.contain),
                  ),
                ),
                Label(
                  txt: controller.getBookTitle(
                      language: controller.language.value, name: book.name),
                  maxWidth: 144,
                  type: TextTypes.f_13_500,
                ).marginOnly(top: 10),
                SizedBox(
                  width: 144,
                  child: Label(
                    txt: controller.getBookTitle(
                        language: controller.language.value,
                        name: book.authorId?[0]?.name ?? ''),
                    type: TextTypes.f_13_400,
                    forceColor: AppColors.resnd,
                  ),
                ),
                Label(
                  txt: controller.getBookTitle(
                      language: controller.language.value,
                      name: book.categoryId?[0]?.name ?? ''),
                  maxWidth: 144,
                  type: TextTypes.f_12_400,
                  forceColor: AppColors.resnd,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBooksRow(List<BookModel> books) {
    return SizedBox(
      height: 230,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed('/book-detail', arguments: {"id": book.sId});
            },
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
                    borderRadius: BorderRadius.circular(16),
                    child: book.image != null
                        ? Image.network(
                            "${AppConfig.imgBaseUrl}${book.image}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(AppAssets.book,
                                    fit: BoxFit.contain),
                          )
                        : Image.asset(AppAssets.book, fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(height: 5),
                Label(
                  txt: controller.getBookTitle(
                    language: controller.language.value,
                    name: book.name,
                  ),
                  maxWidth: 144,
                  type: TextTypes.f_13_500,
                ),
                SizedBox(
                  width: 144,
                  child: Label(
                    txt: controller.getBookTitle(
                      language: controller.language.value,
                      name: book.authors?[0]?.name ?? '',
                    ),
                    type: TextTypes.f_13_400,
                    forceColor: AppColors.resnd,
                  ),
                ),
                Label(
                  txt: controller.getBookTitle(
                    language: controller.language.value,
                    name: book.categoryId?[0]?.name ?? '',
                  ),
                  maxWidth: 144,
                  type: TextTypes.f_12_400,
                  forceColor: AppColors.resnd,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCoursesRow(List<CourseModel> courses) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                Get.toNamed('/Course-detail', arguments: {"id": course.sId});
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 144,
                    width: 246,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: course.image != null
                            ? Image.network(
                                "${AppConfig.imgBaseUrl}${course.image}",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(AppAssets.book,
                                        fit: BoxFit.cover),
                              )
                            : Image.asset(AppAssets.book, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  padVertical(5),
                  Label(
                    txt: controller.getBookTitle(
                        language: controller.language.value, name: course.name),
                    type: TextTypes.f_13_500,
                  ),
                  SizedBox(
                    width: 240,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: AppColors.primaryColor,
                            ),
                            Label(
                                txt: course.averageRating?.toString() ?? '0',
                                type: TextTypes.f_11_500),
                            padHorizontal(8),
                            Container(
                              height: 12,
                              width: 1,
                              decoration: BoxDecoration(
                                color: AppColors.buttongroupBorder,
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            padHorizontal(8),
                            SizedBox(
                              width: 120,
                              child: Label(
                                txt: controller.getBookTitle(
                                    language: controller.language.value,
                                    name: course.authorId?[0]?.name ?? ''),
                                type: TextTypes.f_13_400,
                                forceColor: AppColors.resnd,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            if (course.isDiscounted == true)
                              Text(
                                course.price?.toString() ?? '',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: AppConst.fontFamily,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 2,
                                  decorationColor: AppColors.blackColor,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            const SizedBox(width: 10),
                            if (course.isDiscounted == true)
                              Text(
                                "${(((course.price ?? 0) - ((course.price ?? 0) * (course.discountPercentage ?? 0) / 100)).toStringAsFixed(0))}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppConst.fontFamily,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildArticlesRow(List<dynamic>? articles) {
    if (articles == null || articles.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 144,
                  width: 246,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: article.image != null
                          ? Image.network(
                              "${AppConfig.imgBaseUrl}${article.image}",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(AppAssets.book,
                                      fit: BoxFit.contain),
                            )
                          : Image.asset(AppAssets.book, fit: BoxFit.contain),
                    ),
                  ),
                ),
                padVertical(5),
                Label(
                    txt: controller.getBookTitle(
                        language: controller.language.value,
                        name: article.name),
                    type: TextTypes.f_13_500),
              ],
            ),
          );
        },
      ),
    );
  }
}
