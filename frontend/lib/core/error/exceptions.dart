class AppException implements Exception {
  final String message;
  final String? code;

  AppException({required this.message, this.code});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException({required super.message, super.code});
}

class ServerException extends AppException {
  ServerException({required super.message, super.code});
}

class UnauthorizedException extends AppException {
  UnauthorizedException({required super.message, super.code});
}

class ValidationException extends AppException {
  ValidationException({required super.message, super.code});
}
