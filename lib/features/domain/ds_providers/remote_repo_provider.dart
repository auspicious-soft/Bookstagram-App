import 'package:bookstagram/features/data/datasources/bookstagram_ds.dart';
import 'package:bookstagram/features/data/repositories/remote_ds_impl.dart';
import 'package:bookstagram/features/domain/repositories/remote_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final remoteDataSourceProvider = Provider<RemoteDs>((ref) {
  return RemoteDs();
});

final remoteRepositoryProvider = Provider<RemoteRepo>((ref) {
  // final localDataSource = ref.read(remoteDataSourceProvider);
  final remoteDataSource = ref.read(remoteDataSourceProvider);
  return RemoteDsImpl(

      // localDataSource: localDataSource,

      remoteDataSource: remoteDataSource);
});
