import 'package:flutter/material.dart';
import 'package:wordspace/core/theme/app_theme.dart';

class CustomSnackBar {
  static SnackBar success({
    required String message,
  }) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.greenAccent,
          ),
          const SizedBox(width: 10),
          Text(message),
        ],
      ),
      backgroundColor: AppTheme.primaryDark,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      duration: const Duration(seconds: 2),
    );
  }
}