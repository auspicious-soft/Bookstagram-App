import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app_settings/constants/app_assets.dart';
import '../controller/searchcontroller.dart';
import '../models/homeProductModel.dart';

class PgTabsearch extends GetView<TabSearchController> {
  const PgTabsearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: WidgetGlobalMargin(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Label(
                  txt: AppLocalization.of(context).translate('Search'),
                  type: TextTypes.f_20_500,
                ),
              ),
              padVertical(10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.border2,
                    width: 2,
                  ),
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
                        onChanged: (val) => controller.onSearchChanged(val),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              AppLocalization.of(context).translate('search'),
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
                      ),
                    ),
                  ],
                ),
              ),
              padVertical(20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;
                  final tabWidth = screenWidth / 3.8;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() => SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(4, (index) {
                                final tabTitles = [
                                  'Books',
                                  'Audiobooks',
                                  'Authors',
                                  'Courses'
                                ];
                                return GestureDetector(
                                  onTap: () =>
                                      controller.selectedIndex.value = index,
                                  child: Container(
                                    width: tabWidth,
                                    padding: const EdgeInsets.only(bottom: 10),
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalization.of(context)
                                          .translate(tabTitles[index]),
                                      style: TextStyle(
                                        fontFamily: AppConst.fontFamily,
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w500,
                                        color: controller.selectedIndex.value ==
                                                index
                                            ? AppColors.primaryColor
                                            : AppColors.blackColor,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          )),
                      Obx(() => Stack(
                            children: [
                              Container(
                                width: screenWidth,
                                height: 2,
                                color: Colors.grey.shade300,
                              ),
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 300),
                                left: controller.selectedIndex.value * tabWidth,
                                width: tabWidth,
                                height: 2,
                                child: Container(color: AppColors.primaryColor),
                              ),
                            ],
                          )),
                    ],
                  );
                },
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.fetchBooks();
                  },
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // Determine which tab is active and display appropriate content
                    switch (controller.selectedIndex.value) {
                      case 0: // Books
                      case 1: // Audiobooks
                        return _buildStockTab(context);
                      case 2: // Authors
                        return _buildAuthrTab(context);
                      case 3: // Courses
                        return _buildStockTab(context);
                      default:
                        return const Center(
                            child: Text("Invalid tab selected"));
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStockTab(BuildContext context) {
    final books = controller.bookList.value?.data ?? [];

    if (books.isEmpty) {
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

    return controller.selectedIndex.value == 0 ||
            controller.selectedIndex.value == 1
        ? _buildBooksGrid(books)
        : _buildCoursesRow(books);
  }

  Widget _buildAuthrTab(BuildContext context) {
    final authors = controller.authorList.value?.data?.authors ?? [];

    if (authors.isEmpty) {
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

    return _buildAuthorGrid(authors);
  }

  Widget _buildAuthorGrid(List authors) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: authors.length,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: authors[index].image != null
                        ? Image.network(
                            "${AppConfig.imgBaseUrl}${authors[index].image}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(AppAssets.book,
                                    fit: BoxFit.contain),
                          )
                        : Image.asset(AppAssets.book, fit: BoxFit.contain),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Label(
                  txt: controller.getBookTitle(name: authors[index].name),
                  type: TextTypes.f_13_500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCoursesRow(List courses) {
    return SizedBox(
      height: Get.height * 0.8,
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: courses.length,
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final course = courses[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed('/Course-detail',
                  arguments: {"id": courses[index].sId});
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 160,
                  width: Get.width,
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
                                      fit: BoxFit.contain),
                            )
                          : Image.asset(AppAssets.book, fit: BoxFit.contain),
                    ),
                  ),
                ),
                padVertical(5),
                Label(
                  txt: controller.getBookTitle(name: course.name),
                  maxWidth: 144,
                  type: TextTypes.f_13_500,
                ),
                SizedBox(
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
                            txt: course.averageRating.toString(),
                            type: TextTypes.f_11_500,
                          ),
                          padHorizontal(4),
                          Container(
                            height: 12,
                            width: 1,
                            decoration: BoxDecoration(
                              color: AppColors.buttongroupBorder,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          padHorizontal(5),
                          Label(
                            txt: controller.getBookTitle(
                                name: course.authors![0].name),
                            type: TextTypes.f_13_400,
                            forceColor: AppColors.resnd,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (course.isDiscounted == true)
                            Text(
                              course.price.toString(),
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
                          Text(
                            course.isDiscounted == true
                                ? (course.price *
                                        (1 - (course.discountPercentage / 100)))
                                    .toStringAsFixed(2)
                                : course.price.toStringAsFixed(2),
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
            ).marginSymmetric(vertical: 20),
          );
        },
      ),
    );
  }

  Widget _buildBooksGrid(List books) {
    return SizedBox(
      height: Get.height * 0.8,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        itemCount: books.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 95,
                      width: 95,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Label(
                          txt: controller.getBookTitle(name: book.name),
                          maxWidth: 140,
                          type: TextTypes.f_13_500,
                        ),
                        SizedBox(
                          width: 144,
                          child: Label(
                            txt: controller.getBookTitle(
                                name: book.authors![0].name),
                            type: TextTypes.f_13_400,
                            forceColor: AppColors.resnd,
                          ),
                        ),
                        Label(
                          txt: controller.getBookTitle(
                              name: book.categoryId![0].name),
                          maxWidth: 144,
                          type: TextTypes.f_12_400,
                          forceColor: AppColors.resnd,
                        ),
                      ],
                    ).marginSymmetric(horizontal: 10, vertical: 10),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: AppColors.blackColor,
                        ),
                        const SizedBox(width: 4),
                        Label(
                          txt: book.averageRating.toString(),
                          type: TextTypes.f_11_500,
                        ),
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
                        Label(
                          txt: controller.getBookTitle(
                              name: book.publisherId.name),
                          type: TextTypes.f_13_400,
                          forceColor: AppColors.resnd,
                        ),
                      ],
                    ),
                    Image.asset(
                      "assets/icons/heart.png",
                      height: 20,
                      width: 20,
                    ),
                  ],
                ).marginOnly(top: 20),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),
        ),
      ),
    );
  }
}
