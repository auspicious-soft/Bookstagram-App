// import 'package:bookstagram/app_settings/components/label.dart';
// import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
// import 'package:bookstagram/app_settings/constants/app_assets.dart';
// import 'package:bookstagram/app_settings/constants/app_colors.dart';
// import 'package:bookstagram/app_settings/constants/app_dim.dart';
// import 'package:bookstagram/app_settings/constants/helpers.dart';
// import 'package:flutter/material.dart';
//
// class PgEventDetail extends StatefulWidget {
//   const PgEventDetail({super.key});
//
//   @override
//   State<PgEventDetail> createState() => _PgEventDetailState();
// }
//
// class _PgEventDetailState extends State<PgEventDetail> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 Image.asset(
//                   AppAssets.banner,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: ScreenUtils.screenHeight(context) / 2.3,
//                 ),
//                 Positioned(
//                     top: MediaQuery.of(context).padding.top + 15,
//                     left: 0,
//                     right: 0,
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.arrow_back_ios,
//                                 color: Colors.white),
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                           ),
//                           const Label(
//                             txt: "Афиша",
//                             type: TextTypes.f_20_500,
//                             forceColor: AppColors.whiteColor,
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.file_upload_outlined,
//                                 color: Colors.white),
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                           ),
//                         ])),
//                 Positioned(
//                   top: MediaQuery.of(context).size.height / 3,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     height: 120,
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.transparent,
//                           Colors.white.withOpacity(0.9),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             WidgetGlobalMargin(
//                 child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 padVertical(8),
//                 const Label(
//                     txt: "Кітаптардың тұсаукесер рәсімі",
//                     type: TextTypes.f_22_700),
//                 padVertical(5),
//                 const Label(txt: "Презентация", type: TextTypes.f_16_500),
//                 padVertical(20),
//                 const Label(
//                   txt:
//                       "15 қараша күні, сағат 15.00-де Алматы қаласында орналасқан «Қазақстан» қонақүйінің «Алтын Емел» залында «Абай» баспасынан 2024 жылы жарық көрген 155 кітаптың тұсаукесері өтеді.Былтыр, 2023 жылы «Абай» баспасынан шыққан 35 кітаптың тұсаукесері өткен кезде баспа ұжымы «алдағы 2024 жылы қазақтың көркем әдебиет туындыларын 100 томдыққа жеткіземіз» деген уәде берген еді.",
//                   type: TextTypes.f_16_500,
//                   forceColor: AppColors.resnd,
//                 ),
//               ],
//             ))
//           ],
//         ),
//       ),
//     );
//   }
// }
