import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:motion_toast/motion_toast.dart';

import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/features/data/models/login_model.dart';
import 'package:bookstagram/features/domain/usecases/usecase_login.dart';
import 'package:bookstagram/features/data/datasources/user_storage.dart';

import '../../../../presentation/providers/auth_google_service.dart';

class LoginController extends GetxController {
  final UsecaseLogin loginUseCase;

  LoginController({required this.loginUseCase});

  // Observables
  final isLoading = false.obs;
  final loginError = Rxn<String>();
  final loginData = Rxn<LoginModel>();

  // Form validation observables
  final isEmailError = false.obs;
  final isPasswordError = false.obs;
  final isPhoneError = false.obs;

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final restoreEmailController = TextEditingController();

  // UI state
  final passEye = true.obs;
  final selectedIndex = 0.obs;
  final countryCode = "".obs;
  late final UsecaseLogin _useCaseLogin;
  final authService =
      Get.find<AuthGoogleService>(); // Assuming you've registered this service

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    restoreEmailController.dispose();
    super.onClose();
  }

  void togglePassEye() {
    passEye.value = !passEye.value;
  }

  void setTabIndex(int index) {
    selectedIndex.value = index;
  }

  void setCountryCode(String code) {
    countryCode.value = code;
  }

  void validateForm() {
    isEmailError.value = emailController.text.isEmpty ||
        !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(emailController.text);
    isPasswordError.value = passwordController.text.isEmpty;
    isPhoneError.value =
        phoneController.text.isEmpty || phoneController.text.length < 10;
  }

  bool get isFormValid =>
      !isEmailError.value &&
      !isPasswordError.value &&
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(emailController.text);

  Future<void> login({
    required String authType,
    required String language,
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;

      final data = await loginUseCase.call(
        email: emailController.text,
        pass: passwordController.text,
        fullName: "",
        profilePic: "",
        phoneNumber: selectedIndex.value == 0 ? "" : phoneController.text,
        language: language,
        authType: authType,
      );

      data.fold(
        (error) {
          loginError.value = error.message;
          showErrorToast(context, error.message.toString());
        },
        (fineData) {
          loginData.value = fineData;
          goToDashboard(fineData, context);
        },
      );
    } catch (e) {
      loginError.value = e.toString();
      showErrorToast(context, "Error sign in: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    _useCaseLogin = Get.find<UsecaseLogin>();
    super.onInit();
  }

  Future<void> loginWithSocial({
    required String email,
    required String authType,
    required String language,
    required String fullName,
    required String profilePic,
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;

      final data = await loginUseCase.call(
        email: email,
        pass: " ",
        phoneNumber: "",
        fullName: fullName,
        profilePic: profilePic,
        language: language,
        authType: authType,
      );

      data.fold(
        (error) {
          loginError.value = error.message;
          showErrorToast(context, error.message.toString());
        },
        (fineData) {
          loginData.value = fineData;
          goToDashboard(fineData, context);
        },
      );
    } catch (e) {
      loginError.value = e.toString();
      showErrorToast(context, "Error sign in: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void showErrorToast(BuildContext context, String message) {
    MotionToast.error(
      title: const Label(
        txt: "Error",
        type: TextTypes.f_15_500,
        forceColor: AppColors.whiteColor,
      ),
      description: Label(
        txt: message,
        type: TextTypes.f_13_500,
        forceColor: AppColors.whiteColor,
      ),
      animationType: AnimationType.slideInFromBottom,
      toastAlignment: Alignment.topRight,
      dismissable: true,
    ).show(context);
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    await GoogleSignIn().signOut();
    try {
      isLoading.value = true;

      // Force account selection by clearing any cached credentials first

      // Then proceed with sign in
      var user = await authService.signInWithGoogle();

      if (user != null) {
        print("${user.displayName}>>>>>>>>>>>>>>>");
        print(user.photoURL);

        final data = await loginUseCase.call(
          email: user.email.toString(),
          pass: " ",
          phoneNumber: "",
          fullName: user.displayName.toString(),
          profilePic: user.photoURL.toString(),
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

  void goToDashboard(LoginModel fineData, BuildContext context) async {
    await UserStorage.con.saveToken(fineData.data?.token);

    MotionToast.success(
      title: const Label(
        txt: "Success",
        type: TextTypes.f_15_500,
        forceColor: AppColors.whiteColor,
      ),
      description: const Label(
        txt: "Logged in successfully",
        type: TextTypes.f_13_500,
        forceColor: AppColors.whiteColor,
      ),
      animationType: AnimationType.slideInFromBottom,
      toastAlignment: Alignment.topRight,
      dismissable: true,
    ).show(context);
    emailController.text = "";
    passwordController.text = "";
    Get.offAllNamed("/congratulations");
  }
}
