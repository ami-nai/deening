import 'package:dio/dio.dart';
import '../../error/exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _mapException(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        type: err.type,
        response: err.response,
      ),
    );
  }

  AppException _mapException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          message: 'Connection timeout. Please check your internet.',
          code: 'TIMEOUT',
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'No internet connection.',
          code: 'NO_CONNECTION',
        );
      case DioExceptionType.badResponse:
        return _mapStatusCodeException(error.response?.statusCode);
      case DioExceptionType.cancel:
        return AppException(
          message: 'Request cancelled',
          code: 'CANCELLED',
        );
      default:
        return AppException(
          message: error.message ?? 'An error occurred',
          code: 'UNKNOWN',
        );
    }
  }

  AppException _mapStatusCodeException(int? statusCode) {
    switch (statusCode) {
      case 400:
        return ValidationException(
          message: 'Invalid request',
          code: '400',
        );
      case 401:
        return UnauthorizedException(
          message: 'Unauthorized',
          code: '401',
        );
      case 403:
        return UnauthorizedException(
          message: 'Forbidden',
          code: '403',
        );
      case 404:
        return ServerException(
          message: 'Not found',
          code: '404',
        );
      case 500:
      case 502:
      case 503:
        return ServerException(
          message: 'Server error',
          code: '$statusCode',
        );
      default:
        return ServerException(
          message: 'An error occurred',
          code: '$statusCode',
        );
    }
  }
}
