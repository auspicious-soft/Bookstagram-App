import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';

import 'package:bookstagram/features/data/models/signup_model.dart';
import 'package:bookstagram/features/domain/ds_providers/remote_repo_provider.dart';

import 'package:bookstagram/features/domain/usecases/usecase_signup.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';

/// Provider for the signup use case
final signUpProvider = Provider<UsecaseSignup>((ref) {
  final repository = ref.read(remoteRepositoryProvider);
  return UsecaseSignup(repository: repository);
});

/// StateNotifierProvider to handle signup logic and state
final stateSignUpNotifierProvider =
    StateNotifierProvider<SignUpNotifier, AsyncValue<SignUpModel?>>((ref) {
  final signUp = ref.read(signUpProvider);
  return SignUpNotifier(signUp);
});

/// StateNotifierProvider to manage form validation
final signUpFormNotifierProvider =
    StateNotifierProvider<SignUpFormNotifier, SignUpFormState>((ref) {
  return SignUpFormNotifier();
});

/// Model class for form validation state
class SignUpFormState {
  final bool isEmailError;
  final bool isPasswordError;

  SignUpFormState({
    this.isEmailError = false,
    this.isPasswordError = false,
  });

  SignUpFormState copyWith({bool? isEmailError, bool? isPasswordError}) {
    return SignUpFormState(
      isEmailError: isEmailError ?? this.isEmailError,
      isPasswordError: isPasswordError ?? this.isPasswordError,
    );
  }
}

/// StateNotifier to manage form validation logic
class SignUpFormNotifier extends StateNotifier<SignUpFormState> {
  SignUpFormNotifier() : super(SignUpFormState());

  void validateForm(String email, String password) {
    final isEmailError =
        email.isEmpty || !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
    final isPasswordError = password.isEmpty;

    state = state.copyWith(
      isEmailError: isEmailError,
      isPasswordError: isPasswordError,
    );
  }
}

/// StateNotifier to handle login actions
class SignUpNotifier extends StateNotifier<AsyncValue<SignUpModel?>> {
  final UsecaseSignup _signUpUseCase;

  SignUpNotifier(this._signUpUseCase) : super(const AsyncValue.data(null));

  Future<void> signUp(
      {required String email,
      required String countryCode,
      required String phoneNumber,
      required String fullname,
      required String firstname,
      required String lastname,
      required String pass,
      required String language,
      required String authType,
      required void Function(SignUpModel) onSuccess,
      required BuildContext context}) async {
    try {
      state = const AsyncValue.loading();
      final data = await _signUpUseCase.call(
          email: email,
          countryCode: countryCode,
          phoneNumber: phoneNumber,
          fullname: fullname,
          firstname: firstname,
          lastname: lastname,
          pass: pass,
          language: language,
          authType: authType);

      data.fold(
        (error) {
          print("yes here error ${error.message}");
          state = AsyncValue.error(
              error.message, StackTrace.fromString("Failed to fetch user"));
        },
        (fineData) {
          state = AsyncData(fineData);
          onSuccess(fineData);
        },
      );
    } catch (e) {
      MotionToast.error(
        title: const Label(
          txt: "Error",
          type: TextTypes.f_15_500,
          forceColor: AppColors.whiteColor,
        ),
        description: Label(
          txt: "Error sign up: $e",
          type: TextTypes.f_13_500,
          forceColor: AppColors.whiteColor,
        ),
        animationType: AnimationType.fromTop,
        position: MotionToastPosition.top,
        dismissable: true,
      ).show(context);

      state =
          AsyncValue.error(e, StackTrace.fromString("Failed to execute login"));
    }
  }
}
