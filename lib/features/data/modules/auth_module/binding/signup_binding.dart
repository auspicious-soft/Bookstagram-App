import 'package:bookstagram/features/data/datasources/bookstagram_ds.dart';
import 'package:get/get.dart';
import 'package:bookstagram/features/domain/repositories/remote_repo.dart';
import 'package:bookstagram/features/domain/usecases/usecase_signup.dart';
import 'package:bookstagram/features/data/repositories/remote_ds_impl.dart';
import '../../../../domain/usecases/usecase_login.dart';
import '../../../../presentation/providers/auth_google_service.dart';
import '../controller/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    // Inject the RemoteDs and RemoteDsImpl
    Get.lazyPut<RemoteDs>(() => RemoteDs());  // Assuming RemoteDs is your data source class
    Get.lazyPut<RemoteRepo>(() => RemoteDsImpl(remoteDataSource: Get.find())); // RemoteDsImpl depends on RemoteDs
    // Get.lazyPut<UsecaseSignup>(() => UsecaseSignup(repository: Get.find()));
    Get.lazyPut<SignUpController>(() => SignUpController());
    Get.lazyPut<UsecaseLogin>(() => UsecaseLogin(repository: Get.find()));  // Inject RemoteRepo into UsecaseLogin

    Get.lazyPut(()=>AuthGoogleService());
    // Make sure SignUpController takes UsecaseSignup in constructor
  }
}
