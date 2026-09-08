import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/expentions.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/post/data/datasources/post_remote_data_source.dart';
import 'package:wordspace/features/post/domain/entities/posts_response_entity.dart';
import 'package:wordspace/features/post/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  //هنا نستخدم الـRemoteDataSource للحصول على البيانات من الـAPI
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, PostsResponseEntity>> getPosts(int page) async {
    try {
      final response = await remoteDataSource.getPosts(page);

      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(
        Failure(
          errMessage: e.errorModel.errorMessage ?? 'حدث خطأ في السيرفر',
        ),
      );
    }
  }
}