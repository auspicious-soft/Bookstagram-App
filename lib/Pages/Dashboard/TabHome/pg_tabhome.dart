import 'package:bookstagram/Pages/BookMarket/pg_bookmarket.dart';
import 'package:bookstagram/Pages/BookView/pg_book_view.dart';
import 'package:bookstagram/Pages/StoryScreen/pg_storyscreen.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PgTabhome extends StatefulWidget {
  const PgTabhome({super.key});

  @override
  State<PgTabhome> createState() => _PgTabhomeState();
}

class _PgTabhomeState extends State<PgTabhome> {
  int selectedIndex = 0;
  final List<Map<String, String>> banners = [
    {
      "image": AppAssets.banner,
      "title": "Tennis",
    },
    {
      "image": AppAssets.banner,
      "title": "Badminton",
    },
    {
      "image": AppAssets.banner,
      "title": "Swimming",
    },
  ];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
            child: WidgetGlobalMargin(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                      const Icon(Icons.notifications_none_outlined)
                    ]),
                padVertical(15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PgStoryscreen(),
                                ),
                              );
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: const LinearGradient(
                                  colors: [Colors.blue, Colors.purple],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    3.0), // Gradient border width
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.white, // Inner background color
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      AppAssets.congrat,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      );
                    }),
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
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      padHorizontal(10),
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          height: 20,
                          width: 20,
                          AppAssets.filter,
                          fit: BoxFit.contain,
                        ),
                      ),
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
                              builder: (context) => const PgBookmarket(),
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                    Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                            ])),
                    Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                            ])),
                    Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                            ])),
                  ],
                ),
                padVertical(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 75,
                        width: 78,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                height: 35,
                                width: 35,
                                AppAssets.uni,
                                fit: BoxFit.contain,
                              ),
                              Label(
                                  txt: AppLocalization.of(context)
                                      .translate('Bookuniversity'),
                                  type: TextTypes.f_12_400)
                            ])),
                    Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                            ])),
                    Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                            ])),
                    Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                            ])),
                  ],
                ),
                padVertical(20),
                CarouselSlider.builder(
                  itemCount: banners.length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(banners[index]["image"]!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 150,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                  ),
                ),
                padVertical(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          // First Tab
                          GestureDetector(
                            onTap: () => setState(() => selectedIndex = 0),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, left: 16, right: 16),
                              alignment: Alignment.center,
                              child: Text(
                                '🔥${AppLocalization.of(context).translate('Stock')}',
                                style: TextStyle(
                                  fontFamily: AppConst.fontFamily,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: selectedIndex == 0
                                      ? AppColors.primaryColor
                                      : AppColors.blackColor,
                                ),
                              ),
                            ),
                          ),
                          // Second Tab
                          GestureDetector(
                            onTap: () => setState(() => selectedIndex = 1),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, left: 16, right: 16),
                              alignment: Alignment.center,
                              child: Text(
                                '📚${AppLocalization.of(context).translate('Collections')}',
                                style: TextStyle(
                                  fontFamily: AppConst.fontFamily,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: selectedIndex == 1
                                      ? AppColors.primaryColor
                                      : AppColors.blackColor,
                                ),
                              ),
                            ),
                          ),
                          // Third Tab
                          GestureDetector(
                            onTap: () => setState(() => selectedIndex = 2),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, left: 16, right: 16),
                              alignment: Alignment.center,
                              child: Text(
                                '💡${AppLocalization.of(context).translate('Blog')}',
                                style: TextStyle(
                                  fontFamily: AppConst.fontFamily,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: selectedIndex == 2
                                      ? AppColors.primaryColor
                                      : AppColors.blackColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Bottom Border line
                    Stack(
                      children: [
                        Container(
                          width: screenWidth,
                          height: 2,
                          color: Colors.grey.shade300,
                        ),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          left: selectedIndex * (screenWidth / 3),
                          width: screenWidth / 3,
                          height: 2,
                          child: Container(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
                padVertical(15),
                if (selectedIndex == 0)
                  Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Label(
                            txt: AppLocalization.of(context).translate('Books'),
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
                            padding: const EdgeInsets.only(right: 12.0),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PgBookView(),
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
                                    ])),
                          );
                        }),
                      ),
                    ),
                    padVertical(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: AppColors.primaryColor,
                                                ),
                                                const Label(
                                                    txt: "5.0",
                                                    type: TextTypes.f_11_500),
                                                padHorizontal(8),
                                                Container(
                                                  height: 12,
                                                  width: 1,
                                                  decoration: BoxDecoration(
                                                    color: AppColors
                                                        .buttongroupBorder,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                ),
                                                padHorizontal(8),
                                                const Label(
                                                    txt: "Designe",
                                                    type: TextTypes.f_11_500),
                                              ],
                                            ),
                                            Row(children: [
                                              const Text(
                                                "1670₸",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppConst.fontFamily,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationThickness: 2,
                                                  decorationColor:
                                                      AppColors.blackColor,
                                                  color: AppColors.blackColor,
                                                ),
                                              ),
                                              padHorizontal(8),
                                              const Label(
                                                  txt: "990₸",
                                                  forceColor:
                                                      AppColors.primaryColor,
                                                  type: TextTypes.f_11_500),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 144,
                                    width: 144,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 144,
                                    width: 144,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 144,
                                    width: 144,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Label(
                            txt: AppLocalization.of(context).translate('News'),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Label(
                            txt: AppLocalization.of(context).translate('blog2'),
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
            ]))));
  }
}
