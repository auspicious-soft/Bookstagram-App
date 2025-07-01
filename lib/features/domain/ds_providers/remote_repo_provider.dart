import 'package:bookstagram/features/data/datasources/bookstagram_ds.dart';
import 'package:bookstagram/features/data/repositories/remote_ds_impl.dart';
import 'package:bookstagram/features/domain/repositories/remote_repo.dart';
import 'package:get/get.dart';

class RemoteBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDs>(() => RemoteDs());
    Get.lazyPut<RemoteRepo>(() => RemoteDsImpl(
      remoteDataSource: Get.find<RemoteDs>(),
    ));
  }
}

// Usage:
// In your main.dart or wherever you initialize your dependencies:
// Get.put(RemoteBindings()).dependencies();