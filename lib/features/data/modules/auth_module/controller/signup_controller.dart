import 'dart:convert';

import 'package:bookstagram/app_settings/constants/app_config.dart';
import 'package:bookstagram/features/domain/repositories/remote_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bookstagram/features/domain/usecases/usecase_signup.dart';
import 'package:bookstagram/features/data/models/signup_model.dart';
import 'package:bookstagram/features/data/models/login_model.dart';
import 'package:bookstagram/features/data/datasources/user_storage.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/app_settings/components/label.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../../domain/usecases/usecase_login.dart';
import '../../../../presentation/providers/auth_google_service.dart';

class SignUpController extends GetxController {
  // Services and use cases

  // late final UsecaseSignup _signUpUseCase;
  late final UsecaseLogin _useCaseLogin;
  final authService =
      Get.find<AuthGoogleService>(); // Assuming you've registered this service

  // Form controllers
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  // Form state
  var selectedIndex = 0.obs;
  var passEye = true.obs;
  var comPassEye = true.obs;
  var countryCode = "+1".obs;

  // Loading state
  var isLoading = false.obs;

  // Error states
  var isEmailError = false.obs;
  var isNameError = false.obs;
  var isLastNameError = false.obs;
  var isPassError = false.obs;
  var isConfPass = false.obs;
  var isPhoneError = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repPasswordController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    // _signUpUseCase = Get.find<UsecaseSignup>();
    _useCaseLogin = Get.find<UsecaseLogin>();
    super.onInit();
  }

  // Validation methods
  void validateEmail(String value) {
    isEmailError.value =
        value.isEmpty || !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
  }

  void validateName(String value) {
    isNameError.value = value.isEmpty;
  }

  void validateLastName(String value) {
    isLastNameError.value = value.isEmpty;
  }

  void validatePassword(String value) {
    isPassError.value = value.isEmpty;
  }

  void validateConfirmPassword(String value) {
    isConfPass.value = value != passwordController.text;
  }

  void setCountryCode(String code) {
    countryCode.value = code;
  }

  void togglePassEye() {
    passEye.value = !passEye.value;
  }

  void toggleComPassEye() {
    comPassEye.value = !comPassEye.value;
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  // Check if form is valid
  bool isFormValid() {
    return !isEmailError.value &&
        !isPassError.value &&
        !isConfPass.value &&
        nameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        repPasswordController.text.isNotEmpty;
  }

  Future<void> signUp(BuildContext context) async {
    isLoading.value = true;
    if (!isFormValid()) {
      validateEmail(emailController.text);
      validateName(nameController.text);
      validateLastName(lastNameController.text);
      validatePassword(passwordController.text);
      validateConfirmPassword(repPasswordController.text);
      isLoading.value = false;
      MotionToast.error(
        title: const Label(
          txt: "Error",
          type: TextTypes.f_15_500,
          forceColor: AppColors.whiteColor,
        ),
        description: const Label(
          txt: "All fields are required!",
          type: TextTypes.f_13_500,
          forceColor: AppColors.whiteColor,
        ),
        animationType: AnimationType.slideInFromBottom,
        toastAlignment: Alignment.topRight,
        dismissable: true,
      ).show(context);
      return;
    }

    try {
      String selectedLanguage = Get.locale?.languageCode ?? "";
      //     print("Selected language>>>>>>>>>>>: $selectedLanguage");
      final headers = {
        'Content-Type': 'application/json',
        'role': 'admin',
        'x-client-type': 'mobile',
      };

      final body = jsonEncode({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "language": selectedLanguage == "en"
            ? "eng"
            : selectedLanguage == "kk"
                ? "kaz"
                : "rus",
        "authType": selectedIndex.value == 0 ? "Email" : "Whatsapp",
        "firstName": {
          "rus": selectedLanguage == "ru" ? nameController.text : null,
          "eng": selectedLanguage == "en" ? nameController.text : null,
          "kaz": selectedLanguage == "kk" ? nameController.text : null,
        },
        "lastName": {
          "rus": selectedLanguage == "ru" ? lastNameController.text : null,
          "eng": selectedLanguage == "en" ? lastNameController.text : null,
          "kaz": selectedLanguage == "kk" ? lastNameController.text : null,
        },
        // Optional fields, add if needed
        // "countryCode": "+91",
        // "phoneNumber": "645636356546",
      });

      HttpWithMiddleware httpClient = HttpWithMiddleware.build(
        middlewares: [HttpLogger(logLevel: LogLevel.BODY)],
      );

      String uri = '${AppConfig.baseUrl}${AppConfig.signUp}';

      final response = await httpClient.post(
        Uri.parse(uri),
        headers: headers,
        body: body,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {


        MotionToast.success(
          title: const Label(
            txt: "Success",
            type: TextTypes.f_15_500,
            forceColor: AppColors.whiteColor,
          ),
          description: Label(
            txt: responseData['message'] ?? "Sign up successful",
            type: TextTypes.f_13_500,
            forceColor: AppColors.whiteColor,
          ),
          animationType: AnimationType.slideInFromBottom,
          toastAlignment: Alignment.topRight,
          dismissable: true,
        ).show(context);

        debugPrint("Signup successful >>>>>>>>>>>>>>>>>>>>>>>");

        Get.toNamed('/otpscreen', arguments: {
          'type': selectedIndex.value == 0
              ? emailController.text
              : phoneController.text,
          'from': 'signup',
        });
        emailController.text = "";
        passwordController.text = "";
        nameController.text = "";
        lastNameController.text = "";
        repPasswordController.text = "";
      } else {
        MotionToast.error(
          title: const Label(
            txt: "Signup Failed",
            type: TextTypes.f_15_500,
            forceColor: AppColors.whiteColor,
          ),
          description: Label(
            txt: responseData['message'] ?? "Something went wrong.",
            type: TextTypes.f_13_500,
            forceColor: AppColors.whiteColor,
          ),
          animationType: AnimationType.slideInFromBottom,
          toastAlignment: Alignment.topRight,
          dismissable: true,
        ).show(context);
        print("Signup failed: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      MotionToast.error(
        title: const Label(
          txt: "Error",
          type: TextTypes.f_15_500,
          forceColor: AppColors.whiteColor,
        ),
        description: Label(
          txt: e.toString(),
          type: TextTypes.f_13_500,
          forceColor: AppColors.whiteColor,
        ),
        animationType: AnimationType.slideInFromBottom,
        toastAlignment: Alignment.topRight,
        dismissable: true,
      ).show(context);

      print("Error: ${e.toString()}");
      throw e;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    // Force account selection by clearing any cached credentials first
    await GoogleSignIn().signOut();
    try {
      isLoading.value = true;

      var user = await authService.signInWithGoogle();

      if (user != null) {
        final loginUseCase = _useCaseLogin;
        final data = await loginUseCase.call(
          email: user.email.toString(),
          pass: " ",
          phoneNumber: "",
          language: "en",
          authType: "Google",
        );

        data.fold(
          (error) {
            MotionToast.error(
              title: const Label(
                txt: "Error",
                type: TextTypes.f_15_500,
                forceColor: AppColors.whiteColor,
              ),
              description: Label(
                txt: error.message,
                type: TextTypes.f_13_500,
                forceColor: AppColors.whiteColor,
              ),
              animationType: AnimationType.slideInFromBottom,
              toastAlignment: Alignment.topRight,
              dismissable: true,
            ).show(context);
          },
          (fineData) async {
            await UserStorage.con.saveToken(fineData.data?.token);
            // MotionToast.success(
            //   title: const Label(
            //     txt: "Success",
            //     type: TextTypes.f_15_500,
            //     forceColor: AppColors.whiteColor,
            //   ),
            //   description: Label(
            //     txt: fineData.message ?? "Login successful",
            //     type: TextTypes.f_13_500,
            //     forceColor: AppColors.whiteColor,
            //   ),
            //   animationType: AnimationType.fromTop,
            //   position: MotionToastPosition.top,
            //   dismissable: true,
            // ).show(context);

            Get.offAllNamed('/congratulations');
          },
        );
      }
    } catch (e) {
      MotionToast.error(
        title: const Label(
          txt: "Error",
          type: TextTypes.f_15_500,
          forceColor: AppColors.whiteColor,
        ),
        description: Label(
          txt: "Google sign-in error: $e",
          type: TextTypes.f_13_500,
          forceColor: AppColors.whiteColor,
        ),
        animationType: AnimationType.slideInFromBottom,
        toastAlignment: Alignment.topRight,
        dismissable: true,
      ).show(context);
    } finally {
      isLoading.value = false;
    }
  }
}
