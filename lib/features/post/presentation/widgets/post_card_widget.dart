import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/core/theme/app_theme.dart';
import 'package:wordspace/features/likes/presentation/cubit/like_cubit.dart';
import 'package:wordspace/features/likes/presentation/cubit/like_state.dart';
import 'package:wordspace/features/likes/presentation/widgets/favorite_icon_button.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';

class PostCardWidget extends StatelessWidget {
  final String username;
  final String time;
  final String title;
  final String content;
  final int likes;
  final int comments;
  final bool isLiked;
  final VoidCallback? onTap;
  final PostEntity post;

  const PostCardWidget({
    super.key,
    required this.username,
    required this.time,
    required this.title,
    required this.content,
    required this.likes,
    required this.comments,
    this.isLiked = false,
    this.onTap,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      color: AppTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppTheme.primaryLight.withOpacity(0.25),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User information
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
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
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          color: AppTheme.primaryDark,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        time,
                        style: const TextStyle(
                          color: AppTheme.primaryLight,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Post title
              Text(
                title,
                style: const TextStyle(
                  color: AppTheme.primaryDark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 7),

              // Post content
              Text(
                content,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppTheme.primaryMedium,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 16),

              // Like and comment
              Row(
                children: [
                  FavoriteIconButton(post: post),
                  const SizedBox(width: 5),
                  BlocBuilder<LikeCubit, LikeState>(
                    builder: (context, state) {
                      bool isFav = false;
                      if (state is GetFavoritePostsSuccessState) {
                        isFav = state.favoriteIds.contains(post.id);
                      } else if (state is IsFavoriteStatusState) {
                        isFav = state.favoriteIds.contains(post.id);
                      }
                      final displayedLikes = likes + (isFav ? 1 : 0);
                      return Text(
                        '$displayedLikes',
                        style: const TextStyle(
                          color: AppTheme.primaryMedium,
                          fontSize: 13,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  const Icon(
                    Icons.chat_bubble_outline,
                    size: 21,
                    color: AppTheme.primaryMedium,
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
          ),
        ),
      ),
    );
  }
}
