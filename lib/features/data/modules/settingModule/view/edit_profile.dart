import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/components/widget_global_margin.dart';
import 'package:bookstagram/app_settings/constants/app_assets.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/constants/app_const.dart';
import 'package:bookstagram/app_settings/constants/app_dim.dart';
import 'package:bookstagram/localization/app_localization.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../app_settings/components/loader.dart';
import '../../../../../app_settings/constants/app_config.dart';
import '../controllers/edit_profile_controller.dart';

class PgEditProfileView extends GetView<PgEditProfileController> {
  const PgEditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: WidgetGlobalMargin(
          child: Obx(() => controller.isLoading.value == true
              ? Container(
                  height: Get.height,
                  width: Get.width,
                  child: Center(child: LoadingScreen()))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            padVertical(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back),
                                ),
                                Label(
                                  txt: AppLocalization.of(context)
                                      .translate('personalinfo'),
                                  type: TextTypes.f_20_500,
                                ),
                                const Label(
                                    txt: "   ", type: TextTypes.f_20_500),
                              ],
                            ),
                            padVertical(20),
                            Center(
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Obx(() {
                                    final fileImage = controller.image.value;
                                    final profilePic = controller.proileData
                                        .value?.data?.data?.profilePic;

                                    ImageProvider? backgroundImg;

                                    if (fileImage != null) {
                                      backgroundImg = FileImage(fileImage);
                                    } else if (profilePic != null &&
                                        profilePic.isNotEmpty) {
                                      final imageUrl = profilePic
                                              .startsWith("http")
                                          ? profilePic
                                          : "${AppConfig.imgBaseUrl}$profilePic";
                                      backgroundImg = NetworkImage(imageUrl);
                                    }

                                    return CircleAvatar(
                                      radius: 70,
                                      backgroundColor:
                                          AppColors.grey.withOpacity(0.3),
                                      backgroundImage: backgroundImg,
                                      child: backgroundImg == null
                                          ? const Icon(Icons.person,
                                              size: 60, color: AppColors.grey)
                                          : null,
                                    );
                                  }),
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () => _showImageSourceDialog(),
                                      child: const CircleAvatar(
                                        radius: 18,
                                        backgroundColor: AppColors.primaryColor,
                                        child: Icon(Icons.edit,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            padVertical(20),
                            _buildTextField(
                                AppLocalization.of(context)
                                    .translate('fullname'),
                                controller.fullNameController),
                            padVertical(15),
                            _buildTextField(
                                AppLocalization.of(context).translate('Email'),
                                isonly: true,
                                controller.emailController),
                            padVertical(15),
                            _buildTextField(
                                AppLocalization.of(context)
                                    .translate('phonenumber'),
                                controller.phoneNumberController),
                            padVertical(10),
                            _buildTextField(
                                AppLocalization.of(context)
                                    .translate('country'),
                                controller.countryController,
                                isread: false, onTap: () {
                              showCountryPicker(
                                context: context,
                                countryListTheme: CountryListThemeData(
                                  flagSize: 25,
                                  backgroundColor: Colors.white,
                                  textStyle: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                  bottomSheetHeight: 500,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                  inputDecoration: InputDecoration(
                                    labelText: 'Search',
                                    hintText: 'Start typing to search',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFF8C98A8)
                                              .withOpacity(0.2)),
                                    ),
                                  ),
                                ),
                                onSelect: (Country country) {
                                  controller.updateCountry(country);
                                },
                              );
                            }),
                            // _buildCountryPicker(controller),
                            padVertical(10),
                            _buildDatePicker(context),
                            padVertical(20),
                            TextButton(
                              onPressed: () {},
                              child: Label(
                                txt: AppLocalization.of(context)
                                    .translate('changepass'),
                                type: TextTypes.f_15_400,
                                forceColor: AppColors.primaryColor,
                              ),
                            ),
                            Container(
                              width: Get.width,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (controller.image.value == null) {
                                      controller.handelUpdateProfile();
                                    } else {
                                      await controller.uploadFileInBody();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Label(
                                    txt: AppLocalization.of(context)
                                        .translate('save'),
                                    type: TextTypes.f_17_500,
                                    forceColor: AppColors.whiteColor,
                                  )),
                            ).marginOnly(bottom: 20)
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController? controller,
      {onTap, bool? isread = true, bool? isonly = false}) {
    return GestureDetector(
      onTap: () => onTap.call() ?? {},
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Label(
              txt: label,
              type: TextTypes.f_15_400,
              forceColor: AppColors.resnd,
            ),
            TextFormField(
              enabled: isonly == true ? false : isread ?? true,
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: isread == false
                    ? Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.primaryColor,
                      )
                    : null,
                border: UnderlineInputBorder(),
                disabledBorder: UnderlineInputBorder(),
              ),
              style: const TextStyle(
                  fontFamily: AppConst.fontFamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            padVertical(10),
          ],
        ),
      ),
    );
  }

  // Widget _buildCountryPicker(PgEditProfileController controller) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Label(
  //         txt: "Country",
  //         type: TextTypes.f_15_400,
  //         forceColor: AppColors.resnd,
  //       ),
  //       Container(
  //         decoration: BoxDecoration(
  //           border: Border(
  //             bottom: BorderSide(color: Colors.black),
  //           ),
  //         ),
  //         child: Obx(() => DropdownButton<String>(
  //               isExpanded: true,
  //               underline: SizedBox(),
  //               value: controller.selectedCountry.value,
  //               onChanged: (String? newCountry) {
  //                 controller.updateCountry(newCountry);
  //               },
  //               items: controller.countries
  //                   .map((country) => DropdownMenuItem<String>(
  //                         value: country,
  //                         child: Text(country),
  //                       ))
  //                   .toList(),
  //             )),
  //       ),
  //     ],
  //   );
  // }

  void _showImageSourceDialog() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                controller.pickImage(ImageSource.camera);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                controller.pickImage(ImageSource.gallery);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Label(
          txt: AppLocalization.of(context).translate('birthday'),
          type: TextTypes.f_15_400,
          forceColor: AppColors.resnd,
        ),
        GestureDetector(
          onTap: () => controller.selectDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Label(
                  txt: controller.selectedDate.value != null
                      ? DateFormat('MM/dd/yyyy')
                          .format(controller.selectedDate.value!)
                      : "MM/dd/yyyy",
                  type: TextTypes.f_20_300,
                  // "12/27/1995",
                ),
                const Icon(Icons.calendar_today, color: AppColors.primaryColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
