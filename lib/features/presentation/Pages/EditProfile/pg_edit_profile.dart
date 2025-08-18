// import 'dart:io';
// import 'package:bookstagram/app_settings/components/label.dart';
// import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
// import 'package:bookstagram/app_settings/constants/app_assets.dart';
// import 'package:bookstagram/app_settings/constants/app_colors.dart';
// import 'package:bookstagram/app_settings/constants/app_const.dart';
// import 'package:bookstagram/app_settings/constants/app_dim.dart';
// import 'package:bookstagram/localization/app_localization.dart';
// // import 'package:country_picker/country_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
//
// class PgEditProfile extends StatefulWidget {
//   const PgEditProfile({super.key});
//
//   @override
//   State<PgEditProfile> createState() => _PgEditProfileState();
// }
//
// class _PgEditProfileState extends State<PgEditProfile> {
//   File? _image;
//   final picker = ImagePicker();
//   String fullName = "Duman";
//   String email = "duman.ataibek@gmail.com";
//   String phoneNumber = "+7 700 500 90 00";
//   // Country? _selectedCountry = Country.worldWide;
//
//   DateTime? _selectedDate;
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate ?? DateTime(1995, 12, 27),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }
//
//   // Future<void> _pickImage() async {
//   //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//   //   if (pickedFile != null) {
//   //     setState(() {
//   //       _image = File(pickedFile.path);
//   //     });
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: WidgetGlobalMargin(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       padVertical(10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             icon: const Icon(Icons.arrow_back),
//                           ),
//                           Label(
//                             txt: AppLocalization.of(context)
//                                 .translate('personalinfo'),
//                             type: TextTypes.f_20_500,
//                           ),
//                           const Label(txt: "   ", type: TextTypes.f_20_500),
//                         ],
//                       ),
//                       padVertical(20),
//                       Center(
//                         child: Stack(
//                           children: [
//                             CircleAvatar(
//                               radius: 70,
//                               backgroundImage: _image != null
//                                   ? FileImage(_image!)
//                                   : AssetImage(
//                                       AppAssets.read,
//                                     ) as ImageProvider,
//                             ),
//                             Positioned(
//                               bottom: 5,
//                               right: 5,
//                               child: GestureDetector(
//                                 // onTap: _pickImage,
//                                 child: const CircleAvatar(
//                                   radius: 18,
//                                   backgroundColor: AppColors.primaryColor,
//                                   child: Icon(Icons.edit, color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       padVertical(20),
//                       _buildTextField(
//                           AppLocalization.of(context).translate('fullname'),
//                           fullName),
//                       padVertical(15),
//                       _buildTextField(
//                           AppLocalization.of(context).translate('Email'),
//                           email),
//                       padVertical(15),
//                       _buildTextField(
//                           AppLocalization.of(context).translate('phonenumber'),
//                           phoneNumber),
//                       padVertical(10),
//                       // _buildCountryPicker(),
//                       padVertical(10),
//                       _buildDatePicker(context),
//                       padVertical(40),
//                       TextButton(
//                         onPressed: () {},
//                         child: Label(
//                           txt: AppLocalization.of(context)
//                               .translate('changepass'),
//                           type: TextTypes.f_15_400,
//                           forceColor: AppColors.primaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(String label, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Label(
//           txt: label,
//           type: TextTypes.f_15_400,
//           forceColor: AppColors.resnd,
//         ),
//         TextFormField(
//           initialValue: value,
//           decoration: const InputDecoration(
//             border: UnderlineInputBorder(),
//           ),
//           style: const TextStyle(
//               fontFamily: AppConst.fontFamily,
//               fontSize: 20,
//               fontWeight: FontWeight.w400),
//         ),
//         padVertical(10),
//       ],
//     );
//   }
//
// //  Widget _buildCountryPicker() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Label(txt: "Country", type: TextTypes.f_13_500),
// //         Container(
// //           decoration: BoxDecoration(
// //             border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
// //           ),
// //           child: DropdownButton<Country>(
// //             value: _selectedCountry,
// //             isExpanded: true,
// //             onChanged: (Country? country) {
// //               setState(() {
// //                 _selectedCountry = country;
// //               });
// //             },
// //             items: Country.worldWide((Country country) {
// //               return DropdownMenuItem(
// //                 value: country,
// //                 child: Text(country.name),
// //               );
// //             }).toList(),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
//
//   Widget _buildDatePicker(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Label(
//           txt: AppLocalization.of(context).translate('birthday'),
//           type: TextTypes.f_15_400,
//           forceColor: AppColors.resnd,
//         ),
//         GestureDetector(
//           onTap: () => _selectDate(context),
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             decoration: BoxDecoration(
//               border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Label(
//                   txt: _selectedDate != null
//                       ? DateFormat('MM/dd/yyyy').format(_selectedDate!)
//                       : "MM/dd/yyyy",
//                   type: TextTypes.f_20_300,
//                   // "12/27/1995",
//                 ),
//                 const Icon(Icons.calendar_today, color: AppColors.primaryColor),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
