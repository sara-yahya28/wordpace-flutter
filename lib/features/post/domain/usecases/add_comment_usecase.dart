import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/post/domain/entities/comment_entity.dart';
import 'package:wordspace/features/post/domain/repositories/comment_repository.dart';

class AddCommentUseCase {
  final CommentRepository repository;

  AddCommentUseCase({
    required this.repository,
  });

  Future<Either<Failure, CommentEntity>> call(
    int postId,
    String body,
  ) {
    return repository.addComment(postId, body);
  }
}