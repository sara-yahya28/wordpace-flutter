import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/features/likes/presentation/cubit/like_cubit.dart';
import 'package:wordspace/features/likes/presentation/cubit/like_state.dart';
import 'package:wordspace/features/post/presentation/screens/post_details_screen.dart';
import 'package:wordspace/features/post/presentation/widgets/post_card_widget.dart';
import 'package:wordspace/features/post/utils/date_formatter.dart';

class FavoritsScreen extends StatelessWidget {
  const FavoritsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: BlocBuilder<LikeCubit, LikeState>(
        builder: (context, state) {
          if (state is GetFavoritePostsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GetFavoritePostsErrorState) {
            return Center(child: Text(state.errMessage));
          }

          if (state is GetFavoritePostsSuccessState) {
            if (state.posts.isEmpty) {
              return const Center(child: Text('No Favorite Posts Yet'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: PostCardWidget(
                    post: post,
                    username: post.user.name,
                    time: formatPostTime(post.createdAt),
                    title: post.title,
                    content: post.content,
                    likes: post.likesCount,
                    comments: post.commentsCount,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailsScreen(post: post),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No Favorite Posts Yet'));
        },
      ),
    );
  }
}