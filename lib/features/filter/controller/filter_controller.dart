import 'package:get/get.dart';

import '../../home/domain/entities/user_entity.dart';

enum SortOrder { ascending, descending, none }

class FilterController extends GetxController {
  final RxString searchQuery = ''.obs;
  final Rx<SortOrder> sortOrder = SortOrder.none.obs;
  final RxList<UserEntity> userList = <UserEntity>[].obs;
  final RxList<UserEntity> bufferedList = <UserEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    bufferedList.value = Get.arguments as List<UserEntity>;
    userList.value = bufferedList;
    ever(searchQuery, (_) => _applyLocalFilters());
    ever(sortOrder, (_) => _applyLocalFilters());
  }

  // Set search query
  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void _applyLocalFilters() {
    List<UserEntity> filteredItems = List.of(bufferedList);

    // Apply search filter
    if (searchQuery.value.isNotEmpty) {
      filteredItems =
          filteredItems
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

    userList.value = filteredItems;
  }

  // Toggle sort order
  void toggleSortOrder() {
    if (sortOrder.value == SortOrder.none) {
      sortOrder.value = SortOrder.ascending;
    } else if (sortOrder.value == SortOrder.ascending) {
      sortOrder.value = SortOrder.descending;
    } else {
      sortOrder.value = SortOrder.none;
    }
  }
}
