import 'dart:convert';
import 'package:wordspace/core/errors/expentions.dart';
import 'package:wordspace/features/user/data/models/user_model.dart';
import '../../../../core/databases/cache/cache_helper.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel> getLastUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final CacheHelper cache;
  final String key = "CachedUser";

  UserLocalDataSourceImpl({required this.cache});

  @override
  Future<void> cacheUser(UserModel? user) async {
    if (user != null) {
      await cache.saveData(
        key: key,
        value: json.encode(user.toJson()),
      );
    } else {
      throw CacheException(errorMessage: "لا يمكن تخزين مستخدم فارغ");
    }
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
}