sealed class Failure {
  final String message;

  Failure({required this.message});

  @override
  String toString() => message;
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({required super.message});
}

class ValidationFailure extends Failure {
  ValidationFailure({required super.message});
}

class UnknownFailure extends Failure {
  UnknownFailure({required super.message});
}
