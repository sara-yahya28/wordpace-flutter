//هذا الملف هو حلقة الوصل بين Data and Domain layers
import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/expentions.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/post/data/datasources/post_remote_data_source.dart';
import 'package:wordspace/features/post/domain/entities/posts_response_entity.dart';
import 'package:wordspace/features/post/domain/repositories/post_repository.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';

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

  @override
  Future<Either<Failure, PostEntity>> createPost({
    required String title,
    required String body,
    required String status,
  }) async {
    try {
      final response = await remoteDataSource.createPost(
        title: title,
        body: body,
        status: status,
      );

      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(
        Failure(
          errMessage: e.errorModel.errorMessage ?? 'حدث خطأ في السيرفر',
        ),
      );
    }
  }

  //  تنفيذ دالة الحذف
  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    try {
      await remoteDataSource.deletePost(id);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(
        Failure(
          errMessage: e.errorModel.errorMessage ?? 'حدث خطأ في السيرفر',
        ),
      );
    }
  }
}