import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';
import 'package:wordspace/features/profile/domain/repositories/profile_repository.dart';

class GetMyPostsUseCase {
  final ProfileRepository repository;

  GetMyPostsUseCase({required this.repository});

  Future<Either<Failure, List<PostEntity>>> call() async {
    return await repository.getMyPosts();
  }
}