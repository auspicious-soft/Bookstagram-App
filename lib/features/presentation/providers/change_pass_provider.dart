import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/features/data/models/change_pass_model.dart';
import 'package:bookstagram/features/domain/ds_providers/remote_repo_provider.dart';
import 'package:bookstagram/features/domain/usecases/usecase_change_pass.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';

/// Provider for the signup use case
final changePassProvider = Provider<UsecaseChangePass>((ref) {
  final repository = ref.read(remoteRepositoryProvider);
  return UsecaseChangePass(repository: repository);
});

/// StateNotifierProvider to handle signup logic and state
final stateChangePassProvider =
    StateNotifierProvider<ChangePassNotifier, AsyncValue<ChangePassModel?>>(
        (ref) {
  final changePass = ref.read(changePassProvider);
  return ChangePassNotifier(changePass);
});

/// StateNotifier to handle login actions
class ChangePassNotifier extends StateNotifier<AsyncValue<ChangePassModel?>> {
  final UsecaseChangePass _changePassUseCase;

  ChangePassNotifier(this._changePassUseCase)
      : super(const AsyncValue.data(null));

  Future<void> changePassword(
      {required String password,
      required String otpCode,
      required void Function(ChangePassModel) onSuccess,
      required BuildContext context}) async {
    try {
      state = const AsyncValue.loading();
      final data =
          await _changePassUseCase.call(password: password, otpCode: otpCode);

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
