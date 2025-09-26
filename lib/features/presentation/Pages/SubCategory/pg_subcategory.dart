// import 'package:bookstagram/app_settings/components/common_sheet.dart';
// import 'package:bookstagram/app_settings/components/label.dart';
// import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
// import 'package:bookstagram/app_settings/constants/app_assets.dart';
// import 'package:bookstagram/app_settings/constants/app_colors.dart';
//
// import 'package:bookstagram/app_settings/constants/app_dim.dart';
//
// import 'package:flutter/material.dart';
//
// class PgSubcategory extends StatefulWidget {
//   final String label;
//   const PgSubcategory({super.key, required this.label});
//
//   @override
//   State<PgSubcategory> createState() => _PgSubcategoryState();
// }
//
// class _PgSubcategoryState extends State<PgSubcategory> {
//   int selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.background,
//         body: SafeArea(
//             child: WidgetGlobalMargin(
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//               Expanded(
//                   child: SingleChildScrollView(
//                       child: Column(mainAxisSize: MainAxisSize.min, children: [
//                 padVertical(10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon:
//                           const Icon(Icons.arrow_back_ios, color: Colors.black),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                     Label(txt: widget.label, type: TextTypes.f_20_500),
//                     GestureDetector(
//                       onTap: () {
//                         showModalBottomSheet(
//                           isScrollControlled: true,
//                           context: context,
//                           backgroundColor: AppColors.whiteColor,
//                           builder: (BuildContext context) {
//                             return FilterBottomSheet();
//                           },
//                         );
//                       },
//                       child: Image.asset(
//                         width: 16,
//                         height: 20,
//                         AppAssets.categoryfil,
//                         fit: BoxFit.contain,
//                       ),
//                     )
//                   ],
//                 ),
//                 padVertical(30),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Label(
//                         txt: "📜   Тарихи тұлғалар", type: TextTypes.f_20_300),
//                     Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       size: 18,
//                     )
//                   ],
//                 ),
//                 padVertical(20),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Label(
//                         txt: "🌟   Заманауи тұлғалар",
//                         type: TextTypes.f_20_300),
//                     Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       size: 18,
//                     )
//                   ],
//                 ),
//                 padVertical(30),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Label(
//                         txt: "✍️   Автобиографиялар", type: TextTypes.f_20_300),
//                     Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       size: 18,
//                     )
//                   ],
//                 ),
//                 padVertical(30),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Label(txt: "🏆  Спортшылар", type: TextTypes.f_20_300),
//                     Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       size: 18,
//                     )
//                   ],
//                 ),
//                 padVertical(30),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Label(
//                         txt: "🏛️   Саяси қайраткерлер",
//                         type: TextTypes.f_20_300),
//                     Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       size: 18,
//                     )
//                   ],
//                 ),
//                 padVertical(10),
//               ])))
//             ]))));
//   }
// }
