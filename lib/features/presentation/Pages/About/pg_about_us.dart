// import 'package:bookstagram/app_settings/components/label.dart';
// import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
// import 'package:bookstagram/app_settings/constants/app_colors.dart';
// import 'package:bookstagram/app_settings/constants/app_dim.dart';
// import 'package:bookstagram/app_settings/constants/helpers.dart';
// import 'package:bookstagram/features/presentation/Pages/About/Widgets/webview.dart';
// import 'package:bookstagram/localization/app_localization.dart';
// import 'package:bookstagram/app_settings/constants/app_assets.dart';
// import 'package:flutter/material.dart';
//
// class PgAboutUs extends StatefulWidget {
//   const PgAboutUs({super.key});
//
//   @override
//   State<PgAboutUs> createState() => _PgAboutUsState();
// }
//
// final List<Map<String, String>> webLinksenglish = [
//   {'title': 'aboutproject', 'url': 'https://bookstagram.kz/en/about'},
//   {'title': 'Copyright', 'url': 'https://bookstagram.kz/en/copyright'},
//   {'title': 'Partners', 'url': 'https://bookstagram.kz/en/partners'},
//   {'title': 'privacypolicy', 'url': 'https://bookstagram.kz/en/privacy'},
//   {
//     'title': 'conditionsuse','url': 'https://bookstagram.kz/en/conditions-of-use'
//   },
//   {'title': 'offerta', 'url': 'https://bookstagram.kz/en/offerta'},
//   {'title': 'forinvestors', 'url': 'https://bookstagram.kz/en/investors'},
//   {
//     'title': 'applicationcooperation',
//     'url': 'https://bookstagram.kz/en/cooperation'
//   },
// ];
//
// final List<Map<String, String>> webLinkskazak = [
//   {'title': 'aboutproject', 'url': 'https://bookstagram.kz/kz/about'},
//   {'title': 'Copyright', 'url': 'https://bookstagram.kz/kz/copyright'},
//   {'title': 'Partners', 'url': 'https://bookstagram.kz/kz/partners'},
//   {'title': 'privacypolicy', 'url': 'https://bookstagram.kz/kz/privacy'},
//   {
//     'title': 'conditionsuse','url': 'https://bookstagram.kz/kz/conditions-of-use'
//   },
//   {'title': 'offerta', 'url': 'https://bookstagram.kz/kz/offerta'},
//   {'title': 'forinvestors', 'url': 'https://bookstagram.kz/kz/investors'},
//   {
//     'title': 'applicationcooperation',
//     'url': 'bookstagram.kz/kz/cooperation'
//   },
// ];
//
// class _PgAboutUsState extends State<PgAboutUs> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: WidgetGlobalMargin(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// App Bar Row
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
//                     txt: AppLocalization.of(context)
//                         .translate('bookstagram_about'),
//                     type: TextTypes.f_20_500,
//                   ),
//                   const Label(txt: "   ", type: TextTypes.f_20_500),
//                 ],
//               ),
//
//               padVertical(20),
//
//               /// Logo
//               Center(
//                 child: Image.asset(
//                   AppAssets.logo,
//                   fit: BoxFit.contain,
//                   width: ScreenUtils.screenWidth(context) / 1.6,
//                   height: 175,
//                 ),
//               ),
//
//               padVertical(20),
//
//               const Center(
//                 child: Label(
//                   txt: "Bookstagram v1.1.1",
//                   type: TextTypes.f_22_400,
//                 ),
//               ),
//
//               padVertical(5),
//               const Divider(),
//               padVertical(10),
//
//               /// List of Links - Fixed ListView Issue
//               Expanded(
//                 child: ListView.separated(
//                   shrinkWrap:
//                       true, // ✅ Important: Allows ListView inside Column
//                   padding: EdgeInsets.all(10),
//                   itemCount: webLinksenglish.length,
//                   separatorBuilder: (context, index) => SizedBox(height: 20),
//                   itemBuilder: (context, index) {
//                     final item = webLinksenglish[index];
//
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => WebViewScreen(
//                               title: AppLocalization.of(context)
//                                   .translate(item['title']!),
//                               url: item['url']!,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Label(
//                             txt: AppLocalization.of(context)
//                                 .translate(item['title']!),
//                             type: TextTypes.f_17_500,
//                           ),
//                           const Icon(
//                             Icons.arrow_forward_ios_rounded,
//                             size: 20,
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     Label(
//               //       txt: AppLocalization.of(context).translate('aboutproject'),
//               //       type: TextTypes.f_17_500,
//               //     ),
//               //     const Icon(
//               //       Icons.arrow_forward_ios_rounded,
//               //       size: 20,
//               //     )
//               //   ],
//               // ),
//               // padVertical(30),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     Label(
//               //       txt: AppLocalization.of(context).translate('Copyright'),
//               //       type: TextTypes.f_17_500,
//               //     ),
//               //     const Icon(
//               //       Icons.arrow_forward_ios_rounded,
//               //       size: 20,
//               //     )
//               //   ],
//               // ),
//               // padVertical(30),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     Label(
//               //       txt: AppLocalization.of(context).translate('Partners'),
//               //       type: TextTypes.f_17_500,
//               //     ),
//               //     const Icon(
//               //       Icons.arrow_forward_ios_rounded,
//               //       size: 20,
//               //     )
//               //   ],
//               // ),
//               // padVertical(30),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     Label(
//               //       txt: AppLocalization.of(context).translate('privacypolicy'),
//               //       type: TextTypes.f_17_500,
//               //     ),
//               //     const Icon(
//               //       Icons.arrow_forward_ios_rounded,
//               //       size: 20,
//               //     )
//               //   ],
//               // ),
//               // padVertical(30),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     Label(
//               //       txt: AppLocalization.of(context).translate('conditionsuse'),
//               //       type: TextTypes.f_17_500,
//               //     ),
//               //     const Icon(
//               //       Icons.arrow_forward_ios_rounded,
//               //       size: 20,
//               //     )
//               //   ],
//               // ),
//               // padVertical(30),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     Label(
//               //       txt: AppLocalization.of(context).translate('offerta'),
//               //       type: TextTypes.f_17_500,
//               //     ),
//               //     const Icon(
//               //       Icons.arrow_forward_ios_rounded,
//               //       size: 20,
//               //     )
//               //   ],
//               // ),
//               // padVertical(30),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     Label(
//               //       txt: AppLocalization.of(context).translate('forinvestors'),
//               //       type: TextTypes.f_17_500,
//               //     ),
//               //     const Icon(
//               //       Icons.arrow_forward_ios_rounded,
//               //       size: 20,
//               //     )
//               //   ],
//               // ),
//               // padVertical(30),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     Label(
//               //       txt: AppLocalization.of(context)
//               //           .translate('applicationcooperation'),
//               //       type: TextTypes.f_17_500,
//               //     ),
//               //     const Icon(
//               //       Icons.arrow_forward_ios_rounded,
//               //       size: 20,
//               //     )
//               //   ],
//               // )
// //             ])))
// //           ],
// //         ),
// //       )),
// //     );
// //   }
// // }
