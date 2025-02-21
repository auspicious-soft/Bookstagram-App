import 'package:bookstagram/features/data/models/verification_otp_model.dart';
import 'package:bookstagram/features/domain/repositories/remote_repo.dart';
import 'package:dartz/dartz.dart';

class UsecaseVerifyOtp {
  final RemoteRepo repository;

  UsecaseVerifyOtp({required this.repository});

  Future<Either<Failure, VerificationOtpModel>> call({
    required String email,
    required String otpCode,
  }) {
    return repository.verifySignupOtp(email, otpCode);
  }
}
