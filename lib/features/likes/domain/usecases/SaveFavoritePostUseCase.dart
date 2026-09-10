import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/likes/domain/repositories/like_repository.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';

class SaveFavoritePostUseCase {
  final LikeRepository likeRepository;

  SaveFavoritePostUseCase({required this.likeRepository});

  Future<Either<Failure, void>> call({required PostEntity post}) {
    return likeRepository.saveFavoritePost(post: post);
  }
}