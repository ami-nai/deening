import 'package:dio/dio.dart';
import 'package:frontend/core/constants/api_constants.dart';
import '../../constants/app_constants.dart';
import '../../storage/secure_storage.dart';
import '../../error/exceptions.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorage _secureStorage;
  final Dio _dio;

  bool _isRefreshing = false;
  final List<RequestInterceptorHandler> _retryQueue = [];

  AuthInterceptor({
    required SecureStorage secureStorage,
    required Dio dio,
  })  : _secureStorage = secureStorage,
        _dio = dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Check if 401 and not already refreshing
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;

      try {
        final refreshToken = await _secureStorage.getRefreshToken();

        if (refreshToken == null || refreshToken.isEmpty) {
          // No refresh token, clear and reject
          await _secureStorage.clearAll();
          return handler.reject(err);
        }

        // Attempt token refresh
        final response = await _dio.post(
          ApiConstants.authRefresh,
          data: {'refresh_token': refreshToken},
        );

        if (response.statusCode == 200) {
          final newAccessToken = response.data['access_token'];
          final newRefreshToken = response.data['refresh_token'];

          await _secureStorage.saveAccessToken(newAccessToken);
          await _secureStorage.saveRefreshToken(newRefreshToken);

          // Retry original request
          final retryResponse = await _retry(err.requestOptions);
          return handler.resolve(retryResponse);
        }
      } catch (e) {
        // Refresh failed, clear and reject
        await _secureStorage.clearAll();
        return handler.reject(err);
      } finally {
        _isRefreshing = false;
      }
    }

    return handler.next(err);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
