import 'package:dartz/dartz.dart';
import 'package:wordspace/features/likes/domain/repositories/like_repository.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';
import '../../../../core/errors/failure.dart';

class GetFavoritePostsUseCase {
  final LikeRepository likeRepository;

  GetFavoritePostsUseCase({required this.likeRepository});

  Future<Either<Failure, List<PostEntity>>> call(){
    return likeRepository.getFavoritePosts();
  }
}