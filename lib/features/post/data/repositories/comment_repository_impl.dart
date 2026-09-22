import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/expentions.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/post/data/datasources/comment_remote_data_source.dart';
import 'package:wordspace/features/post/domain/entities/comment_entity.dart';
import 'package:wordspace/features/post/domain/repositories/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource remoteDataSource;

  CommentRepositoryImpl({
    required this.remoteDataSource,
  });

//جلب التعليقات
  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(
      int postId) async {
    try {
      final response = await remoteDataSource.getComments(postId);

//هنا نحول الـModel إلى Entity قبل إرجاعها
      return Right(
        response.map((comment) => comment.toEntity()).toList(),
      );
    } on ServerException catch (e) {
      return Left(
        Failure(
          errMessage:
              e.errorModel.errorMessage ?? 'حدث خطأ في السيرفر',
        ),
      );
    }
  }
  //إضافة تعليق
  @override
  Future<Either<Failure, CommentEntity>> addComment(
      int postId, String body) async {
    try {
      final response = await remoteDataSource.addComment(
        postId,
        body,
      );

      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(
        Failure(
          errMessage:
              e.errorModel.errorMessage ?? 'حدث خطأ في السيرفر',
        ),
      );
    }
  }
//حذف تعليق
  @override
  Future<Either<Failure, Unit>> deleteComment(int commentId) async {
    try {
      await remoteDataSource.deleteComment(commentId);

      return const Right(unit);
    } on ServerException catch (e) {
      return Left(
        Failure(
          errMessage:
              e.errorModel.errorMessage ?? 'حدث خطأ في السيرفر',
        ),
      );
    }
  }


}