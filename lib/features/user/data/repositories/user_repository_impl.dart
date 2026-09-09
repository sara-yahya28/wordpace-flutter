import 'package:dartz/dartz.dart';
import 'package:wordspace/core/connection/network_info.dart';
import 'package:wordspace/core/errors/expentions.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/user/data/datasources/user_local_data_source.dart';
import 'package:wordspace/features/user/data/datasources/user_remote_data_source.dart';
import 'package:wordspace/features/user/data/models/auth_model.dart';
import 'package:wordspace/features/user/domain/repositories/user_repository.dart';
import '../../../../core/databases/cache/cache_helper.dart';
import '../../../../core/params/params.dart';
import '../../domain/entities/user_entitiy.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final CacheHelper cacheHelper;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.cacheHelper,
  });

  @override
  Future<Either<Failure, UserEntity>> getUser([String? userId]) async {
    if (await networkInfo.isConnected!) {
      try {
        final params = UserParams(id: userId ?? '');
        final remoteUser = await remoteDataSource.getUser(params);
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

  @override
  Future<Either<Failure, AuthModel>> login(LoginParams params) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteUser = await remoteDataSource.login(params);
        await cacheHelper.saveData(
            key: 'token', value: remoteUser.token); //store token in cacheHelper
            
        await localDataSource.cacheUser(remoteUser.user); //stores Last user
        return Right(remoteUser);
      } on ServerException catch (e) {
              print('❌ ServerException: ${e.errorModel.errorMessage}');
        return Left(
          Failure(
            errMessage: e.errorModel.errorMessage ?? 'Error Occurred In Server',
          ),
        );
      } catch (e, stacktrace) {
  print('❌ الخطأ الفعلي: $e');
  print('❌ التفاصيل: $stacktrace');
  return Left(
    Failure(
      errMessage: 'الخطأ الفعلي: $e',
    ),
  );
}
    } else {
      return Left(
        Failure(
          errMessage: 'No Internet Connection ',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AuthModel>> register(RegisterParams params) async {
    if (await networkInfo.isConnected!) {
      try {
        final localUser = await remoteDataSource.register(params);
        await cacheHelper.saveData(key: 'token', value: localUser.token);
        await localDataSource.cacheUser(localUser.user);
        return Right(localUser);
      } on ServerException catch (e) {
        return Left(
          Failure(
            errMessage: e.errorModel.errorMessage ?? 'Error Occurred',
          ),
        );
      } catch (e) {
        return Left(
          Failure(
            errMessage: 'حدث خطأ غير متوقع',
          ),
        );
      }
    } else {
      return Left(
        Failure(
          errMessage: 'لا يوجد اتصال بالإنترنت',
        ),
      );
    }
  }
}
/*
What Was Done
WHAT:
   - Implements UserRepository interface.
   - Orchestrates remote/local data sources and network info.

   OGIC:
   - For getUser:
     - If connected: fetch from remote, cache it, return entity.
     - If offline: return cached user if exists, else failure.
   - For login/register:
     - Always use remote data source.
     - On success: optionally cache user/token.
     - On failure: catch ServerException and return Failure.

 */
