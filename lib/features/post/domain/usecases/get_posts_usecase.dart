import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/post/domain/entities/posts_response_entity.dart';
import 'package:wordspace/features/post/domain/repositories/post_repository.dart';

//UseCase هو طبقة وسيطة بين الـRepository والـPresentation layer
//هذا الUseCase يجيب المنشورات حسب رقم الصفحة

class GetPostsUseCase {
  final PostRepository repository;

  GetPostsUseCase({
    required this.repository,
  });

  Future<Either<Failure, PostsResponseEntity>> call(int page) {
    return repository.getPosts(page);
  }
}