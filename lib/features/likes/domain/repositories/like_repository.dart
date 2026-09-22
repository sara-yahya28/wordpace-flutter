import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/likes/data/models/like_response_model.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';

abstract class LikeRepository {
  Future<Either<Failure, List<PostEntity>>> getFavoritePosts();
  Future<Either<Failure, LikeResponseModel>> toggleLike(int postId);
}