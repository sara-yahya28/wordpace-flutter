import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/post/domain/entities/comment_entity.dart';
import 'package:wordspace/features/post/domain/repositories/comment_repository.dart';

class GetCommentsUseCase {
  final CommentRepository repository;

  GetCommentsUseCase({
    required this.repository,
  });

  Future<Either<Failure, List<CommentEntity>>> call(int postId) {
    return repository.getComments(postId);
  }
}