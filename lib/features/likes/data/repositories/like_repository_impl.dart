import 'package:dartz/dartz.dart';
import 'package:wordspace/core/connection/network_info.dart';
import 'package:wordspace/core/errors/expentions.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/likes/data/datasources/like_local_data_source.dart';
import 'package:wordspace/features/likes/data/datasources/like_remote_data_source.dart';
import 'package:wordspace/features/likes/data/models/like_response_model.dart';
import 'package:wordspace/features/likes/domain/repositories/like_repository.dart';
import 'package:wordspace/features/post/data/models/post_model.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';

class LikeRepositoryImpl extends LikeRepository {
  final LikeRemoteDataSource remoteDataSource;
  final LikeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LikeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PostEntity>>> getFavoritePosts() async {
    if (await networkInfo.isConnected!) {
      try {
        // 1. اجمعي كل الصفحات من السيرفر
        final List<PostModel> allPosts = [];
        int page = 1;
        bool hasMore = true;

        while (hasMore) {
          final response = await remoteDataSource.getLikedPosts(page);
          allPosts.addAll(response.posts);

          if (response.currentPage >= response.lastPage) {
            hasMore = false;
          } else {
            page++;
          }
        }

        // 2. احفظي القائمة كاملة في الكاش
        await localDataSource.saveAllFavoritePosts(allPosts);

        // 3. رجّعي Entity
        return Right(
          allPosts.map((model) => model.toEntity()).toList(),
        );
      } on ServerException catch (e) {
        return Left(
          Failure(
            errMessage: e.errorModel.errorMessage ?? 'حدث خطأ في السيرفر',
          ),
        );
      }
    } else {
      // Offline: من الكاش
      try {
        final posts = await localDataSource.getFavoritePosts();
        return Right(
          posts.map((model) => model.toEntity()).toList(),
        );
      } on CacheException catch (e) {
        return Left(Failure(errMessage: e.errorMessage));
      }
    }
  }

  @override
  Future<Either<Failure, LikeResponseModel>> toggleLike(int postId) async {
    if (await networkInfo.isConnected!) {
      try {
        final response = await remoteDataSource.toggleLike(postId);
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          Failure(
            errMessage: e.errorModel.errorMessage ?? 'حدث خطأ في السيرفر',
          ),
        );
      }
    } else {
      return Left(
        Failure(errMessage: 'لا يوجد اتصال بالإنترنت'),
      );
    }
  }
}