import 'package:dartz/dartz.dart';
import 'package:wordspace/features/likes/domain/repositories/like_repository.dart';
import 'package:wordspace/features/post/data/models/post_model.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';
import '../../../../core/errors/failure.dart';
import '../datasources/like_local_data_source.dart';

class LikeRepositoryImpl extends LikeRepository {
  final LikeLocalDataSource likeLocalDataSource;
  LikeRepositoryImpl({required this.likeLocalDataSource});

  @override
  Future<Either<Failure, List<PostEntity>>> getFavoritePosts() async {
    try {
      final localLikedPost = await likeLocalDataSource.getFavoritePosts();
      return Right(localLikedPost.cast<PostEntity>());
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveFavoritePost(
      {required PostEntity post}) async {
    try {
      final postModel = PostModel.fromEntity(post);
      await likeLocalDataSource.saveFavoritePost(postModel);
      return const Right(null);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite({required int postId}) async {
    try {
      final isLiked = await likeLocalDataSource.isFavorite(postId);
      return Right(isLiked);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavoritePost(
      {required int postId}) async {
    try {
      await likeLocalDataSource.removeFavoritePost(postId);
      return const Right(null);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}