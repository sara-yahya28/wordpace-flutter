import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/core/theme/app_theme.dart';
import 'package:wordspace/features/likes/presentation/cubit/like_cubit.dart';
import 'package:wordspace/features/likes/presentation/cubit/like_state.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';
import 'package:wordspace/features/post/presentation/cubit/post_cubit.dart';
import 'package:wordspace/features/post/presentation/screens/post_details_screen.dart';
import 'package:wordspace/features/profile/presentation/cubit/profile_cubit.dart';

class MyPostsListWidget extends StatelessWidget {
  final List<PostEntity> posts;

  const MyPostsListWidget({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
          child: Text(
            ' No post yet. ',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 1,
          color: AppTheme.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: AppTheme.primaryLight.withOpacity(0.25),
            ),
          ),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PostDetailsScreen(post: post),
                ),
              );
            },
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: AppTheme.primaryDark,
              child: Text(
                post.user.name.isNotEmpty ? post.user.name[0].toUpperCase() : 'U',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            title: Text(
              post.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryDark,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  post.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, color: AppTheme.primaryMedium),
                ),
                const SizedBox(height: 8),
                
                BlocBuilder<LikeCubit, LikeState>(
                  builder: (context, state) {
                    bool isFav = false;
                    if (state is GetFavoritePostsSuccessState) {
                      isFav = state.favoriteIds.contains(post.id);
                    } else if (state is IsFavoriteStatusState) {
                      isFav = state.favoriteIds.contains(post.id);
                    }

                    final displayedLikes = post.likesCount + (isFav ? 1 : 0);

                    return Row(
                      children: [
                        Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          size: 16,
                          color: isFav ? Colors.red : Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$displayedLikes',
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 16),
                       
                      ],
                    );
                  },
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => _showDeleteDialog(context, post.id),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(' Confirm Deletion '),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(dialogContext);

              context.read<ProfileCubit>().deletePost(postId);
              context.read<PostCubit>().removePostFromList(postId);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}