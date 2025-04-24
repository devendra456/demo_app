import 'package:demo_app/features/home/data/req_models/user_req.dart';
import 'package:demo_app/features/home/domain/entities/user_entity.dart';
import 'package:demo_app/features/home/domain/use_cases/load_users_use_case.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

enum SortOrder { ascending, descending, none }

class HomeController extends GetxController {
  final LoadUsersUseCase _loadUsersUseCase;

  // Observable variables
  final RxString selectedGender = ''.obs;
  final RxString searchQuery = ''.obs;
  final Rx<SortOrder> sortOrder = SortOrder.none.obs;
  final RxString errorMessage = ''.obs;

  // Pagination variables
  static const _pageSize = 20;
  
  // Paging controller
  late final PagingController<int, UserEntity> pagingController;

  HomeController({required LoadUsersUseCase loadUsersUseCase})
    : _loadUsersUseCase = loadUsersUseCase;

  @override
  void onInit() {
    super.onInit();
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener(_fetchPage);

    // Listen to changes in filters and search to refresh the list
    ever(selectedGender, (_) => _refreshList());
    ever(searchQuery, (_) => _applyLocalFilters());
    ever(sortOrder, (_) => _applyLocalFilters());
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final req = UserReq(
        page: pageKey,
        results: _pageSize,
        gender: selectedGender.value.isEmpty ? null : selectedGender.value,
      );

      final result = await _loadUsersUseCase.call(req);

      result.fold(
        (l) {
          errorMessage.value = l.message;
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
        },
      );
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred: $e';
      pagingController.error = e;
    }
  }

  // Refresh the list when filters change
  void _refreshList() {
    pagingController.refresh();
  }

  // Apply local filters (search and sort)
  void _applyLocalFilters() {
    final currentItems = pagingController.itemList ?? [];
    if (currentItems.isEmpty) return;

    List<UserEntity> filteredItems = List.from(currentItems);

    // Apply search filter
    if (searchQuery.value.isNotEmpty) {
      filteredItems = filteredItems
          .where((user) => user.matchesSearch(searchQuery.value))
          .toList();
    }

    // Apply sorting
    if (sortOrder.value != SortOrder.none) {
      filteredItems.sort((a, b) {
        int comparison = a.fullName.compareTo(b.fullName);
        return sortOrder.value == SortOrder.ascending
            ? comparison
            : -comparison;
      });
    }

    // Update the paging controller with filtered items
    pagingController.itemList = filteredItems;
  }

  // Refresh the user list
  Future<void> refreshUsers() async {
    pagingController.refresh();
  }

  // Set gender filter
  void setGenderFilter(String gender) {
    if (selectedGender.value == gender) {
      selectedGender.value = ''; // Clear filter if same gender is selected
    } else {
      selectedGender.value = gender;
    }
    refreshUsers(); // Refresh to get filtered results from API
  }

  // Set search query
  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Toggle sort order
  void toggleSortOrder() {
    if (sortOrder.value == SortOrder.none ||
        sortOrder.value == SortOrder.descending) {
      sortOrder.value = SortOrder.ascending;
    } else {
      sortOrder.value = SortOrder.descending;
    }
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
