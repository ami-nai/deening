import 'package:dio/dio.dart';
import 'package:frontend/core/constants/api_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> register({
    required String username,
    required String password,
    String? email,
  });

  Future<AuthResponseModel> login({
    required String username,
    required String password,
  });

  Future<void> recover({required String email});

  Future<void> reset({
    required String email,
    required String code,
    required String newPassword,
  });

  Future<UserResponseModel> getMe();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<AuthResponseModel> register({
    required String username,
    required String password,
    String? email,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.authRegister,
        data: {
          'username': username,
          'password': password,
          if (email != null) 'email': email,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: 'Registration failed',
          code: '${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<AuthResponseModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.authLogin,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: 'Login failed',
          code: '${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> recover({required String email}) async {
    try {
      final response = await dio.post(
        ApiConstants.authRecover,
        data: {'email': email},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          message: 'Recovery request failed',
          code: '${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> reset({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.authReset,
        data: {
          'email': email,
          'code': code,
          'new_password': newPassword,
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(
          message: 'Password reset failed',
          code: '${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<UserResponseModel> getMe() async {
    try {
      final response = await dio.get(ApiConstants.authMe);

      if (response.statusCode == 200) {
        return UserResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: 'Failed to fetch user',
          code: '${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  AppException _handleDioException(DioException e) {
    if (e.error is AppException) {
      return e.error as AppException;
    }
    return AppException(message: e.message ?? 'Unknown error');
  }
}
