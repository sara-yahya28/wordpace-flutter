abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });
}

/*
What Was Done
API CONSUMER & DIO CONSUMER
WHAT:
   - Abstract interface (ApiConsumer) defines HTTP methods (get, post, patch, delete).
   - Implementation (DioConsumer) uses Dio to execute requests.

   FEATURES:
   - Handles baseUrl setup.
   - Converts data to FormData when needed.
   - Catches DioException and throws custom exceptions via handleDioException.

 */
