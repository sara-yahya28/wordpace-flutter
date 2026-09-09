import 'package:dartz/dartz.dart';
import 'package:wordspace/core/connection/network_info.dart';
import 'package:wordspace/core/errors/expentions.dart';
import 'package:wordspace/core/errors/failure.dart';
import 'package:wordspace/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:wordspace/features/profile/domain/entities/profile_entity.dart';
import 'package:wordspace/features/profile/domain/repositories/profile_repository.dart';
import 'package:wordspace/features/post/domain/entities/post_entitiy.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProfileEntity>> getProfileStats() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteProfile = await remoteDataSource.getProfileStats();
        return Right(remoteProfile);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.message ?? 'خطأ في السيرفر'));
      }
    } else {
      return Left(Failure(errMessage: 'لا يوجد اتصال بالإنترنت'));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getMyPosts() async {
    if (await networkInfo.isConnected!) {
      try {
        final myPosts = await remoteDataSource.getMyPosts();
        return Right(myPosts.cast<PostEntity>());
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.message ?? 'خطأ في السيرفر'));
      }
    } else {
      return Left(Failure(errMessage: 'لا يوجد اتصال بالإنترنت'));
    }
  }
}