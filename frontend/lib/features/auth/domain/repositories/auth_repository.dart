import '../../../../core/error/failures.dart';
import '../../../../core/error/either.dart';
import '../entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> register({
    required String username,
    required String password,
    String? email,
  });

  Future<Either<Failure, AuthEntity>> login({
    required String username,
    required String password,
  });

  Future<Either<Failure, void>> recover({
    required String email,
  });

  Future<Either<Failure, void>> reset({
    required String email,
    required String code,
    required String newPassword,
  });

  Future<Either<Failure, UserEntity>> getMe();
}


