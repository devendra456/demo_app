import 'package:demo_app/features/filter/controller/filter_controller.dart';
import 'package:get/get.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterController>(() => FilterController());
  }
}
