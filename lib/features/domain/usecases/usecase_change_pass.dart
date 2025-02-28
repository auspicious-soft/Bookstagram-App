import 'package:bookstagram/features/data/models/change_pass_model.dart';
import 'package:bookstagram/features/domain/repositories/remote_repo.dart';
import 'package:dartz/dartz.dart';

class UsecaseChangePass {
  final RemoteRepo repository;

  UsecaseChangePass({required this.repository});

  Future<Either<Failure, ChangePassModel>> call(
      {required String password, required String otpCode}) {
    return repository.changePass(password, otpCode);
  }
}
