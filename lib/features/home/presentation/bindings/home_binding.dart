import 'package:demo_app/features/home/domain/repos/home_repo.dart';
import 'package:demo_app/features/home/domain/use_cases/load_users_use_case.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        loadUsersUseCase: LoadUsersUseCase(homeRepo: Get.find<HomeRepo>()),
      ),
    );
  }
}
