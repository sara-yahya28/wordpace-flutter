import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/core/params/params.dart';
import 'package:wordspace/features/user/data/models/auth_model.dart';
import 'package:wordspace/features/user/domain/entities/user_entitiy.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUser([String? userId]);
  Future<Either<Failure, AuthModel>> login(LoginParams params);
  Future<Either<Failure, AuthModel>> register(RegisterParams params);
} 
