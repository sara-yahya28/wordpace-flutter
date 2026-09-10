import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wordspace/core/connection/network_info.dart';
import 'package:wordspace/core/databases/api/api_consumer.dart';
import 'package:wordspace/core/databases/api/dio_consumer.dart';
import 'package:wordspace/core/databases/cache/cache_helper.dart';
import 'package:wordspace/features/likes/data/datasources/like_local_data_source.dart';
import 'package:wordspace/features/likes/data/repositories/like_repository_impl.dart';
import 'package:wordspace/features/likes/domain/repositories/like_repository.dart';
import 'package:wordspace/features/likes/domain/usecases/GetFavoritePostsUseCase.dart';
import 'package:wordspace/features/likes/domain/usecases/IsFavoriteUseCase.dart';
import 'package:wordspace/features/likes/domain/usecases/RemoveFavoritePostUseCase.dart';
import 'package:wordspace/features/likes/domain/usecases/SaveFavoritePostUseCase.dart';
import 'package:wordspace/features/likes/presentation/cubit/like_cubit.dart';
import 'package:wordspace/features/post/data/datasources/post_remote_data_source.dart';
import 'package:wordspace/features/post/data/repositories/post_repository_impl.dart';
import 'package:wordspace/features/post/domain/repositories/post_repository.dart';
import 'package:wordspace/features/post/domain/usecases/get_posts_usecase.dart';
import 'package:wordspace/features/post/presentation/cubit/post_cubit.dart';
import 'package:wordspace/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:wordspace/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:wordspace/features/profile/domain/repositories/profile_repository.dart';
import 'package:wordspace/features/profile/domain/usecases/get_profile_stats_usecase.dart';
import 'package:wordspace/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:wordspace/features/user/data/datasources/user_local_data_source.dart';
import 'package:wordspace/features/user/data/datasources/user_remote_data_source.dart';
import 'package:wordspace/features/user/data/repositories/user_repository_impl.dart';
import 'package:wordspace/features/user/domain/repositories/user_repository.dart';
import 'package:wordspace/features/user/domain/usecases/get_user.dart';
import 'package:wordspace/features/user/domain/usecases/login_usecase.dart';
import 'package:wordspace/features/user/domain/usecases/register_usecase.dart';
import 'package:wordspace/features/user/presentation/cubit/user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core & External
  final cacheHelper = CacheHelper();
  await cacheHelper.init();

  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<CacheHelper>(() => cacheHelper);
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: sl(), cacheHelper: sl()),
  );

  // User Feature
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(repository: sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(apiConsumer: sl()),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(cache: sl()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      cacheHelper: sl(),
    ),
  );
  sl.registerLazySingleton<GetUser>(
    () => GetUser(repository: sl()),
  );
  sl.registerFactory<UserCubit>(
    () => UserCubit(
      registerUseCase: sl(),
      loginUseCase: sl(),
      getUser: sl(),
      userLocalDataSource: sl(),
      cacheHelper: sl(),
    ),
  );

  // Profile Feature
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(api: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<GetProfileStatsUseCase>(
    () => GetProfileStatsUseCase(repository: sl()),
  );
  sl.registerFactory(() => ProfileCubit(getProfileStatsUseCase: sl()));

  // Post Feature
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(api: sl()),
  );
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<GetPostsUseCase>(
    () => GetPostsUseCase(repository: sl()),
  );
  sl.registerFactory<PostCubit>(
    () => PostCubit(
      getPostsUseCase: sl(),
    ),
  );

  // Likes Feature
  sl.registerLazySingleton<LikeLocalDataSource>(
    () => LikeLocalDataSourceImpl(cache: sl()),
  );
  sl.registerLazySingleton<LikeRepository>(
    () => LikeRepositoryImpl(likeLocalDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetFavoritePostsUseCase(likeRepository: sl()));
  sl.registerLazySingleton(() => IsFavoriteUseCase(likeRepository: sl()));
  sl.registerLazySingleton(
      () => RemoveFavoritePostUseCase(likeRepository: sl()));
  sl.registerLazySingleton(() => SaveFavoritePostUseCase(likeRepository: sl()));

  sl.registerFactory<LikeCubit>(
    () => LikeCubit(
      getFavoritePostsUseCase: sl(),
      isFavoriteUseCase: sl(),
      removeFavoritePostUseCase: sl(),
      saveFavoritePostUseCase: sl(),
    ),
  );
}