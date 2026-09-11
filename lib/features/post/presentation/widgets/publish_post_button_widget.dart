import 'package:flutter/material.dart';
import 'package:wordspace/core/theme/app_theme.dart';

class PublishPostButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String text;

  const PublishPostButtonWidget({
    super.key,
    required this.onPressed,
    required this.isLoading,
    this.text = 'Publish Post',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryDark,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppTheme.primaryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    text == 'Save as Draft'
                        ? Icons.save_outlined
                        : Icons.send_outlined,
                    size: 21,
                  ),
                ],
              ),
      ),
    );
  }
}