import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_app/features/home/domain/repos/home_repo.dart';
import 'package:get/get.dart';

import '../../features/home/data/repos/home_repo_impl.dart';
import 'network/network_info.dart';

void setupDI() {
  Get.lazyPut<Connectivity>(() => Connectivity());
  Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(Get.find<Connectivity>()));
  Get.lazyPut<HomeRepo>(
    () => HomeRepoImpl(networkInfo: Get.find<NetworkInfo>()),
  );
}
