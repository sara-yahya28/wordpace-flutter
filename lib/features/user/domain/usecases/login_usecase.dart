import 'package:dartz/dartz.dart';
import 'package:wordspace/features/user/data/models/auth_model.dart';
import 'package:wordspace/features/user/domain/repositories/user_repository.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

class LoginUseCase {
  final UserRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, AuthModel>> call(
       LoginParams params) {
    return repository.login(params);
  }
}