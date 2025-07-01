import 'package:bookstagram/features/data/modules/home_module/controller/profile_controller.dart';
import 'package:bookstagram/features/data/modules/home_module/controller/searchcontroller.dart';
import 'package:bookstagram/features/data/modules/home_module/view/aboutus_screen.dart';
import 'package:bookstagram/features/domain/usecases/usecase_get_homedata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/repositories/remote_repo.dart';
import '../../../datasources/bookstagram_ds.dart';
import '../../../repositories/remote_ds_impl.dart';
import '../controller/dashboard_controller.dart';
import '../controller/tabhome_controller.dart';


class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeDataController>(() => HomeDataController());
    Get.lazyPut<TabSearchController>(() => TabSearchController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<AboutUsController>(() => AboutUsController());
    Get.lazyPut<RemoteDs>(() => RemoteDs());  // Assuming RemoteDs is your data source class
    Get.lazyPut<RemoteRepo>(() => RemoteDsImpl(remoteDataSource: Get.find())); // RemoteDsImpl depends on RemoteDs
    Get.lazyPut<UsecaseGetHomedata>(() => UsecaseGetHomedata(repository: Get.find()));



  }
}
