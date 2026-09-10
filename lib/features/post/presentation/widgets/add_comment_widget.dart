import 'package:flutter/material.dart';
import 'package:wordspace/core/theme/app_theme.dart';

class AddCommentWidget extends StatefulWidget {
  final Function(String) onSend;
  final bool isLoading;

  const AddCommentWidget({
    super.key,
    required this.onSend,
    this.isLoading = false,
  });

  @override
  State<AddCommentWidget> createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void sendComment() {
    final text = controller.text.trim();

    if (text.isEmpty || widget.isLoading) {
      return;
    }

    widget.onSend(text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: !widget.isLoading,
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
          onPressed: widget.isLoading ? null : sendComment,
          icon: widget.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : const CircleAvatar(
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