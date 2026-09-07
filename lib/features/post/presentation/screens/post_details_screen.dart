import 'package:flutter/material.dart';
import 'package:wordspace/features/post/presentation/widgets/add_comment_widget.dart';
import 'package:wordspace/features/post/presentation/widgets/comment_item_widget.dart';
import 'package:wordspace/features/post/presentation/widgets/post_details_widget.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
          automaticallyImplyLeading: true,   
             ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostDetailsWidget(
                username: 'Ahmed',
                time: '2h ago',
                title: 'The Power of Consistency',
                content:
                    'Consistency is one of the most important habits for success. '
                    'It might not always feel exciting, but it builds real progress '
                    'over time.\n\n'
                    'Small, consistent actions lead to big results. Keep going!',
                likes: 12,
                comments: 4,
                isLiked: false,
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.grey),
              const SizedBox(height: 24),
              const Text(
                'Comments (4)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              CommentItemWidget(
                username: 'Omar',
                time: '45m ago',
                comment: 'Very inspiring! Thanks for sharing.',
                likes: 1,
              ),
              const SizedBox(height: 18),
              CommentItemWidget(
                username: 'Sara',
                time: '1h ago',
                comment: 'Great post! Totally agree with you.',
                likes: 2,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomSheet: const Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 35),
        child: AddCommentWidget(),
      ),
    );
  }
}
