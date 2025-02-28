import 'package:bookstagram/features/data/datasources/bookstagram_ds.dart';
import 'package:bookstagram/features/data/models/change_pass_model.dart';
import 'package:bookstagram/features/data/models/forgot_email_model.dart';
import 'package:bookstagram/features/data/models/forgot_otp_model.dart';
import 'package:bookstagram/features/data/models/login_model.dart';
import 'package:bookstagram/features/data/models/signup_model.dart';
import 'package:bookstagram/features/data/models/verification_otp_model.dart';
import 'package:bookstagram/features/domain/repositories/remote_repo.dart';
import 'package:dartz/dartz.dart';

class RemoteDsImpl implements RemoteRepo {
  final RemoteDs remoteDataSource;

  RemoteDsImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LoginModel>> login(String email, String pass,
      String phoneNumber, String language, String authType) async {
    try {
      final loginData = await remoteDataSource.loginToBookstagram(
          email: email,
          pass: pass,
          phoneNumber: phoneNumber,
          language: language,
          authType: authType);
      if (loginData != null) {
        return Right(loginData);
      }
      //  print("return from here");
      return Left(SomeSpecificError("Unable to fetch"));
    } catch (error) {
      print("return ok from here ${error.toString()}");
      return Left(SomeSpecificError(error.toString()));
    }
  }

  @override
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
  ) async {
    try {
      final signUpData = await remoteDataSource.signUpToBookstagram(
          email: email,
          countryCode: countryCode,
          phoneNumber: phoneNumber,
          fullname: fullname,
          firstname: firstname,
          lastname: lastname,
          pass: pass,
          language: language,
          authType: authType);
      if (signUpData != null) {
        return Right(signUpData);
      }
      //  print("return from here");
      return Left(SomeSpecificError("Unable to fetch"));
    } catch (error) {
      print("return ok from here ${error.toString()}");
      return Left(SomeSpecificError(error.toString()));
    }
  }

  @override
  Future<Either<Failure, VerificationOtpModel>> verifySignupOtp(
      String email, String otpCode) async {
    try {
      final otpData = await remoteDataSource.verifySignupOtp(
          email: email, otpCode: otpCode);
      if (otpData != null) {
        return Right(otpData);
      }
      //  print("return from here");
      return Left(SomeSpecificError("Unable to fetch"));
    } catch (error) {
      print("return ok from here ${error.toString()}");
      return Left(SomeSpecificError(error.toString()));
    }
  }

  @override
  Future<Either<Failure, ForgotEmailModel>> forgotEmail(String email) async {
    try {
      final forgotData = await remoteDataSource.forgotEmail(email: email);
      if (forgotData != null) {
        return Right(forgotData);
      }
      //  print("return from here");
      return Left(SomeSpecificError("Unable to fetch"));
    } catch (error) {
      print("return ok from here ${error.toString()}");
      return Left(SomeSpecificError(error.toString()));
    }
  }

  @override
  Future<Either<Failure, ForgotOtpModel>> forgotOtp(String otpCode) async {
    try {
      final forgotData = await remoteDataSource.forgotOtp(otpCode: otpCode);
      if (forgotData != null) {
        return Right(forgotData);
      }
      //  print("return from here");
      return Left(SomeSpecificError("Unable to fetch"));
    } catch (error) {
      print("return ok from here ${error.toString()}");
      return Left(SomeSpecificError(error.toString()));
    }
  }

  @override
  Future<Either<Failure, ChangePassModel>> changePass(
      String password, String otpCode) async {
    try {
      final forgotData = await remoteDataSource.changePassword(
          password: password, otpCode: otpCode);
      if (forgotData != null) {
        return Right(forgotData);
      }
      //  print("return from here");
      return Left(SomeSpecificError("Unable to fetch"));
    } catch (error) {
      print("return ok from here ${error.toString()}");
      return Left(SomeSpecificError(error.toString()));
    }
  }
}
