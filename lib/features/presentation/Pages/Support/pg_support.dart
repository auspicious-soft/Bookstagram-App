// import 'package:bookstagram/app_settings/components/label.dart';
// import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
// import 'package:bookstagram/app_settings/constants/app_assets.dart';
// import 'package:bookstagram/app_settings/constants/app_colors.dart';
// import 'package:bookstagram/app_settings/constants/app_const.dart';
// import 'package:bookstagram/app_settings/constants/app_dim.dart';
// import 'package:bookstagram/features/presentation/Pages/Support/Widgets/social_list_widget.dart';
// import 'package:bookstagram/localization/app_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class PgSupport extends StatefulWidget {
//   final int? initialTabIndex; // Argument to set initial tab
//
//   const PgSupport({super.key, this.initialTabIndex});
//
//   @override
//   State<PgSupport> createState() => _PgSupportState();
// }
//
// class _PgSupportState extends State<PgSupport> {
//   int selectedIndex = 0;
//   bool listView = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Set selectedIndex based on argument, default to 0 if null
//     selectedIndex = widget.initialTabIndex ?? 0;
//
//     // Ensure selectedIndex is valid (0 or 1 since you have two tabs)
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(Icons.arrow_back),
//                   ),
//                   Label(
//                     txt: AppLocalization.of(context).translate('support'),
//                     type: TextTypes.f_20_500,
//                   ),
//                   const Label(txt: "   ", type: TextTypes.f_20_500),
//                 ],
//               ),
//               padVertical(20),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   LayoutBuilder(
//                     builder: (context, constraints) {
//                       final screenWidth = constraints.maxWidth;
//                       final tabWidth = screenWidth / 2;
//                       return Column(
//                         children: [
//                           SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                               children: [
//                                 for (int index = 0; index < 2; index++)
//                                   GestureDetector(
//                                     onTap: () =>
//                                         setState(() => selectedIndex = index),
//                                     child: Container(
//                                       width: tabWidth,
//                                       padding:
//                                           const EdgeInsets.only(bottom: 10),
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         AppLocalization.of(context).translate(
//                                           [
//                                             AppLocalization.of(context)
//                                                 .translate('faq'),
//                                             AppLocalization.of(context)
//                                                 .translate('contacts'),
//                                           ][index],
//                                         ),
//                                         style: TextStyle(
//                                           fontFamily: AppConst.fontFamily,
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.w500,
//                                           color: selectedIndex == index
//                                               ? AppColors.primaryColor
//                                               : AppColors.blackColor,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                           Stack(
//                             children: [
//                               Container(
//                                 width: screenWidth,
//                                 height: 4,
//                                 color: Colors.grey.shade300,
//                               ),
//                               AnimatedPositioned(
//                                 duration: const Duration(milliseconds: 300),
//                                 left: selectedIndex * tabWidth,
//                                 width: tabWidth,
//                                 height: 4,
//                                 child: Container(color: AppColors.primaryColor),
//                               ),
//                             ],
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               padVertical(20),
//               selectedIndex == 0
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(children: [
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 15, vertical: 5),
//                               decoration: BoxDecoration(
//                                 color: AppColors.primaryColor,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: const Label(
//                                 txt: "General questions",
//                                 type: TextTypes.f_15_400,
//                                 forceColor: AppColors.whiteColor,
//                               ),
//                             ),
//                             padHorizontal(5),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 15, vertical: 5),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                     width: 1, color: AppColors.primaryColor),
//                               ),
//                               child: const Label(
//                                 txt: "Books",
//                                 type: TextTypes.f_15_400,
//                                 forceColor: AppColors.primaryColor,
//                               ),
//                             ),
//                             padHorizontal(5),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 15, vertical: 5),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                     width: 1, color: AppColors.primaryColor),
//                               ),
//                               child: const Label(
//                                 txt: "School library",
//                                 type: TextTypes.f_15_400,
//                                 forceColor: AppColors.primaryColor,
//                               ),
//                             ),
//                           ]),
//                         ),
//                         padVertical(20),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: AppColors.border,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Row(
//                             children: [
//                               Image.asset(
//                                 height: 20,
//                                 width: 20,
//                                 AppAssets.search,
//                                 fit: BoxFit.contain,
//                               ),
//                               padHorizontal(10),
//                               Expanded(
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: AppLocalization.of(context)
//                                         .translate('search'),
//                                     hintStyle: const TextStyle(
//                                       color: AppColors.inputBorder,
//                                       fontFamily: AppConst.fontFamily,
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                   style: const TextStyle(
//                                     color: AppColors.blackColor,
//                                     fontFamily: AppConst.fontFamily,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   keyboardType: TextInputType.text,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         padVertical(20),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Column(children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     listView = !listView;
//                                   });
//                                 },
//                                 child: Container(
//                                   width: double.infinity,
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 20, horizontal: 10),
//                                   decoration: BoxDecoration(
//                                     color: AppColors.border,
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: const Radius.circular(8),
//                                       topRight: const Radius.circular(8),
//                                       bottomLeft:
//                                           Radius.circular(listView ? 0 : 8),
//                                       bottomRight:
//                                           Radius.circular(listView ? 0 : 8),
//                                     ),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                         color: Colors.black12,
//                                         blurRadius: 3,
//                                         offset: Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           const Label(
//                                             txt: "What is Bookstagram?",
//                                             type: TextTypes.f_17_500,
//                                           ),
//                                           Icon(
//                                             listView
//                                                 ? Icons.arrow_drop_up_outlined
//                                                 : Icons
//                                                     .arrow_drop_down_outlined,
//                                             size: 30,
//                                             color: AppColors.primaryColor,
//                                           ),
//                                         ],
//                                       ),
//                                       if (listView) const Divider(),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               if (listView)
//                                 Container(
//                                   width: double.infinity,
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 10, vertical: 15),
//                                   decoration: const BoxDecoration(
//                                     color: AppColors.border,
//                                     borderRadius: BorderRadius.only(
//                                       bottomLeft: Radius.circular(8),
//                                       bottomRight: Radius.circular(8),
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black12,
//                                         blurRadius: 3,
//                                         offset: Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: const Label(
//                                     txt:
//                                         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
//                                     type: TextTypes.f_15_400,
//                                   ),
//                                 ),
//                             ]),
//                           ],
//                         ),
//                       ],
//                     )
//                   : Column(
//                       children: [
//                         buildContactItem(
//                             Icons.camera_alt,
//                             "Instagram",
//                             "https://instagram.com/bookstagram.online",
//                             context),
//                         buildContactItem(Icons.facebook, "Facebook",
//                             "https://facebook.com/bookstagram.kz", context),
//                         buildContactItem(Icons.telegram, "Telegram",
//                             "https://t.me/bookstagram_kz", context),
//                         buildContactItem(Icons.mail, "Mail",
//                             "mailto:info@bookstagram.kz", context),
//                         buildContactItem(Icons.music_note, "TikTok",
//                             "https://tiktok.com/@bookstagram.kz", context),
//                         buildContactItem(Icons.call, "WhatsApp",
//                             "https://wa.me/77758133887", context),
//                         buildContactItem(Icons.public, "Website",
//                             "https://bookstagram.kz", context),
//                         buildContactItem(Icons.help, "FAQ",
//                             "https://bookstagram.kz/faq", context),
//                       ],
//                     ),
//             ],
//           ).marginSymmetric(
//             horizontal: 20,
//           ),
//         ),
//       ),
//     );
//   }
// }
