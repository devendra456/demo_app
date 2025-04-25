import 'package:demo_app/features/home/data/req_models/user_req.dart';
import 'package:demo_app/features/home/domain/entities/user_entity.dart';
import 'package:demo_app/features/home/domain/use_cases/load_users_use_case.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class HomeController extends GetxController {
  final LoadUsersUseCase _loadUsersUseCase;

  // Observable variables
  final RxString selectedGender = ''.obs;

  // Pagination variables
  static const _pageSize = 20;
  bool dataLoading = false;

  // Paging controller
  late final PagingController<int, UserEntity> pagingController;

  final List<UserEntity> buffer = [];

  HomeController({required LoadUsersUseCase loadUsersUseCase})
    : _loadUsersUseCase = loadUsersUseCase;

  @override
  void onInit() {
    super.onInit();
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener(_fetchPage);

    // Listen to changes in filters and search to refresh the list
    ever(selectedGender, (_) => refreshUsers());
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      dataLoading = true;
      final req = UserReq(
        page: pageKey,
        results: _pageSize,
        gender: selectedGender.value.isEmpty ? null : selectedGender.value,
      );

      final result = await _loadUsersUseCase.call(req);
      dataLoading = false;
      result.fold(
        (l) {
          // errorMessage.value = l.message;
          pagingController.error = l.message;
        },
        (r) {
          final List<UserEntity> newUsers = r;
          final isLastPage = newUsers.length < _pageSize;

          if (isLastPage) {
            pagingController.appendLastPage(newUsers);
          } else {
            pagingController.appendPage(newUsers, pageKey + 1);
          }
          buffer.addAll(newUsers);
        },
      );
    } catch (e) {
      dataLoading = false;
      // errorMessage.value = 'An unexpected error occurred: $e';
      pagingController.error = e;
    }
  }

  // Apply local filters (search and sort)


  // Refresh the user list
  Future<void> refreshUsers() async {
    pagingController.refresh();
    buffer.clear();
  }

  // Set gender filter
  void setGenderFilter(String gender) {
    if (selectedGender.value != gender) {
      selectedGender.value = gender;
      refreshUsers();
    }
  }



  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
