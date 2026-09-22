import 'package:flutter/material.dart';
import 'package:wordspace/core/theme/app_theme.dart';

class CommentItemWidget extends StatelessWidget {
  final String username;
  final String time;
  final String comment;
  final bool canDelete;
  final VoidCallback? onDelete;
  final bool isDeleting;

  const CommentItemWidget({
    super.key,
    required this.username,
    required this.time,
    required this.comment,
    this.canDelete = false,
    this.onDelete,
    this.isDeleting = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: AppTheme.primaryDark,
          child: Text(
            username.isNotEmpty ? username[0].toUpperCase() : '?',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  if (canDelete)
                    isDeleting
                        ? const SizedBox(
                            width: 19,
                            height: 19,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : IconButton(
                            onPressed: onDelete,
                            icon: const Icon(
                              Icons.delete_outline,
                              size: 19,
                            ),
                            color: Colors.redAccent,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            tooltip: 'Delete comment',
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
