import 'package:dartz/dartz.dart';
import 'package:wordspace/features/user/data/models/auth_model.dart';
import 'package:wordspace/features/user/domain/repositories/user_repository.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

class RegisterUseCase {
  final UserRepository repository;

  RegisterUseCase({required this.repository});

  Future<Either<Failure, AuthModel>> call(
       RegisterParams params) {
    return repository.register(params);
  }
}