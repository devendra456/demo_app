import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_app/features/home/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
            icon: Obx(
                  () =>
                  Icon(
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
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () => controller.pagingController.refresh(),
              ),
              child: PagedListView<int, UserEntity>(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<UserEntity>(
                  itemBuilder: (context, user, index) => _buildUserListItem(user),
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search by name',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 16,
          ),
        ),
        onChanged: controller.setSearchQuery,
      ),
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          const Text('Filter: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Obx(
                () =>
                FilterChip(
                  label: const Text('Male'),
                  selected: controller.selectedGender.value == 'male',
                  onSelected: (selected) => controller.setGenderFilter('male'),
                ),
          ),
          const SizedBox(width: 8),
          Obx(
                () =>
                FilterChip(
                  label: const Text('Female'),
                  selected: controller.selectedGender.value == 'female',
                  onSelected: (selected) =>
                      controller.setGenderFilter('female'),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsView() {
    return Center(
      child: Text('No results found for "${controller.searchQuery.value}"'),
    );
  }

  Widget _buildUserListItem(UserEntity user) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Hero(
          tag: 'avatar-${user.email}',
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(user.picture.thumbnail),
          ),
        ),
        title: Text(user.fullName),
        subtitle: Text(user.email),
        onTap: () => Get.to(() => UserDetailsView(user: user)),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Error: ${controller.errorMessage.value}',
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
