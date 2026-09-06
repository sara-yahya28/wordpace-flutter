import 'package:dartz/dartz.dart';
import 'package:wordspace/core/connection/network_info.dart';
import 'package:wordspace/core/errors/expentions.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/user/data/datasources/user_local_data_source.dart';
import 'package:wordspace/features/user/data/datasources/user_remote_data_source.dart';
import 'package:wordspace/features/user/domain/repositories/user_repository.dart';

import '../../domain/entities/user_entitiy.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteUser = await remoteDataSource.getUser();
        await localDataSource.cacheUser(remoteUser);
        return Right(remoteUser.toEntity());
      } on ServerException catch (e) {
        return Left(
          Failure(
            errMessage: e.errorModel.errorMessage ?? 'حدث خطأ في السيرفر',
          ),
        );
      }
    } else {
      try {
        final localUser = await localDataSource.getLastUser();
        return Right(localUser.toEntity());
      } on CacheException catch (e) {
        return Left(
          Failure(
            errMessage: e.errorMessage,
          ),
        );
      }
    }
  }
}