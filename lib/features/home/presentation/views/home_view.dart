import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_app/app/helpers/snackbar_helper.dart';
import 'package:demo_app/app/routes/app_pages.dart';
import 'package:demo_app/features/home/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../app/widgets/user_list_item.dart';
import '../../../user_details/views/user_details_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Users'),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.filter, arguments: controller.buffer);
            },
            icon: Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          _buildFilterChips(),
          Divider(),
          Expanded(
            child: RefreshIndicator(
              onRefresh:
                  () => Future.sync(() {
                    controller.pagingController.refresh();
                    controller.buffer.clear();
                  }),
              child: PagedListView<int, UserEntity>(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<UserEntity>(
                  itemBuilder:
                      (context, user, index) => UserListItem(user: user),
                  firstPageErrorIndicatorBuilder: (_) => _buildErrorView(),
                  noItemsFoundIndicatorBuilder: (_) => _buildEmptyView(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Obx(
            () => FilterChip(
              label: const Text('All'),
              selected: controller.selectedGender.value == '',
              onSelected: (selected) {
                if (controller.dataLoading) {
                  SnackBarHelper.showSnackBar(
                    "Please wait for the data to load",
                  );
                } else {
                  controller.setGenderFilter('');
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          Obx(
            () => FilterChip(
              label: const Text('Male'),
              selected: controller.selectedGender.value == 'male',
              onSelected: (selected) {
                if (controller.dataLoading) {
                  SnackBarHelper.showSnackBar(
                    "Please wait for the data to load",
                  );
                } else {
                  controller.setGenderFilter('male');
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          Obx(
            () => FilterChip(
              label: const Text('Female'),
              selected: controller.selectedGender.value == 'female',
              onSelected: (selected) {
                if (controller.dataLoading) {
                  SnackBarHelper.showSnackBar(
                    "Please wait for the data to load",
                  );
                } else {
                  controller.setGenderFilter('female');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Error: ${controller.pagingController.error}',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: controller.refreshUsers,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_off, size: 48, color: Colors.grey),
          SizedBox(height: 16),
          Text('No users found'),
        ],
      ),
    );
  }
}
