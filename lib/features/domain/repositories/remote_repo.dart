import 'package:bookstagram/features/data/models/login_model.dart';
import 'package:bookstagram/features/data/models/signup_model.dart';
import 'package:bookstagram/features/data/models/verification_otp_model.dart';
import 'package:dartz/dartz.dart';

abstract class RemoteRepo {
  Future<Either<Failure, LoginModel>> login(String email, String pass,
      String phoneNumber, String language, String authType);
  Future<Either<Failure, SignUpModel>> signUp(
    String email,
    String countryCode,
    String phoneNumber,
    String fullname,
    String firstname,
    String lastname,
    String pass,
    String language,
    String authType,
  );
  Future<Either<Failure, VerificationOtpModel>> verifySignupOtp(
    String email,
    String otpCode,
  );
}

abstract class Failure {
  final String message;

  Failure(this.message);
}

class SomeSpecificError extends Failure {
  SomeSpecificError(super.message);
}
