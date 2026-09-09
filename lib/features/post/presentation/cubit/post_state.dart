import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostSuccess extends PostState {
  final List<PostEntity> posts;
  final int currentPage;
  final int lastPage;

  PostSuccess({
    required this.posts,
    required this.currentPage,
    required this.lastPage,
  });
}

class PostLoadingMore extends PostState {
  final List<PostEntity> posts;

  PostLoadingMore({
    required this.posts,
  });
}

class PostFailure extends PostState {
  final String message;

  PostFailure({
    required this.message,
  });
}