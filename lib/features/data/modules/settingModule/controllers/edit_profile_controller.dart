import 'dart:convert';
import 'dart:io';
import 'package:bookstagram/features/data/modules/settingModule/models/Media_Upload_Response_Model.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../../app_settings/constants/app_config.dart';
import '../../home_module/models/setttingProfile.dart';
import 'package:image_picker/image_picker.dart';

class PgEditProfileController extends GetxController {
  final Rx<File?> image = Rx<File?>(null);

  // Add TextEditingControllers
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  String? UploadedProfile = "";
  Rx<Country> selectedCountry = Rx<Country>(
    Country(
      phoneCode: '91',
      countryCode: 'IN',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'India',
      example: '7012345678',
      displayName: 'India',
      displayNameNoCountryCode: 'India',
      e164Key: '',
    ),
  );

  final ImagePicker _picker = ImagePicker();

  final RxBool isLoading = true.obs;
  final Rx<SettingProfile?> proileData = Rx<SettingProfile?>(null);

  @override
  void onReady() {
    getProfileApiCall();
    super.onReady();
  }

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  Future<SettingProfile> getProfileApi() async {
    final token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'role': 'admin',
      'x-client-type': 'mobile',
    };

    HttpWithMiddleware httpClient = HttpWithMiddleware.build(
      middlewares: [HttpLogger(logLevel: LogLevel.BODY)],
    );

    final response = await httpClient.get(
      Uri.parse('${AppConfig.baseUrl}${AppConfig.SettingProfileEndPoint}'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return SettingProfile.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch books: ${response.statusCode}');
    }
  }

  Future<SettingProfile> updateProfile() async {
    try {
      final token = await getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'role': 'admin',
        'x-client-type': 'mobile',
      };

      HttpWithMiddleware httpClient = HttpWithMiddleware.build(
        middlewares: [HttpLogger(logLevel: LogLevel.BODY)],
      );

      String uri = '${AppConfig.baseUrl}${AppConfig.editProfileEndPoint}';

      final response = await httpClient.put(Uri.parse(uri),
          headers: headers,
          body: jsonEncode({
            "email": emailController.text,
            "dob": DateFormat('yyyy-MM-dd').format(selectedDate.value!),
            "firstName": {
              "kaz": fullNameController.text,
              "eng": fullNameController.text,
              "rus": fullNameController.text
            },
            "lastName": {"kaz": " ", "eng": " ", "rus": " "},
            "country": countryController.text,
            "phoneNumber": phoneNumberController.text,
            "profilePic": UploadedProfile != ""
                ? UploadedProfile
                : proileData.value?.data?.data?.profilePic,
          }));

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return SettingProfile.fromJson(jsonBody);
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      throw e;
    }
  }

  getBookTitle({required dynamic name}) {
    const String defaultTitle = 'No Title';
    String selectedLanguage = Get.locale?.languageCode ?? "";

    if (name == null) return defaultTitle;
    switch (selectedLanguage) {
      case 'en':
        return name.eng?.toString() ?? "";
      case 'kk':
        return name.kaz?.toString() ?? "";
      case 'ru':
        return name.rus?.toString() ?? "";
    }
  }

  Future<void> getProfileApiCall() async {
    isLoading.value = true;
    try {
      var data = await getProfileApi();
      proileData.value = data;
      fullNameController.text =
          getBookTitle(name: proileData.value?.data?.data?.fullName);
      emailController.text = proileData.value?.data?.data?.email ?? "";
      countryController.text = proileData.value?.data?.data?.country ?? "";
      phoneNumberController.text =
          proileData.value?.data?.data?.phoneNumber ?? "";
      proileData.refresh();
    } catch (e) {
      print("Error profile Detail: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handelUpdateProfile() async {
    isLoading.value = true;
    try {
      var data = await updateProfile();
      proileData.value = data;

      Get.back();
      proileData.refresh();
    } catch (e) {
      print("Error profile Detail: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    selectedDate.value = DateTime(1995, 12, 27);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime(1995, 12, 27),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  Future<void> uploadFileInBody() async {
    if (image.value == null) {
      Get.snackbar(
        'Error',
        'No image selected',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.red,
        colorText: Colors.white,
      );
      return;
    }

    final token = await getToken();
    final String url = '${AppConfig.baseUrl}${AppConfig.MediaUploadEndPoint}';
    isLoading.value = true;
    try {
      final dioClient = dio.Dio();
      dioClient.interceptors.add(dio.LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));

      final file = image.value!;
      final fileName = file.path.split('/').last;

      // Create multipart form data using Dio's FormData
      final formData = dio.FormData.fromMap({
        'image': await dio.MultipartFile.fromFile(
          // Changed field name to 'image'
          file.path,
          filename: fileName,
          contentType: MediaType('image', fileName.split('.').last),
        ),
      });

      final response = await dioClient.post(
        url,
        data: formData,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
            'role': 'admin',
            'x-client-type': 'mobile',
          },
        ),
      );

      if (response.statusCode == 200) {
        final jsonBody = response.data;
        final imageKey = jsonBody['data']['imageKey'];
        print('Upload successful. Key: $imageKey');
        UploadedProfile = imageKey;
        handelUpdateProfile();
      } else {
        final errorMessage = response.data is Map
            ? response.data['message'] ??
                'Upload failed: ${response.statusCode}'
            : 'Upload failed: ${response.statusCode}';
        print('Upload failed: $errorMessage');
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      String errorMessage = 'Failed to upload image: $e';
      if (e is dio.DioException && e.response != null) {
        errorMessage = e.response!.data is Map
            ? e.response!.data['message'] ??
                'Failed to upload image: ${e.response!.statusCode}'
            : 'Failed to upload image: ${e.response!.statusCode}';
      }
      print('Error uploading file: $e');
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        image.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: Colors.white,
      );
    }
  }

  void updateCountry(Country? country) {
    if (country != null) {
      selectedCountry.value = country;
      countryController.text = country.name;
    }
  }
}
