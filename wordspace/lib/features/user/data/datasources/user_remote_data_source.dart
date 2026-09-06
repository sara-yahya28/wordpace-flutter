import 'package:wordspace/core/databases/api/api_consumer.dart';
import 'package:wordspace/core/databases/api/end_points.dart';
import 'package:wordspace/features/user/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser(); 
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiConsumer api;

  UserRemoteDataSourceImpl({required this.api});

  @override
  Future<UserModel> getUser() async {
    final response = await api.get(EndPoints.user);
    final userData = response[ApiKeys.data];
    return UserModel.fromJson(userData);
  }
}