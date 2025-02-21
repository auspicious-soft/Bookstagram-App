import 'package:bookstagram/features/data/models/signup_model.dart';
import 'package:bookstagram/features/domain/repositories/remote_repo.dart';
import 'package:dartz/dartz.dart';

class UsecaseSignup {
  final RemoteRepo repository;

  UsecaseSignup({required this.repository});

  Future<Either<Failure, SignUpModel>> call({
    required String email,
    required String countryCode,
    required String phoneNumber,
    required String fullname,
    required String firstname,
    required String lastname,
    required String pass,
    required String language,
    required String authType,
  }) {
    return repository.signUp(email, countryCode, phoneNumber, fullname,
        firstname, lastname, pass, language, authType);
  }
}
