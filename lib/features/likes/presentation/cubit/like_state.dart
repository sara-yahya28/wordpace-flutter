import 'package:equatable/equatable.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';

abstract class LikeState extends Equatable {}

final class LikeInitialState extends LikeState {
  @override
  List<Object> get props => [];
}

final class GetFavoritePostsLoadingState extends LikeState {
  @override
  List<Object> get props => [];
}

final class GetFavoritePostsSuccessState extends LikeState {
  final List<PostEntity> posts;
  final Set<int> favoriteIds;

  GetFavoritePostsSuccessState({
    required this.posts,
    required this.favoriteIds,
  });

  @override
  List<Object> get props => [posts, favoriteIds];
}

final class GetFavoritePostsErrorState extends LikeState {
  final String errMessage;

  GetFavoritePostsErrorState({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

final class IsFavoriteStatusState extends LikeState {
  final Set<int> favoriteIds;

  IsFavoriteStatusState({required this.favoriteIds});

  @override
  List<Object> get props => [favoriteIds];
}