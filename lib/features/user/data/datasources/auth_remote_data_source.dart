import 'package:dio/dio.dart';
import 'package:wordspace/features/user/data/models/auth_model.dart';
import 'package:wordspace/core/databases/api/end_points.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String password, String email);
  Future<AuthModel> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<AuthModel> login(String password, String email) async {
    try {
      final response = await _dio.post('${EndPoints.baseUrl}${EndPoints.login}',
          data: {ApiKeys.email: email, ApiKeys.password: password});

      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = e.response?.data[ApiKeys.message] ?? 'Login Failed';
      throw Exception(errorMessage);
    }
  }

  @override
  Future<AuthModel> register(
      {required String name,
      required String email,
      required String password,
      required String passwordConfirmation}) async {
    try {
      final response = await _dio.post(
        '${EndPoints.baseUrl}${EndPoints.register}',
        data: {
          ApiKeys.name: name,
          ApiKeys.email: email,
          ApiKeys.password: password,
          ApiKeys.passwordConfirmation: passwordConfirmation
        },
      );
      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data[ApiKeys.message] ?? 'Register Failed';
      throw Exception(errorMessage);
    }
  }
}

/* What Was Done
 *sends post requsets -> endpoints.login/registed
 *Request body uses ApiKeys (email, password, name, etc.)
 *On success: response → AuthModel via fromJson().
*On failure: catches DioException → throws Exception with message.
 */
