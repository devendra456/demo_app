import 'package:demo_app/features/filter/bindings/filter_binding.dart';
import 'package:demo_app/features/filter/view/filter_screen.dart';
import 'package:get/get.dart';

import '../../features/home/presentation/bindings/home_binding.dart';
import '../../features/home/presentation/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.home;
  static const filter = Routes.filter;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.filter,
      page: () => const FilterScreen(),
      binding: FilterBinding(),
    ),
  ];
}