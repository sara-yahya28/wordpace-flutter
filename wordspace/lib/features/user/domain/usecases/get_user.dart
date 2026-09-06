import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/user/domain/repositories/user_repository.dart';

import '../entities/user_entitiy.dart';

class GetUser {
  final UserRepository repository;

  GetUser({required this.repository});

  Future<Either<Failure, UserEntity>> call() {
    return repository.getUser();
  }
}