import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/profile/domain/entities/profile_entity.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfileStats();
  Future<Either<Failure, List<PostEntity>>> getMyPosts();
}