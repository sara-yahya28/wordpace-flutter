import 'package:dio/dio.dart';
import 'package:wordspace/core/errors/error_model.dart';

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
class CofficientException extends ServerException { // قد يكون ConflictException
  CofficientException(super.errorModel);
}
class CancelException extends ServerException {
  CancelException(super.errorModel);
}
class UnknownException extends ServerException {
  UnknownException(super.errorModel);
}

ServerException handleDioException(DioException e) {
  String message = 'حدث خطأ غير معروف. يرجى المحاولة لاحقاً.';

// Read data from response
  if (e.response != null && e.response?.data != null) {
    final data = e.response!.data;
    if (data is Map<String, dynamic>) {
// laravel validation is read
      if (data.containsKey('errors') && data['errors'] is Map) {
        final errors = data['errors'] as Map;
        final errorMessages = <String>[];
        errors.forEach((key, value) {
          if (value is List) {
            errorMessages.addAll(value.map((e) => e.toString()));
          } else if (value is String) {
            errorMessages.add(value);
          } else {
            errorMessages.add(value.toString());
          }
        });
        if (errorMessages.isNotEmpty) {
          message = errorMessages.join(', ');
        }
      }

      else if (data.containsKey('message')) {
        message = data['message'].toString();
      }
// if error
      else if (data.containsKey('error')) {
        message = data['error'].toString();
      }
    }
  } else {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return ConnectionTimeoutException(
        ErrorModel(message: 'انتهت مهلة الاتصال. تأكد من اتصالك بالإنترنت.')
      );
    } else if (e.type == DioExceptionType.connectionError) {
      return ConnectionErrorException(
        ErrorModel(message: 'لا يوجد اتصال بالإنترنت. تأكد من اتصالك.')
      );
    } else if (e.type == DioExceptionType.cancel) {
      return CancelException(
        ErrorModel(message: 'تم إلغاء الطلب.')
      );
    }
    return UnknownException(
      ErrorModel(message: e.message ?? 'خطأ غير معروف في الاتصال.')
    );
  }

  final statusCode = e.response?.statusCode;
  
  switch (statusCode) {
    case 400:
      return BadResponseException(
        ErrorModel(message: message) 
      );
    case 401:
      return UnauthorizedException(
        ErrorModel(message: message)
      );
    case 403:
      return ForbiddenException(
        ErrorModel(message: message)
      );
    case 404:
      return NotFoundException(
        ErrorModel(message: message)
      );
    case 409:
      return CofficientException(
        ErrorModel(message: message)
      );
    case 422:
      return BadResponseException(
        ErrorModel(message: message)
      );
    default:
      if (statusCode != null && statusCode >= 500) {
        return ServerException(
          ErrorModel(message: 'حدث خطأ في السيرفر الداخلي. حاول مرة أخرى لاحقاً.')
        );
      }
      return ServerException(
        ErrorModel(message: message)
      );
  }
}