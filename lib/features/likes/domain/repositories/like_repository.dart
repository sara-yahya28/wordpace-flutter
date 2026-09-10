import 'package:dartz/dartz.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';
import '../../../../core/errors/failure.dart';

// declare functions in use, without caring about source
abstract class LikeRepository {
  Future<Either<Failure, List<PostEntity>>> getFavoritePosts();
  Future<Either<Failure,void>> saveFavoritePost({required PostEntity post});
 Future<Either<Failure, bool>> isFavorite({required int postId}); 
  Future<Either<Failure, void>> removeFavoritePost({required int postId});
}
