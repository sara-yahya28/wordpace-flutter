import 'package:dartz/dartz.dart';

import 'package:wordspace/core/errors/failure.dart';

import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';

import 'package:wordspace/features/post/domain/entities/posts_response_entity.dart';

abstract class PostRepository {

  Future<Either<Failure, PostsResponseEntity>> getPosts(int page);

  Future<Either<Failure, PostEntity>> createPost({

    required String title,

    required String body,

    required String status,

  });

}