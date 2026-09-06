import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/user/domain/entities/user_entitiy.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUser();
} 
