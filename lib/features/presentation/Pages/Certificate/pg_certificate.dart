// import 'package:bookstagram/app_settings/components/label.dart';
// import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
// import 'package:bookstagram/app_settings/constants/app_assets.dart';
// import 'package:bookstagram/app_settings/constants/app_colors.dart';
// import 'package:bookstagram/app_settings/constants/app_dim.dart';
// import 'package:bookstagram/localization/app_localization.dart';
// import 'package:flutter/material.dart';
//
// class PgCertificate extends StatefulWidget {
//   const PgCertificate({super.key});
//
//   @override
//   State<PgCertificate> createState() => _PgCertificateState();
// }
//
// class _PgCertificateState extends State<PgCertificate> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//           child: WidgetGlobalMargin(
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//             Expanded(
//                 child: SingleChildScrollView(
//                     child: Column(mainAxisSize: MainAxisSize.min, children: [
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                 IconButton(
//                   icon: const Icon(
//                     Icons.arrow_back_ios,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.file_upload_outlined),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ]),
//               padVertical(12),
//               Image.asset(
//                 AppAssets.coursecertificate,
//                 fit: BoxFit.contain,
//               ),
//             ])))
//           ]))),
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
//         color: Colors.white,
//         child: ElevatedButton(
//             onPressed: () {
//               // Handle buy now button
//             },
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.all(12),
//               backgroundColor: AppColors.primaryColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Label(
//                   txt: AppLocalization.of(context)
//                       .translate('downloadcertificate'),
//                   type: TextTypes.f_17_500,
//                   forceColor: AppColors.whiteColor,
//                 ),
//                 padHorizontal(10),
//                 Icon(
//                   Icons.cloud_download_outlined,
//                   color: AppColors.whiteColor,
//                 )
//               ],
//             )),
//       ),
//     );
//   }
// }
