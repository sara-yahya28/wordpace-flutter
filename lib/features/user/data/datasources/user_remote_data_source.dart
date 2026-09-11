import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/params/params.dart';
import '../models/auth_model.dart';
import '../models/user_model.dart'; 

class UserRemoteDataSource {
  final ApiConsumer apiConsumer;

  UserRemoteDataSource({required this.apiConsumer});

  Future<UserModel> getUser(UserParams params) async {
    final response = await apiConsumer.get('${EndPoints.user}/${params.id}');
    return UserModel.fromJson(response);
  }

  Future<AuthModel> login(LoginParams params) async {
    final response = await apiConsumer.post(
      EndPoints.login, 
      data: {
        ApiKeys.email: params.email,  
        ApiKeys.password: params.password,
      },
    );
    return AuthModel.fromJson(response);
  }

  Future<AuthModel> register(RegisterParams params) async {
    final response = await apiConsumer.post(
      EndPoints.register, 
      data: {
        ApiKeys.name: params.name,
        ApiKeys.email: params.email,
        ApiKeys.password: params.password,
        ApiKeys.passwordConfirmation: params.passwordConfirmation,
      },
    );
    return AuthModel.fromJson(response);
  }
}

/*
What Was Done
METHODS:
   - getUser(UserParams): Fetches user data from /user/{id}.
   - login(LoginParams): Sends POST to /login, returns AuthModel.
   - register(RegisterParams): Sends POST to /register, returns AuthModel.

   HOW IT WORKS:
   - Uses ApiConsumer (abstract) for HTTP calls.
   - Uses EndPoints for URLs and ApiKeys for request fields.
   - Converts responses using AuthModel.fromJson / UserModel.fromJson.

 */