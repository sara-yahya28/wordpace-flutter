import 'package:flutter/material.dart';
import 'package:wordspace/core/theme/app_theme.dart';

class CommentItemWidget extends StatelessWidget {
  final String username;
  final String time;
  final String comment;
  final int likes;

  const CommentItemWidget({
    super.key,
    required this.username,
    required this.time,
    required this.comment,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User avatar
        CircleAvatar(
          radius: 18,
          backgroundColor: AppTheme.primaryDark,
          child: Text(
            username.isNotEmpty
                ? username[0].toUpperCase()
                : '?',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Comment content
Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Username + time
      Row(
        children: [
          Text(
            username,
            style: const TextStyle(
              color: AppTheme.primaryDark,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 8),

          Text(
            time,
            style: const TextStyle(
              color: AppTheme.primaryLight,
              fontSize: 11,
            ),
          ),
        ],
      ),

      const SizedBox(height: 4),

      // Comment + Like
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              comment,
              style: const TextStyle(
                color: AppTheme.primaryMedium,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(width: 8),

          Icon(
            Icons.favorite_border,
            color: AppTheme.primaryLight,
            size: 16,
          ),

          const SizedBox(width: 3),

          Text(
            '$likes',
            style: const TextStyle(
              color: AppTheme.primaryLight,
              fontSize: 11,
            ),
          ),
        ],
      ),
    ],
  ),
),
      ],
    );
  }
}