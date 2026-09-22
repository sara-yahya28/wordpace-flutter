import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/features/likes/presentation/cubit/like_cubit.dart';
import 'package:wordspace/features/likes/presentation/cubit/like_state.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';

class FavoriteIconButton extends StatefulWidget {
  final PostEntity post;

  const FavoriteIconButton({super.key, required this.post});

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikeCubit, LikeState>(
      builder: (context, state) {
        bool isFav = false;

        if (state is GetFavoritePostsSuccessState) {
          isFav = state.favoriteIds.contains(widget.post.id);
        }

        return GestureDetector(
          onTap: _isLoading
              ? null
              : () async {
                  setState(() => _isLoading = true);
                  final success = await context
                      .read<LikeCubit>()
                      .toggleLike(widget.post);

                  if (!mounted) return;
                  setState(() => _isLoading = false);

                  if (!success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تعذّر تحديث الإعجاب، حاول لاحقاً'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
          child: _isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(
                  isFav
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: isFav ? Colors.redAccent : Colors.grey[600],
                  size: 22,
                ),
        );
      },
    );
  }
}