import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/post/domain/entities/posts_response_entity.dart';

abstract class PostRepository {
  Future<Either<Failure, PostsResponseEntity>> getPosts(int page);
}