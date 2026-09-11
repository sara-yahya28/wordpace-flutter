import 'package:flutter/material.dart';

class AddPostContentFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final int characterCount;
final ValueChanged<String>? onChanged;

  const AddPostContentFieldWidget({
    super.key,
    required this.controller,
    required this.characterCount, 
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          maxLength: 1000,
          onChanged: onChanged,
          minLines: 6,
          maxLines: 6,
          decoration: const InputDecoration(
            hintText: 'Write your post here...',
            counterText: '',
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '$characterCount/1000',
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}