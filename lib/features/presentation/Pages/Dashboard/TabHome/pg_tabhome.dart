import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/loader.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/app_settings/constants/helpers.dart';
import 'package:bookstagram/features/data/models/homedata_model.dart';
import 'package:bookstagram/features/presentation/Pages/BookEvents/pg_book_event.dart';
import 'package:bookstagram/features/presentation/Pages/BookLife/pg_book_life.dart';
import 'package:bookstagram/features/presentation/Pages/BookMarket/pg_bookmarket.dart';
import 'package:bookstagram/features/presentation/Pages/BookMaster/pg_book_master.dart';
import 'package:bookstagram/features/presentation/Pages/BookRooomScreens/BookRoom/pg_book_room.dart';
import 'package:bookstagram/features/presentation/Pages/BookSchool/pg_Book_school.dart';
import 'package:bookstagram/features/presentation/Pages/BookStudy/pg_bookstudy.dart';
import 'package:bookstagram/features/presentation/Pages/BookUniversity/pg_book_uni.dart';
import 'package:bookstagram/features/presentation/Pages/BookView/pg_book_view.dart';
import 'package:bookstagram/features/presentation/Pages/Notification/pg_notification.dart';
import 'package:bookstagram/features/presentation/Pages/StoryScreen/pg_storyscreen.dart';
import 'package:bookstagram/features/presentation/providers/home_data_provider.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PgTabhome extends ConsumerStatefulWidget {
  const PgTabhome({super.key});

  @override
  PgTabhomeState createState() => PgTabhomeState();
}

class PgTabhomeState extends ConsumerState<PgTabhome> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(stateHomeDataNotfierProvider.notifier)
          .getHomeData(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;
    var asyncWatcher = ref.watch(stateHomeDataNotfierProvider);

    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
            child: WidgetGlobalMargin(
                child: Stack(children: [
          asyncWatcher.when(
            data: (findata) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                          padVertical(20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Label(
                                      txt:
                                          "${AppLocalization.of(context).translate('hello')},",
                                      type: TextTypes.f_20_700),
                                  const Label(
                                    txt: "Duman!",
                                    type: TextTypes.f_20_500i,
                                    forceColor: AppColors.primaryColor,
                                  )
                                ]),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PgNotification(),
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                        Icons.notifications_none_outlined))
                              ]),
                          padVertical(15),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .start, // Ensure alignment starts from left
                              children: List.generate(
                                findata?.data?.stories?.length ?? 0,
                                (index) {
                                  final Story? story =
                                      findata?.data?.stories?[index];
                                  if (story == null ||
                                      story.file == null ||
                                      story.file!.isEmpty) {
                                    return const SizedBox(); // Skip empty stories
                                  }
                                  String? firstImageKey =
                                      story.file!.keys.first;
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        final Story selectedStory =
                                            findata!.data!.stories![index];

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PgStoryscreen(
                                                story: selectedStory),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Colors.blue,
                                              Colors.purple
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              3.0), // Gradient border width
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              // ignore: unnecessary_null_comparison
                                              child: firstImageKey != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.network(
                                                        "${AppConfig.imgBaseUrl}$firstImageKey",
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        height: double.infinity,
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
                          ),
                          padVertical(30),
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
                                padHorizontal(10),
                              ],
                            ),
                          ),
                          padVertical(25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PgBookmarket(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              height: 35,
                                              width: 35,
                                              AppAssets.bookmarket,
                                              fit: BoxFit.contain,
                                            ),
                                            Label(
                                                txt: AppLocalization.of(context)
                                                    .translate('Bookmarket'),
                                                type: TextTypes.f_12_400)
                                          ]))),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PgBookRoom(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              height: 25,
                                              width: 25,
                                              AppAssets.room,
                                              fit: BoxFit.contain,
                                            ),
                                            padVertical(6),
                                            Label(
                                                txt: AppLocalization.of(context)
                                                    .translate('Bookroom'),
                                                type: TextTypes.f_12_400)
                                          ]))),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PgBookSchool(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              height: 30,
                                              width: 30,
                                              AppAssets.school,
                                              fit: BoxFit.contain,
                                            ),
                                            padVertical(5),
                                            Label(
                                                txt: AppLocalization.of(context)
                                                    .translate('Bookschool'),
                                                type: TextTypes.f_12_400)
                                          ]))),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PgBookstudy(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              height: 35,
                                              width: 40,
                                              AppAssets.study,
                                              fit: BoxFit.contain,
                                            ),
                                            Label(
                                                txt: AppLocalization.of(context)
                                                    .translate('Bookstudy'),
                                                type: TextTypes.f_12_400)
                                          ]))),
                            ],
                          ),
                          padVertical(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const PgBookUni(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      height: 75,
                                      width: 78,
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              height: 35,
                                              width: 35,
                                              AppAssets.uni,
                                              fit: BoxFit.contain,
                                            ),
                                            Label(
                                                txt: AppLocalization.of(context)
                                                    .translate(
                                                        'Bookuniversity'),
                                                type: TextTypes.f_12_400)
                                          ]))),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PgBookMaster(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            padVertical(7),
                                            Image.asset(
                                              height: 28,
                                              width: 28,
                                              AppAssets.master,
                                              fit: BoxFit.contain,
                                            ),
                                            padVertical(4),
                                            Label(
                                                txt: AppLocalization.of(context)
                                                    .translate('Bookmasters'),
                                                type: TextTypes.f_12_400)
                                          ]))),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PgBookEvent(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              height: 30,
                                              width: 30,
                                              AppAssets.event,
                                              fit: BoxFit.contain,
                                            ),
                                            padVertical(5),
                                            Label(
                                                txt: AppLocalization.of(context)
                                                    .translate('Bookrvents'),
                                                type: TextTypes.f_12_400)
                                          ]))),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PgBookLife(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            padVertical(5),
                                            Image.asset(
                                              height: 28,
                                              width: 28,
                                              AppAssets.booklife,
                                              fit: BoxFit.contain,
                                            ),
                                            padVertical(5),
                                            Label(
                                                txt: AppLocalization.of(context)
                                                    .translate('Booklife'),
                                                type: TextTypes.f_12_400)
                                          ]))),
                            ],
                          ),
                          padVertical(20),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              color: AppColors.border,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Center(
                                    child: Image.asset(
                                      width: 113,
                                      height: 144,
                                      AppAssets.book,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                padHorizontal(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Label(
                                        txt: "Алашқа",
                                        type: TextTypes.f_15_500),
                                    const Label(
                                      txt: "Міржақып Дулатұлы",
                                      type: TextTypes.f_15_400,
                                      forceColor: AppColors.resnd,
                                    ),
                                    const Label(
                                      txt: "Audio",
                                      type: TextTypes.f_13_400,
                                      forceColor: AppColors.resnd,
                                    ),
                                    padVertical(5),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width:
                                              ScreenUtils.screenWidth(context) /
                                                  2.5,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child:
                                                const LinearProgressIndicator(
                                              value: 0.73,
                                              backgroundColor:
                                                  AppColors.inputBorder,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      AppColors.primaryColor),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Label(
                                          txt: "73%",
                                          type: TextTypes.f_12_400,
                                        ),
                                      ],
                                    ),
                                    padVertical(2),
                                    SizedBox(
                                        height: 38,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0.0,
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Label(
                                            txt: AppLocalization.of(context)
                                                .translate('continue'),
                                            type: TextTypes.f_13_400,
                                            forceColor: AppColors.whiteColor,
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                          padVertical(20),
                          CarouselSlider.builder(
                            itemCount: findata?.data?.banners?.length ?? 0,
                            itemBuilder: (context, index, realIndex) {
                              final banner = findata?.data?.banners?[index];

                              if (banner == null ||
                                  banner.image == null ||
                                  banner.image!.isEmpty) {
                                return Container(
                                  width: double.infinity,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors
                                        .black, // Placeholder in case of missing image
                                  ),
                                  child: const Center(
                                      child: Label(
                                    txt: "No Image",
                                    type: TextTypes.f_13_600,
                                  )),
                                );
                              }
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "${AppConfig.imgBaseUrl}${banner.image}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              height: 150,
                              autoPlay: true,
                              enlargeCenterPage: true,
                            ),
                          ),
                          padVertical(20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final screenWidth = constraints.maxWidth;
                                  final tabWidth = screenWidth / 2.8;
                                  return Column(
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            for (int index = 0;
                                                index < 3;
                                                index++)
                                              GestureDetector(
                                                onTap: () => setState(() =>
                                                    selectedIndex = index),
                                                child: Container(
                                                  // width: languageCode == 'en'
                                                  //     ? screenWidth / 3
                                                  //     : screenWidth,
                                                  padding: EdgeInsets.only(
                                                      bottom: 10,
                                                      left: languageCode == 'en'
                                                          ? 20
                                                          : 0,
                                                      right: 20),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    AppLocalization.of(context)
                                                        .translate(
                                                      [
                                                        '🔥${AppLocalization.of(context).translate('Stock')}',
                                                        '📚${AppLocalization.of(context).translate('Collections')}',
                                                        '💡${AppLocalization.of(context).translate('Blog')}',
                                                      ][index],
                                                    ),
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppConst.fontFamily,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          selectedIndex == index
                                                              ? AppColors
                                                                  .primaryColor
                                                              : AppColors
                                                                  .blackColor,
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
                                          AnimatedPositioned(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            left: selectedIndex * tabWidth,
                                            width: tabWidth,
                                            height: 2,
                                            child: Container(
                                                color: AppColors.primaryColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                          padVertical(15),
                          if (selectedIndex == 0)
                            Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Label(
                                      txt: AppLocalization.of(context)
                                          .translate('Books'),
                                      type: TextTypes.f_20_500),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 18,
                                  )
                                ],
                              ),
                              padVertical(15),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(6, (index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const PgBookView(),
                                              ),
                                            );
                                          },
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 144,
                                                  width: 144,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    child: Center(
                                                      child: Image.asset(
                                                        AppAssets.book,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                padVertical(5),
                                                const Label(
                                                    txt: "Көксерек",
                                                    type: TextTypes.f_13_500),
                                                const Label(
                                                  txt: "Мұхтар Әуезов",
                                                  type: TextTypes.f_13_400,
                                                  forceColor: AppColors.resnd,
                                                ),
                                                const Label(
                                                  txt: "Поэзия",
                                                  type: TextTypes.f_12_400,
                                                  forceColor: AppColors.resnd,
                                                )
                                              ])),
                                    );
                                  }),
                                ),
                              ),
                              padVertical(15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Label(
                                      txt: AppLocalization.of(context)
                                          .translate('Courselect'),
                                      type: TextTypes.f_20_500),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 18,
                                  )
                                ],
                              ),
                              padVertical(15),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(6, (index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 144,
                                              width: 246,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    AppAssets.book,
                                                    fit: BoxFit.fill,
                                                    height: 144,
                                                    width: 246,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            padVertical(5),
                                            const Label(
                                                txt: "Learn Figma from Scratch",
                                                type: TextTypes.f_13_500),
                                            SizedBox(
                                                width: 240,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.star,
                                                            size: 16,
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                          const Label(
                                                              txt: "5.0",
                                                              type: TextTypes
                                                                  .f_11_500),
                                                          padHorizontal(8),
                                                          Container(
                                                            height: 12,
                                                            width: 1,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .buttongroupBorder,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                            ),
                                                          ),
                                                          padHorizontal(8),
                                                          const Label(
                                                              txt: "Designe",
                                                              type: TextTypes
                                                                  .f_11_500),
                                                        ],
                                                      ),
                                                      Row(children: [
                                                        const Text(
                                                          "1670₸",
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily: AppConst
                                                                .fontFamily,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            decorationThickness:
                                                                2,
                                                            decorationColor:
                                                                AppColors
                                                                    .blackColor,
                                                            color: AppColors
                                                                .blackColor,
                                                          ),
                                                        ),
                                                        padHorizontal(8),
                                                        const Label(
                                                            txt: "990₸",
                                                            forceColor: AppColors
                                                                .primaryColor,
                                                            type: TextTypes
                                                                .f_11_500),
                                                      ])
                                                    ]))
                                          ]),
                                    );
                                  }),
                                ),
                              ),
                              padVertical(15),
                            ]),
                          if (selectedIndex == 1)
                            Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Label(
                                      txt:
                                          '${AppLocalization.of(context).translate('mindblowing')} 🤯',
                                      type: TextTypes.f_20_500),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 18,
                                  )
                                ],
                              ),
                              padVertical(15),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(6, (index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
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
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    AppAssets.book,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            padVertical(5),
                                            const Label(
                                                txt: "Көксерек",
                                                type: TextTypes.f_13_500),
                                            const Label(
                                              txt: "Мұхтар Әуезов",
                                              type: TextTypes.f_13_400,
                                              forceColor: AppColors.resnd,
                                            ),
                                            const Label(
                                              txt: "Поэзия",
                                              type: TextTypes.f_12_400,
                                              forceColor: AppColors.resnd,
                                            )
                                          ]),
                                    );
                                  }),
                                ),
                              ),
                              padVertical(15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Label(
                                      txt:
                                          '${AppLocalization.of(context).translate('newbooks')} 💌',
                                      type: TextTypes.f_20_500),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 18,
                                  )
                                ],
                              ),
                              padVertical(15),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(6, (index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
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
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    AppAssets.book,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            padVertical(5),
                                            const Label(
                                                txt: "Ақшам хаттары",
                                                type: TextTypes.f_13_500),
                                            const Label(
                                              txt: "Мұхтар Әуезов",
                                              type: TextTypes.f_13_400,
                                              forceColor: AppColors.resnd,
                                            ),
                                            const Label(
                                              txt: "Поэзия",
                                              type: TextTypes.f_12_400,
                                              forceColor: AppColors.resnd,
                                            )
                                          ]),
                                    );
                                  }),
                                ),
                              ),
                              padVertical(15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Label(
                                      txt:
                                          '${AppLocalization.of(context).translate('soulfulbooks')} 💔',
                                      type: TextTypes.f_20_500),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 18,
                                  )
                                ],
                              ),
                              padVertical(15),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(6, (index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
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
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    AppAssets.book,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            padVertical(5),
                                            const Label(
                                                txt: "Ақшам хаттары",
                                                type: TextTypes.f_13_500),
                                            const Label(
                                              txt: "Мұхтар Әуезов",
                                              type: TextTypes.f_13_400,
                                              forceColor: AppColors.resnd,
                                            ),
                                            const Label(
                                              txt: "Поэзия",
                                              type: TextTypes.f_12_400,
                                              forceColor: AppColors.resnd,
                                            )
                                          ]),
                                    );
                                  }),
                                ),
                              ),
                              padVertical(15),
                            ]),
                          if (selectedIndex == 2)
                            Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Label(
                                      txt: AppLocalization.of(context)
                                          .translate('News'),
                                      type: TextTypes.f_20_500),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 18,
                                  )
                                ],
                              ),
                              padVertical(15),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(6, (index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 144,
                                              width: 246,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    AppAssets.book,
                                                    fit: BoxFit.fill,
                                                    height: 144,
                                                    width: 246,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            padVertical(5),
                                            const Label(
                                                txt: "Article Title",
                                                type: TextTypes.f_13_500),
                                          ]),
                                    );
                                  }),
                                ),
                              ),
                              padVertical(15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Label(
                                      txt: AppLocalization.of(context)
                                          .translate('blog2'),
                                      type: TextTypes.f_20_500),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 18,
                                  )
                                ],
                              ),
                              padVertical(15),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(6, (index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 144,
                                              width: 246,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    AppAssets.book,
                                                    fit: BoxFit.fill,
                                                    height: 144,
                                                    width: 246,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            padVertical(5),
                                            const Label(
                                                txt: "Article Title",
                                                type: TextTypes.f_13_500),
                                          ]),
                                    );
                                  }),
                                ),
                              ),
                              padVertical(15),
                            ]),
                        ])))
                  ]);
            },
            loading: () => const Center(
              child: LoadingScreen(),
            ),
            error: (error, stackTrace) {
              return const Padding(
                padding: EdgeInsets.all(30.0),
                child: Center(
                    child: Text("",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white))),
              );
            },
          ),
        ]))));
  }
}
