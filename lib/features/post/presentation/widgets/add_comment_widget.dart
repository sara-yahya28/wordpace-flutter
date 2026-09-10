import 'package:flutter/material.dart';
import 'package:wordspace/core/theme/app_theme.dart';

class AddCommentWidget extends StatelessWidget {
  const AddCommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppTheme.primaryDark,
          ),
        ),
        hintText: 'Add a comment...',
        hintStyle: const TextStyle(
          color: AppTheme.primaryLight,
          fontSize: 13,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            // سيتم ربطه بالـ API لاحقًا
          },
          icon: const CircleAvatar(
            backgroundColor: AppTheme.primaryDark,
            child: Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      maxLines: 1,
    );
  }
}
