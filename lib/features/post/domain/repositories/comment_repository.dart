import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/post/domain/entities/comment_entity.dart';

abstract class CommentRepository {
  //عرض الكومنتات
  Future<Either<Failure, List<CommentEntity>>> getComments(int postId);
//إضافة كومنت
    Future<Either<Failure, CommentEntity>> addComment(
    int postId,
    String body,
  );
//حذف كومنت
Future<Either<Failure, Unit>> deleteComment(int commentId);
}