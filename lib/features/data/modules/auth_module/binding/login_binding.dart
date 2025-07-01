import 'package:bookstagram/features/domain/usecases/usecase_forgot_email.dart';
import 'package:get/get.dart';
import 'package:bookstagram/features/domain/usecases/usecase_login.dart';
import 'package:bookstagram/features/domain/ds_providers/remote_repo_provider.dart';

import '../../../../domain/repositories/remote_repo.dart';
import '../../../../presentation/providers/auth_google_service.dart';
import '../../../datasources/bookstagram_ds.dart';
import '../../../repositories/remote_ds_impl.dart';
import '../controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDs>(() => RemoteDs());  // Assuming RemoteDs is your data source class
    Get.lazyPut<RemoteRepo>(() => RemoteDsImpl(remoteDataSource: Get.find())); // RemoteDsImpl depends on RemoteDs

    // Create and inject the UseCase
    final loginUseCase = Get.put(UsecaseLogin(repository:  Get.find()));

    Get.lazyPut<UsecaseForgotEmail>(() => UsecaseForgotEmail(repository: Get.find()),fenix: true);  // Inject RemoteRepo into UsecaseLogin
    Get.lazyPut(()=>AuthGoogleService());
    Get.put(LoginController(loginUseCase: loginUseCase));
  }
}