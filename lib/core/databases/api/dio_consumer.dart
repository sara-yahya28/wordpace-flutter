import 'package:dio/dio.dart';
import 'package:wordspace/core/databases/api/api_consumer.dart';
import 'package:wordspace/core/databases/api/end_points.dart';
import 'package:wordspace/core/errors/expentions.dart';
import 'package:wordspace/main.dart' show navigatorKey;
import '../cache/cache_helper.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  final CacheHelper cacheHelper;

  DioConsumer({required this.dio, required this.cacheHelper}) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = cacheHelper.getDataString(key: 'token');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (e, handler) async {
          // ✅ الأهم: عند 401 → امسح التوكن وروح Welcome
          if (e.response?.statusCode == 401) {
            print('🔴 401 - Token منتهي → Auto Logout');
            await cacheHelper.removeData(key: 'token');
            await cacheHelper.removeData(key: 'CachedUser');
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              '/welcome',
              (route) => false,
            );
          }
          return handler.next(e);
        },
      ),
    );
  }

  @override
  Future<dynamic> get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  @override
  Future<dynamic> post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false}) async {
    try {
      final response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  @override
  Future<dynamic> patch(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false}) async {
    try {
      final response = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  @override
  Future<dynamic> delete(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.delete(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }
}