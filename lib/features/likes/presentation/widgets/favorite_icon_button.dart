import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/features/likes/presentation/cubit/like_cubit.dart';
import 'package:wordspace/features/likes/presentation/cubit/like_state.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';

class FavoriteIconButton extends StatelessWidget {
  final PostEntity post;

  const FavoriteIconButton({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikeCubit, LikeState>(
      builder: (context, state) {
        bool isFav = false;

        if (state is GetFavoritePostsSuccessState) {
          isFav = state.favoriteIds.contains(post.id);
        } else if (state is IsFavoriteStatusState) {
          isFav = state.favoriteIds.contains(post.id);
        }

        return GestureDetector(
          onTap: () {
            final cubit = context.read<LikeCubit>();
            if (isFav) {
              cubit.removeFavoritePost(postid: post.id);
            } else {
              cubit.saveFavoritePost(post: post);
            }
          },
          child: Icon(
            isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: isFav ? Colors.redAccent : Colors.grey[600],
            size: 22,
          ),
        );
      },
    );
  }
}