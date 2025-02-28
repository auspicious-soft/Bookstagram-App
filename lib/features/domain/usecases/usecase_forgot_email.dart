import 'package:bookstagram/features/data/models/forgot_email_model.dart';
import 'package:bookstagram/features/domain/repositories/remote_repo.dart';
import 'package:dartz/dartz.dart';

class UsecaseForgotEmail {
  final RemoteRepo repository;

  UsecaseForgotEmail({required this.repository});

  Future<Either<Failure, ForgotEmailModel>> call({
    required String email,
  }) {
    return repository.forgotEmail(email);
  }
}
