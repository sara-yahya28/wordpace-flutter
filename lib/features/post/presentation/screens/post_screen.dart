import 'package:flutter/material.dart';
import 'package:wordspace/features/post/presentation/widgets/post_card_widget.dart';
import 'package:wordspace/core/theme/app_theme.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = [

  {
    'username': 'Sara',
    'time': '5h ago',
    'title': 'Learning Flutter',
    'content':
        'Flutter is an amazing framework for building beautiful applications. I am currently learning how to create clean and organized interfaces.',
    'likes': 18,
    'comments': 4,
    'isLiked': true,
  },
  {
    'username': 'Mohammed',
    'time': '1d ago',
    'title': 'A Simple Reminder',
    'content':
        'Do not compare your beginning to someone else’s middle. Keep learning, keep improving, and enjoy the journey.',
    'likes': 31,
    'comments': 9,
    'isLiked': false,
  },

  {
    'username': 'Omar',
    'time': '2d ago',
    'title': 'My Journey with Programming',
    'content':
        'Programming was difficult for me at first, but practicing every day helped me understand things that seemed impossible before.',
    'likes': 42,
    'comments': 11,
    'isLiked': true,
  },
  {
    'username': 'Nora',
    'time': '2d ago',
    'title': 'Never Stop Learning',
    'content':
        'Technology changes very quickly, so learning should never stop. Every new concept you learn can open a new opportunity.',
    'likes': 27,
    'comments': 7,
    'isLiked': false,
  },
  {
    'username': 'Yousef',
    'time': '3d ago',
    'title': 'A Productive Day',
    'content':
        'Today I finished several tasks that I had been postponing for a long time. It feels great to finally make progress.',
    'likes': 19,
    'comments': 5,
    'isLiked': false,
  },


];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordpace'),
        automaticallyImplyLeading: false,   

      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: PostCardWidget(
              username: post['username'] as String,
              time: post['time'] as String,
              title: post['title'] as String,
              content: post['content'] as String,
              likes: post['likes'] as int,
              comments: post['comments'] as int,
              isLiked: post['isLiked'] as bool,
            ),
          );
        },
      ),
    );
  }
}