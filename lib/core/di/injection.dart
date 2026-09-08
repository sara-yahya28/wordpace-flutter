import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordspace/core/databases/api/api_consumer.dart';
import 'package:wordspace/core/databases/api/dio_consumer.dart';
import 'package:wordspace/core/connection/network_info.dart';
import 'package:wordspace/core/databases/cache/cache_helper.dart';
import 'package:wordspace/features/user/data/datasources/user_local_data_source.dart';
import 'package:wordspace/features/user/data/datasources/user_remote_data_source.dart';
import 'package:wordspace/features/user/data/repositories/user_repository_impl.dart';
import 'package:wordspace/features/user/domain/repositories/user_repository.dart';
import 'package:wordspace/features/user/domain/usecases/get_user.dart';
import 'package:wordspace/features/user/domain/usecases/login_usecase.dart';
import 'package:wordspace/features/user/domain/usecases/register_usecase.dart';
import 'package:wordspace/features/user/presentation/cubit/user_cubit.dart';
import '../../features/profile/data/datasources/profile_remote_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/get_profile_stats_usecase.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefs);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<LoginUseCase>(()=>LoginUseCase(repository: sl()));
  sl.registerLazySingleton<RegisterUseCase>(()=>RegisterUseCase(repository:sl()));

sl.registerLazySingleton<CacheHelper>(() => CacheHelper(sharedPreferences: sl()));  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: sl(), cacheHelper: sl()),
  );

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
// factory for cubit= since its always needs to be created
sl.registerFactory<UserCubit>(()=>UserCubit(
  registerUseCase: sl(),
   loginUseCase: sl(),
    getUser: sl(), userLocalDataSource: sl(), cacheHelper: sl()));


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

  // post feature
  // sl.registerLazySingleton<PostRemoteDataSource>(
  //   () => PostRemoteDataSourceImpl(api: sl()),
  // );

  // sl.registerLazySingleton<PostRepository>(
  //   () => PostRepositoryImpl(
  //     remoteDataSource: sl(),
  //   ),
  // );

  // sl.registerLazySingleton<GetPostsUseCase>(
  //   () => GetPostsUseCase(repository: sl()),
  // );

  // sl.registerFactory<PostCubit>(
  //   () => PostCubit(
  //     getPostsUseCase: sl(),
  //   ),
  // );
}