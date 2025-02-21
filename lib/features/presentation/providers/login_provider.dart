import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/features/data/models/login_model.dart';
import 'package:bookstagram/features/domain/ds_providers/remote_repo_provider.dart';
import 'package:bookstagram/features/domain/usecases/usecase_login.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';

/// Provider for the login use case
final loginProvider = Provider<UsecaseLogin>((ref) {
  final repository = ref.read(remoteRepositoryProvider);
  return UsecaseLogin(repository: repository);
});

/// StateNotifierProvider to handle login logic and state
final stateLoginNotifierProvider =
    StateNotifierProvider<LoginNotifier, AsyncValue<LoginModel?>>((ref) {
  final login = ref.read(loginProvider);
  return LoginNotifier(login);
});

/// StateNotifierProvider to manage form validation
final loginFormNotifierProvider =
    StateNotifierProvider<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier();
});

/// Model class for form validation state
class LoginFormState {
  final bool isEmailError;
  final bool isPasswordError;

  LoginFormState({
    this.isEmailError = false,
    this.isPasswordError = false,
  });

  LoginFormState copyWith({bool? isEmailError, bool? isPasswordError}) {
    return LoginFormState(
      isEmailError: isEmailError ?? this.isEmailError,
      isPasswordError: isPasswordError ?? this.isPasswordError,
    );
  }
}

/// StateNotifier to manage form validation logic
class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier() : super(LoginFormState());

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
class LoginNotifier extends StateNotifier<AsyncValue<LoginModel?>> {
  final UsecaseLogin _loginUseCase;

  LoginNotifier(this._loginUseCase) : super(const AsyncValue.data(null));

  Future<void> login(
      {required String email,
      required String pass,
      required String phoneNumber,
      required String language,
      required String authType,
      required void Function(LoginModel) onSuccess,
      required BuildContext context}) async {
    try {
      state = const AsyncValue.loading();
      final data = await _loginUseCase.call(
          email: email,
          pass: pass,
          phoneNumber: phoneNumber,
          language: language,
          authType: authType);

      data.fold(
        (error) {
          print("yes here error ${error.message.toString()}");
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
          txt: "Error sign in: $e",
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
