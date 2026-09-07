import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
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

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefs);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<LoginUseCase>(()=>LoginUseCase(repository: sl()));
  sl.registerLazySingleton<RegisterUseCase>(()=>RegisterUseCase(repository:sl()));

  sl.registerLazySingleton<CacheHelper>(() => CacheHelper());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
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

}