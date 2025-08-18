import 'package:bookstagram/features/data/models/login_model.dart';
import 'package:bookstagram/features/domain/repositories/remote_repo.dart';
import 'package:dartz/dartz.dart';

class UsecaseLogin {
  final RemoteRepo repository;

  UsecaseLogin({required this.repository});

  Future<Either<Failure, LoginModel>> call(
      {required String email,
      required String pass,
      required String fullName,
      required String profilePic,
      required String phoneNumber,
      required String language,
      required String authType}) {
    return repository.login(
        email, pass, phoneNumber, language, authType, fullName, profilePic);
  }
}
