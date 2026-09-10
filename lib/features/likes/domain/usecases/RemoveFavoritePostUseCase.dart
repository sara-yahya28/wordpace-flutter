import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/likes/domain/repositories/like_repository.dart';

class RemoveFavoritePostUseCase{
 final LikeRepository likeRepository;

RemoveFavoritePostUseCase({required this.likeRepository});
Future<Either<Failure,void>> call({required int postid}){
  return likeRepository.removeFavoritePost(postId: postid);
}
}