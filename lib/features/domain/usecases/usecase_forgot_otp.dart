import 'package:bookstagram/features/data/models/forgot_otp_model.dart';
import 'package:bookstagram/features/domain/repositories/remote_repo.dart';
import 'package:dartz/dartz.dart';

class UsecaseForgotOtp {
  final RemoteRepo repository;

  UsecaseForgotOtp({required this.repository});

  Future<Either<Failure, ForgotOtpModel>> call({
    required String otpCode,
  }) {
    return repository.forgotOtp(otpCode);
  }
}
