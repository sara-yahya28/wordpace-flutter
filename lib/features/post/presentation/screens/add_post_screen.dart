import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/features/post/presentation/cubit/post_cubit.dart';
import 'package:wordspace/features/post/presentation/cubit/post_state.dart';
import 'package:wordspace/features/post/presentation/widgets/add_post_content_field_widget.dart';
import 'package:wordspace/features/post/presentation/widgets/add_post_status_option_widget.dart';
import 'package:wordspace/features/post/presentation/widgets/add_post_title_field_widget.dart';
import 'package:wordspace/features/post/presentation/widgets/publish_post_button_widget.dart';

class AddPostScreen extends StatefulWidget {
  final VoidCallback onPostAdded;

  const AddPostScreen({
    super.key,
    required this.onPostAdded,
  });

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  String selectedStatus = 'published';

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<PostCubit, PostState>(
        listener: (context, state) {
          if (state is PostAdded) {
            titleController.clear();
            contentController.clear();

            setState(() {
              selectedStatus = 'published';
            });

            widget.onPostAdded();
          }

          if (state is PostAddFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          final isAdding = state is PostAdding;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title *',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 8),

                AddPostTitleFieldWidget(
                  controller: titleController,
                  characterCount: titleController.text.length,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),

                const SizedBox(height: 24),

                Text(
                  'Content *',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 8),

                AddPostContentFieldWidget(
                  controller: contentController,
                  characterCount: contentController.text.length,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),

                const SizedBox(height: 24),

                Text(
                  'Status',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 10),

                AddPostStatusOptionWidget(
                  value: 'published',
                  groupValue: selectedStatus,
                  title: 'Publish',
                  subtitle: 'Make your post visible to everyone',
                  icon: Icons.send_outlined,
                  isDisabled: isAdding,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                ),

                AddPostStatusOptionWidget(
                  value: 'draft',
                  groupValue: selectedStatus,
                  title: 'Save as Draft',
                  subtitle: 'Keep it for later',
                  icon: Icons.save_outlined,
                  isDisabled: isAdding,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                ),

                const SizedBox(height: 12),

                PublishPostButtonWidget(
                  isLoading: isAdding,
                  text: selectedStatus == 'draft'
                      ? 'Save as Draft'
                      : 'Publish Post',
                  onPressed: () {
                    context.read<PostCubit>().addPost(
                          title: titleController.text.trim(),
                          body: contentController.text.trim(),
                          status: selectedStatus,
                        );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}