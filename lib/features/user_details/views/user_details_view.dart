import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_app/features/home/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserDetailsView extends StatelessWidget {
  final UserEntity user;

  const UserDetailsView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.fullName)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildProfileHeader(context), _buildInfoSection(context)],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Hero(
            tag: 'avatar-${user.email}',
            child: CircleAvatar(
              radius: 70,
              backgroundImage: CachedNetworkImageProvider(user.picture.large),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user.fullName,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user.email,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    // Format date of birth
    final DateTime dob = user.dob.date;
    final String formattedDob = DateFormat.yMMMMd().format(dob);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(context, 'Contact Information'),
          _buildInfoItem(context, Icons.phone, 'Phone', user.phone),
          _buildInfoItem(context, Icons.email, 'Email', user.email),

          const SizedBox(height: 24),
          _buildSectionTitle(context, 'Location'),
          _buildInfoItem(
            context,
            Icons.location_city,
            'Address',
            user.address,
          ),
          _buildInfoItem(context, Icons.map, 'State', user.state),
          _buildInfoItem(
            context,
            Icons.public,
            'Country',
            user.country,
          ),
          _buildInfoItem(
            context,
            Icons.markunread_mailbox,
            'Postcode',
            (user.postcode).toString(),
          ),

          const SizedBox(height: 24),
          _buildSectionTitle(context, 'Personal Information'),
          _buildInfoItem(
            context,
            Icons.cake,
            'Date of Birth',
            '$formattedDob (${user.dob.age} years)',
          ),
          _buildInfoItem(
            context,
            Icons.person,
            'Gender',
            user.gender.capitalizeFirst ?? "",
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(value, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
