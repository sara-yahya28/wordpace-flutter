import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/features/likes/domain/repositories/like_repository.dart';
import 'package:wordspace/features/likes/presentation/cubit/like_state.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';

class LikeCubit extends Cubit<LikeState> {
  final LikeRepository likeRepository;

  LikeCubit({required this.likeRepository}) : super(LikeInitialState());

  Future<void> getFavoritePosts() async {
    emit(GetFavoritePostsLoadingState());
    final result = await likeRepository.getFavoritePosts();
    result.fold(
      (failure) => emit(
        GetFavoritePostsErrorState(errMessage: failure.errMessage),
      ),
      (posts) => emit(
        GetFavoritePostsSuccessState(
          posts: posts,
          favoriteIds: posts.map((p) => p.id).toSet(),
        ),
      ),
    );
  }

  /// يرجع true لو العملية نجحت، false لو فشلت
  /// (الـ UI بيستخدم القيمة دي عشان يعرض SnackBar)
  Future<bool> toggleLike(PostEntity post) async {
    final currentState = state;
    if (currentState is! GetFavoritePostsSuccessState) return false;

    // 1. اقرأي الحالة الحالية
    final isLiked = currentState.favoriteIds.contains(post.id);

    // 2. Optimistic update
    final newFavIds = Set<int>.from(currentState.favoriteIds);
    final newPosts = List<PostEntity>.from(currentState.posts);

    if (isLiked) {
      newFavIds.remove(post.id);
      newPosts.removeWhere((p) => p.id == post.id);
    } else {
      newFavIds.add(post.id);
      if (!newPosts.any((p) => p.id == post.id)) {
        newPosts.add(post);
      }
    }

    final newCounts = Map<int, int>.from(currentState.likesCountOverrides);
    final currentCount = newCounts[post.id] ?? post.likesCount;
    newCounts[post.id] = isLiked ? currentCount - 1 : currentCount + 1;

    emit(
      GetFavoritePostsSuccessState(
        posts: newPosts,
        favoriteIds: newFavIds,
        likesCountOverrides: newCounts,
      ),
    );

    // 3. نادي السيرفر
    final result = await likeRepository.toggleLike(post.id);

    return result.fold(
      (failure) {
        // 4. Rollback
        emit(currentState);
        return false;
      },
      (response) {
        // 5. تأكدي من القيم اللي رجعت من السيرفر
        final finalFavIds = Set<int>.from(newFavIds);
        final finalPosts = List<PostEntity>.from(newPosts);

        if (response.liked) {
          finalFavIds.add(post.id);
          if (!finalPosts.any((p) => p.id == post.id)) {
            finalPosts.add(post);
          }
        } else {
          finalFavIds.remove(post.id);
          finalPosts.removeWhere((p) => p.id == post.id);
        }

        final finalCounts = Map<int, int>.from(newCounts);
        finalCounts[post.id] = response.likesCount;

        emit(
          GetFavoritePostsSuccessState(
            posts: finalPosts,
            favoriteIds: finalFavIds,
            likesCountOverrides: finalCounts,
          ),
        );
        return true;
      },
    );
  }

  void reset() {
    emit(LikeInitialState());
  }
}