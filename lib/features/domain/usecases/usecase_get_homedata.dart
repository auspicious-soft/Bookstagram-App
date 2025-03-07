import 'package:bookstagram/features/data/models/homedata_model.dart';
import 'package:bookstagram/features/domain/repositories/remote_repo.dart';
import 'package:dartz/dartz.dart';

class UsecaseGetHomedata {
  final RemoteRepo repository;

  UsecaseGetHomedata({required this.repository});

  Future<Either<Failure, HomeDataModel>> call() {
    return repository.getHomeData();
  }
}
