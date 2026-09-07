import 'package:flutter/material.dart';
import 'package:wordspace/core/theme/app_theme.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String email;

  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: AppTheme.primaryColor,
          child: Text(
            name.isNotEmpty ? name[0].toUpperCase() : 'U',
            style: const TextStyle(
              fontSize: 32,
              color: AppTheme.backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            color: AppTheme.primaryDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          email,
          style: const TextStyle(
            color: AppTheme.primaryLight,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}