import 'package:dartz/dartz.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/core/params/params.dart';
import 'package:wordspace/features/profile/domain/entities/profile_entity.dart';
import 'package:wordspace/features/profile/domain/repositories/profile_repository.dart';

class GetProfileStatsUseCase {
  final ProfileRepository repository;

  GetProfileStatsUseCase({required this.repository});

  Future<Either<Failure, ProfileEntity>> call(GetProfileStatsParams params) async {
    return await repository.getProfileStats();
  }
}