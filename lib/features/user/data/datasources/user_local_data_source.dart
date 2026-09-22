import 'dart:convert';
import 'package:wordspace/core/errors/expentions.dart';
import 'package:wordspace/features/user/data/models/user_model.dart';
import '../../../../core/databases/cache/cache_helper.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel> getLastUser();
  Future<void> clearUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final CacheHelper cache;
  final String key = "CachedUser";

  UserLocalDataSourceImpl({required this.cache});

  @override
  Future<void> cacheUser(UserModel user) async {
    await cache.saveData(
      key: key,
      value: json.encode(user.toJson()),
    );
  }

  @override
  Future<UserModel> getLastUser() async {
    final jsonString = cache.getDataString(key: key);
    if (jsonString != null) {
      return UserModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException(errorMessage: "لا يوجد مستخدم مخبأ");
    }
  }

  @override
  Future<void> clearUser() async {
    await cache.removeData(key: key);
  }
}