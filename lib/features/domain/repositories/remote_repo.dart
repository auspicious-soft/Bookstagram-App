import 'package:bookstagram/features/data/models/change_pass_model.dart';
import 'package:bookstagram/features/data/models/forgot_email_model.dart';
import 'package:bookstagram/features/data/models/forgot_otp_model.dart';
import 'package:bookstagram/features/data/models/homedata_model.dart';
import 'package:bookstagram/features/data/models/login_model.dart';
import 'package:bookstagram/features/data/models/signup_model.dart';
import 'package:bookstagram/features/data/models/verification_otp_model.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/otp_resend_model.dart';

abstract class RemoteRepo {
  Future<Either<Failure, LoginModel>> login(
    String email,
    String pass,
    String phoneNumber,
    String language,
    String authType,
    String fullName,
    String profilePic,
    String fcmToken,
    String? appleToken,
  );

  // Future<Either<Failure, SignUpModel>> signUp(
  //   String email,
  //   String countryCode,
  //   String phoneNumber,
  //   String fullname,
  //   String firstname,
  //   String lastname,
  //   String pass,
  //   String language,
  //   String authType,
  // );
  Future<Either<Failure, VerificationOtpModel>> verifySignupOtp(
    String email,
    String otpCode,
  );

  Future<Either<Failure, ForgotEmailModel>> forgotEmail(
    String email,
  );

  Future<Either<Failure, resendModal>> resendOtp(
    String email,
  );

  Future<Either<Failure, ForgotOtpModel>> forgotOtp(
    String otpCode,
  );

  Future<Either<Failure, ChangePassModel>> changePass(
      String password, String otpCode);

  Future<Either<Failure, HomeDataModel>> getHomeData();
}

abstract class Failure {
  final String message;

  Failure(this.message);
}

class SomeSpecificError extends Failure {
  SomeSpecificError(super.message);
}
