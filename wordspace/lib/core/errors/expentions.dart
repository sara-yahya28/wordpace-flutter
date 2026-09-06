import 'package:dio/dio.dart';
import 'package:wordspace/core/errors/error_model.dart';

// === الاستثناءات الأساسية ===
class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException(this.errorModel);
}

class CacheException implements Exception {
  final String errorMessage;
  CacheException({required this.errorMessage});
}

class BadCertificateException extends ServerException {
  BadCertificateException(super.errorModel);
}

class ConnectionErrorException extends ServerException {
  ConnectionErrorException(super.errorModel);
}

class ConnectionTimeoutException extends ServerException {
  ConnectionTimeoutException(super.errorModel);
}

class ReceiveTimeoutException extends ServerException {
  ReceiveTimeoutException(super.errorModel);
}

class SendTimeoutException extends ServerException {
  SendTimeoutException(super.errorModel);
}

class BadResponseException extends ServerException {
  BadResponseException(super.errorModel);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException(super.errorModel);
}

class ForbiddenException extends ServerException {
  ForbiddenException(super.errorModel);
}

class NotFoundException extends ServerException {
  NotFoundException(super.errorModel);
}

class CofficientException extends ServerException {
  CofficientException(super.errorModel);
}

class CancelException extends ServerException {
  CancelException(super.errorModel);
}

class UnknownException extends ServerException {
  UnknownException(super.errorModel);
}

// === دالة معالجة أخطاء Dio ===
void handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      throw ConnectionErrorException(
          ErrorModel.fromJson(e.response?.data ?? {}));
    case DioExceptionType.badCertificate:
      throw BadCertificateException(
          ErrorModel.fromJson(e.response?.data ?? {}));
    case DioExceptionType.connectionTimeout:
      throw ConnectionTimeoutException(
          ErrorModel.fromJson(e.response?.data ?? {}));
    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(
          ErrorModel.fromJson(e.response?.data ?? {}));
    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(
          ErrorModel.fromJson(e.response?.data ?? {}));
    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      final data = e.response?.data ?? {};
      switch (statusCode) {
        case 400:
          throw BadResponseException(ErrorModel.fromJson(data));
        case 401:
          throw UnauthorizedException(ErrorModel.fromJson(data));
        case 403:
          throw ForbiddenException(ErrorModel.fromJson(data));
        case 404:
          throw NotFoundException(ErrorModel.fromJson(data));
        case 409:
          throw CofficientException(ErrorModel.fromJson(data));
        case 422:
          throw BadResponseException(ErrorModel.fromJson(data));
        default:
          throw BadResponseException(ErrorModel(
            message: 'Response failed',
            status: statusCode,
          ));
      }
    case DioExceptionType.cancel:
      throw CancelException(ErrorModel(
        errorMessage: 'Cancel Request',
        status: 500,
      ));
    case DioExceptionType.unknown:
      throw UnknownException(ErrorModel(
        errorMessage: e.message ?? 'Unexpected Error',
        status: 500,
        )
      );
  }
}