import 'package:flutter/material.dart';

class AddPostTitleFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final int characterCount;
  final ValueChanged<String>? onChanged;

  const AddPostTitleFieldWidget({
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
          maxLength: 100,
          onChanged: onChanged,
          decoration: const InputDecoration(
            hintText: 'Enter your post title',
            counterText: '',
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '$characterCount/100',
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
