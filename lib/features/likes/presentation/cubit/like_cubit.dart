import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/features/likes/domain/usecases/GetFavoritePostsUseCase.dart';
import 'package:wordspace/features/likes/domain/usecases/IsFavoriteUseCase.dart';
import 'package:wordspace/features/likes/domain/usecases/RemoveFavoritePostUseCase.dart';
import 'package:wordspace/features/likes/domain/usecases/SaveFavoritePostUseCase.dart';
import 'package:wordspace/features/likes/presentation/cubit/like_state.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';

class LikeCubit extends Cubit<LikeState> {
  final GetFavoritePostsUseCase getFavoritePostsUseCase;
  final IsFavoriteUseCase isFavoriteUseCase;
  final RemoveFavoritePostUseCase removeFavoritePostUseCase;
  final SaveFavoritePostUseCase saveFavoritePostUseCase;

  LikeCubit({
    required this.getFavoritePostsUseCase,
    required this.isFavoriteUseCase,
    required this.removeFavoritePostUseCase,
    required this.saveFavoritePostUseCase,
  }) : super(LikeInitialState());

  // Load full list from cache (used by Favorites screen)
  Future<void> getFavoritePosts() async {
    emit(GetFavoritePostsLoadingState());
      print("🟢 saveFavoritePost called. Cubit hashCode: ${this.hashCode}");
    final result = await getFavoritePostsUseCase();
    result.fold(
      (failure) =>
          emit(GetFavoritePostsErrorState(errMessage: failure.errMessage)),
      (posts) => emit(GetFavoritePostsSuccessState(
        posts: posts,
        favoriteIds: posts.map((p) => p.id).toSet(),
      )),
    );
  }

  // Save + optimistically update state (no re-fetch)
Future<void> saveFavoritePost({required PostEntity post}) async {
  print("🟢 [CUBIT ${hashCode}] saveFavoritePost called for post.id=${post.id}");
  final result = await saveFavoritePostUseCase(post: post);
  result.fold(
    (failure) {
      print("🔴 [CUBIT ${hashCode}] save failed: ${failure.errMessage}");
      emit(GetFavoritePostsErrorState(errMessage: failure.errMessage));
    },
    (_) {
      final s = state;
      List<PostEntity> currentPosts = [];
      Set<int> currentIds = {};
      if (s is GetFavoritePostsSuccessState) {
        currentPosts = List.from(s.posts);
        currentIds = Set.from(s.favoriteIds);
      }
      if (!currentPosts.any((p) => p.id == post.id)) {
        currentPosts.add(post);
      }
      currentIds.add(post.id);
      print("🟢 [CUBIT ${hashCode}] emitting new state. favoriteIds=$currentIds");
      emit(GetFavoritePostsSuccessState(
        posts: currentPosts,
        favoriteIds: currentIds,
      ));
    },
  );
}

  // Remove + optimistically update state (no re-fetch)
  Future<void> removeFavoritePost({required int postid}) async {
    final result = await removeFavoritePostUseCase(postid: postid);
    result.fold(
      (failure) =>
          emit(GetFavoritePostsErrorState(errMessage: failure.errMessage)),
      (_) {
        final s = state;
        if (s is GetFavoritePostsSuccessState) {
          final newPosts = s.posts.where((p) => p.id != postid).toList();
          final newIds = Set<int>.from(s.favoriteIds)..remove(postid);
          emit(GetFavoritePostsSuccessState(
            posts: newPosts,
            favoriteIds: newIds,
          ));
        }
      },
    );
  }

  // Called once when the button is created
  Future<void> isFavorite({required int postId}) async {
    if (state is LikeInitialState) {
      final result = await getFavoritePostsUseCase();
      result.fold(
        (failure) =>
            emit(GetFavoritePostsErrorState(errMessage: failure.errMessage)),
        (posts) => emit(GetFavoritePostsSuccessState(
          posts: posts,
          favoriteIds: posts.map((p) => p.id).toSet(),
        )),
      );
    }
  }
}