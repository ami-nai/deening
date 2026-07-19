import 'package:dio/dio.dart';
import 'package:frontend/core/constants/api_constants.dart';
import '../constants/app_constants.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import '../storage/secure_storage.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();

  late final Dio _dio;
  late final SecureStorage _secureStorage;

  factory ApiClient({SecureStorage? secureStorage}) {
    if (secureStorage != null) {
      _instance._secureStorage = secureStorage;
    }
    return _instance;
  }

  ApiClient._internal();

  Future<void> init({SecureStorage? secureStorage}) async {
    _secureStorage = secureStorage ?? SecureStorage();

    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        contentType: 'application/json',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Add interceptors
    _dio.interceptors.add(ErrorInterceptor());
    _dio.interceptors.add(
      AuthInterceptor(
        secureStorage: _secureStorage,
        dio: _dio,
      ),
    );
  }

  Dio get dio => _dio;

  SecureStorage get secureStorage => _secureStorage;
}
