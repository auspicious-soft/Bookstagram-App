import 'package:bookstagram/app_settings/components/label.dart';
import 'package:bookstagram/app_settings/constants/app_colors.dart';
import 'package:bookstagram/features/data/models/homedata_model.dart';
import 'package:bookstagram/features/domain/ds_providers/remote_repo_provider.dart';
import 'package:bookstagram/features/domain/usecases/usecase_get_homedata.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';

/// Provider for the login use case
final getHomeProvider = Provider<UsecaseGetHomedata>((ref) {
  final repository = ref.read(remoteRepositoryProvider);
  return UsecaseGetHomedata(repository: repository);
});

/// StateNotifierProvider to handle login logic and state
final stateHomeDataNotfierProvider =
    StateNotifierProvider<GetHomeNotifier, AsyncValue<HomeDataModel?>>((ref) {
  final getPlan = ref.read(getHomeProvider);
  return GetHomeNotifier(getPlan);
});

class GetHomeNotifier extends StateNotifier<AsyncValue<HomeDataModel?>> {
  final UsecaseGetHomedata _homeUseCase;

  GetHomeNotifier(this._homeUseCase) : super(const AsyncValue.data(null));

  Future<void> getHomeData({required BuildContext context}) async {
    state = const AsyncValue.loading();

    try {
      state = const AsyncValue.loading();
      final data = await _homeUseCase.call();
      data!.fold((error) {
        state = AsyncValue.error(
            error, StackTrace.fromString("Failed to fetch weather"));
      }, (fineData) {
        state = AsyncData(fineData);
      });
    } catch (e) {
      print(e);
      MotionToast.error(
        title: const Label(
          txt: "Error",
          type: TextTypes.f_15_500,
          forceColor: AppColors.whiteColor,
        ),
        description: Label(
          txt: "Error: $e",
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
