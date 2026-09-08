import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveData({required String key, required dynamic value}) async {
    print('🔐 Saving data: key=$key, value=$value');

    if (value is String) {
      await sharedPreferences.setString(key, value);
    } else if (value is int) {
      await sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      await sharedPreferences.setBool(key, value);
    } else if (value is double) {
      await sharedPreferences.setDouble(key, value);
    } else {
      await sharedPreferences.setString(key, value.toString());
    }

    // ✅ طباعة بعد الحفظ للتأكد
    print('✅ Data saved successfully for key: $key');
  }

  String? getDataString({required String key}) {
    return sharedPreferences.getString(key);
  }

  bool? getDataBool({required String key}) {
    return sharedPreferences.getBool(key);
  }

  int? getDataInt({required String key}) {
    return sharedPreferences.getInt(key);
  }

  double? getDataDouble({required String key}) {
    return sharedPreferences.getDouble(key);
  }

  Future<void> removeData({required String key}) async {
    await sharedPreferences.remove(key);
  }
}