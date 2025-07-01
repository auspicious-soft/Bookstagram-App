import 'package:bookstagram/features/data/datasources/bookstagram_ds.dart';
import 'package:bookstagram/features/data/modules/auth_module/controller/otp_verification_Controller.dart';
import 'package:bookstagram/features/data/modules/auth_module/models/resendOtp_requestmodrl.dart';
import 'package:bookstagram/features/domain/usecases/usecase_change_pass.dart';
import 'package:bookstagram/features/domain/usecases/usecase_forgot_otp.dart';
import 'package:get/get.dart';
import 'package:bookstagram/features/domain/repositories/remote_repo.dart';
import 'package:bookstagram/features/domain/usecases/usecase_signup.dart';
import 'package:bookstagram/features/data/repositories/remote_ds_impl.dart';
import '../../../../domain/usecases/usecase_login.dart';
import '../../../../domain/usecases/usecase_verify_otp.dart';
import '../../../../presentation/providers/auth_google_service.dart';
import '../controller/signup_controller.dart';

class OtpVerificationBinding extends Bindings {
  @override
  void dependencies() {
    // Inject the RemoteDs and RemoteDsImpl
    Get.lazyPut<RemoteDs>(() => RemoteDs());  // Assuming RemoteDs is your data source class
    Get.lazyPut<RemoteRepo>(() => RemoteDsImpl(remoteDataSource: Get.find())); // RemoteDsImpl depends on RemoteDs
     Get.lazyPut<UsecaseVerifyOtp>(() => UsecaseVerifyOtp(repository: Get.find()));
    Get.lazyPut<UsecaseForgotOtp>(() => UsecaseForgotOtp(repository: Get.find()));
    Get.lazyPut<UsecaseResendOtp>(() => UsecaseResendOtp(repository: Get.find()));
    Get.lazyPut<UsecaseChangePass>(() => UsecaseChangePass(repository: Get.find()));
    Get.lazyPut<OtpVerificationController>(() => OtpVerificationController());

  }
}
