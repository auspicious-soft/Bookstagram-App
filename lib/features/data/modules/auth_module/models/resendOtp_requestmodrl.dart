import 'package:bookstagram/features/data/models/verification_otp_model.dart';
import 'package:bookstagram/features/domain/repositories/remote_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../models/forgot_email_model.dart';
import '../../../models/otp_resend_model.dart';

class UsecaseResendOtp {
  final RemoteRepo repository;

  UsecaseResendOtp({required this.repository});

  Future<Either<Failure, resendModal>> call({
    required String email,
  }) {
    return repository.resendOtp(email);
  }
}
