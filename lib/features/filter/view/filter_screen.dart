import 'package:demo_app/features/filter/controller/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/widgets/user_list_item.dart';

class FilterScreen extends GetView<FilterController> {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchBar(),
        titleSpacing: 0,
        actions: [
          IconButton(
            icon: Obx(
              () => Icon(
                controller.sortOrder.value == SortOrder.ascending
                    ? Icons.arrow_upward
                    : controller.sortOrder.value == SortOrder.descending
                    ? Icons.arrow_downward
                    : Icons.sort,
              ),
            ),
            onPressed: controller.toggleSortOrder,
            tooltip: 'Sort by name',
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemBuilder: (context, index) {
            final user = controller.userList[index];
            return UserListItem(user: user);
          },
          itemCount: controller.userList.length,
        );
      }),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search by name',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      ),
      onChanged: controller.setSearchQuery,
    );
  }
}
