import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/post/domain/repositories/comment_repository.dart';

class DeleteCommentUseCase {
  final CommentRepository repository;

  DeleteCommentUseCase({
    required this.repository,
  });

  Future<Either<Failure, Unit>> call(int commentId) {
    return repository.deleteComment(commentId);
  }
}