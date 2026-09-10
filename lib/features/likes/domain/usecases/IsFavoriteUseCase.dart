import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/likes/domain/repositories/like_repository.dart';

class IsFavoriteUseCase {
final LikeRepository likeRepository;

IsFavoriteUseCase({required this.likeRepository});
Future<Either<Failure,bool>> call({required int postid}){
  return likeRepository.isFavorite(postId: postid);
}

}