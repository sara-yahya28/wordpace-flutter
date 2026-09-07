
import 'package:flutter/material.dart';
import 'package:wordspace/core/theme/app_theme.dart';


class PostDetailsWidget extends StatelessWidget{
  final String username;
  final String time;
  final String title;
  final String content;
  final int likes;
  final int comments;
  final bool isLiked;

  const PostDetailsWidget({super.key, required this.username, required this.time, required this.title, required this.content, required this.likes, required this.comments, required this.isLiked});

@override
Widget build(BuildContext context){
return Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
// User information
Row(
children: [
CircleAvatar(
radius:22,
backgroundColor: AppTheme.primaryDark,
child: Text(
username.isNotEmpty ? username[0].toUpperCase() : '?',
style: const TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
),

const SizedBox(width: 10),

Column(
crossAxisAlignment: CrossAxisAlignment.start,
children:[
Text(
username,
style: const TextStyle(
color:AppTheme.primaryDark,
fontSize:14,
fontWeight:FontWeight.bold,
),
),
Text(
  time,
    style: const TextStyle(
    color: AppTheme.primaryLight,
    fontSize: 11,
  ),
),
]
),
]
),

const SizedBox(height: 16),

//Post title
        Text(
          title,
          style: const TextStyle(
            color: AppTheme.primaryDark,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // Full post content
        Text(
          content,
          style: const TextStyle(
            color: AppTheme.primaryMedium,
            fontSize: 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
// Likes and comments
        Row(
          children: [
            const Icon(
              Icons.favorite_border,
              color: AppTheme.primaryMedium,
              size: 20,
            ),

            const SizedBox(width: 5),

            Text(
              '$likes',
              style: const TextStyle(
                color: AppTheme.primaryMedium,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 20),

            const Icon(
              Icons.chat_bubble_outline,
              color: AppTheme.primaryMedium,
              size: 19,
            ),
            const SizedBox(width: 5),
            Text(
              '$comments',
              style: const TextStyle(
                color: AppTheme.primaryMedium,
                fontSize: 13,
              ),
            ),

          ],
        ),
      ],
    );
}

}



