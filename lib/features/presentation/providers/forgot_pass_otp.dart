import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/features/data/models/forgot_otp_model.dart';
import 'package:bookstagram/features/domain/ds_providers/remote_repo_provider.dart';
import 'package:bookstagram/features/domain/usecases/usecase_forgot_otp.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';

/// Provider for the signup use case
final forgotOtpProvider = Provider<UsecaseForgotOtp>((ref) {
  final repository = ref.read(remoteRepositoryProvider);
  return UsecaseForgotOtp(repository: repository);
});

/// StateNotifierProvider to handle signup logic and state
final stateForgotCodeNotifierProvider =
    StateNotifierProvider<ForgotOtpNotifier, AsyncValue<ForgotOtpModel?>>(
        (ref) {
  final forgotOtp = ref.read(forgotOtpProvider);
  return ForgotOtpNotifier(forgotOtp);
});

/// StateNotifier to handle login actions
class ForgotOtpNotifier extends StateNotifier<AsyncValue<ForgotOtpModel?>> {
  final UsecaseForgotOtp _forgotOtpUseCase;

  ForgotOtpNotifier(this._forgotOtpUseCase)
      : super(const AsyncValue.data(null));

  Future<void> forgotOtp(
      {required String otpCode,
      required void Function(ForgotOtpModel) onSuccess,
      required BuildContext context}) async {
    try {
      state = const AsyncValue.loading();
      final data = await _forgotOtpUseCase.call(otpCode: otpCode);

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
