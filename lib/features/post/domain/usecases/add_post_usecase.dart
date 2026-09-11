import 'package:dartz/dartz.dart';

import 'package:wordspace/core/errors/failure.dart';

import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';

import 'package:wordspace/features/post/domain/repositories/post_repository.dart';

// UseCase هو طبقة وسيطة بين الـRepository والـPresentation layer

// هذا الـUseCase ينشئ منشور جديد

class AddPostUseCase {

  final PostRepository repository;

  AddPostUseCase({

    required this.repository,

  });

  Future<Either<Failure, PostEntity>> call({

    required String title,

    required String body,

    required String status,

  }) {

    return repository.createPost(

      title: title,

      body: body,

      status: status,

    );

  }

}