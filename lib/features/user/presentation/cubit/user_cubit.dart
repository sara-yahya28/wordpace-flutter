import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/core/databases/cache/cache_helper.dart';
import 'package:wordspace/features/user/data/datasources/user_local_data_source.dart';
import 'package:wordspace/features/user/domain/usecases/get_user.dart';
import 'package:wordspace/features/user/domain/usecases/login_usecase.dart';
import 'package:wordspace/features/user/domain/usecases/register_usecase.dart';
import 'package:wordspace/features/user/presentation/cubit/user_state.dart';
import '../../../../core/params/params.dart';

/*
لا تصنع UserRepositoryImpl ولا Dio ولا CacheHelper، لأن كل هذه الأشياء قد تم إنشاؤها مسبقاً في مكان آخر (في init.dart) ثم تم تمريرها إلى getUser، ثم getUser تم تمريره إلى UserCubit عبر Constructor.

 */

class UserCubit extends Cubit<UserState> {
  CacheHelper cacheHelper;
  UserLocalDataSource userLocalDataSource;
  RegisterUseCase registerUseCase;
  LoginUseCase loginUseCase;
  GetUser getUser;

  UserCubit({
    required this.registerUseCase,
    required this.userLocalDataSource,
    required this.cacheHelper,
    required this.loginUseCase,
    required this.getUser,
  }) : super(UserInitial());

// get user
  Future<void> getUserById(int id) async {
    emit(UserLoading());
    final result = await getUser.call(
      params: UserParams(
        id: id.toString(),
      ),
    );

    result.fold(
      (failure) => emit(UserError(errMessage: failure.errMessage)),
      (user) => emit(UserLoaded(user: user)),
    );
  }

// login
  Future<void> login(String email, String password) async {
    emit(UserLoading());
    final result =
        await loginUseCase.call(LoginParams(email: email, password: password));

    result.fold(((failure) => emit(UserError(errMessage: failure.errMessage))),
        (auth) => emit(UserLoaded(user: auth.user.toEntity())));
  }

  Future<void> register(String name, String email, String password,
      String passwordConfirmation) async {
    emit(UserLoading());
    final result = await registerUseCase.call(RegisterParams(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation));

    result.fold((failure) => emit(UserError(errMessage: failure.errMessage)),
        (auth) => emit(UserLoaded(user: auth.user.toEntity())));
  }

  // Logout
  Future<void>logout() async{
await cacheHelper.removeData(key:'token');
 await userLocalDataSource.clearUser();
 emit(UserInitial());
  }
}
