import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/features/data/models/verification_otp_model.dart';
import 'package:bookstagram/features/domain/ds_providers/remote_repo_provider.dart';
import 'package:bookstagram/features/domain/usecases/usecase_verify_otp.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';

/// Provider for the signup use case
final verificationOtpProvider = Provider<UsecaseVerifyOtp>((ref) {
  final repository = ref.read(remoteRepositoryProvider);
  return UsecaseVerifyOtp(repository: repository);
});

/// StateNotifierProvider to handle signup logic and state
final stateVerifyCodeNotifierProvider = StateNotifierProvider<
    VerifySignUpNotifier, AsyncValue<VerificationOtpModel?>>((ref) {
  final signUp = ref.read(verificationOtpProvider);
  return VerifySignUpNotifier(signUp);
});

/// StateNotifier to handle login actions
class VerifySignUpNotifier
    extends StateNotifier<AsyncValue<VerificationOtpModel?>> {
  final UsecaseVerifyOtp _verifiyUseCase;

  VerifySignUpNotifier(this._verifiyUseCase)
      : super(const AsyncValue.data(null));

  Future<void> verificationSignupOtp(
      {required String email,
      required String otpCode,
      required void Function(VerificationOtpModel) onSuccess,
      required BuildContext context}) async {
    try {
      state = const AsyncValue.loading();
      final data = await _verifiyUseCase.call(email: email, otpCode: otpCode);

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
          txt: "Error Otp : $e",
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
