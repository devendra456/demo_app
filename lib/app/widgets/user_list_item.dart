import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/home/domain/entities/user_entity.dart';
import '../../features/user_details/views/user_details_view.dart';

class UserListItem extends StatelessWidget {
  final UserEntity user;

  const UserListItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
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
}
