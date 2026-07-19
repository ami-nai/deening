import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/either.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AuthEntity>> register({
    required String username,
    required String password,
    String? email,
  }) async {
    try {
      final model = await remoteDataSource.register(
        username: username,
        password: password,
        email: email,
      );
      return Right<Failure, AuthEntity>(model.toEntity());
    } on UnauthorizedException catch (e) {
      return Left<Failure, AuthEntity>(UnauthorizedFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left<Failure, AuthEntity>(ValidationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left<Failure, AuthEntity>(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left<Failure, AuthEntity>(NetworkFailure(message: e.message));
    } catch (e) {
      return Left<Failure, AuthEntity>(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> login({
    required String username,
    required String password,
  }) async {
    try {
      final model = await remoteDataSource.login(
        username: username,
        password: password,
      );
      return Right<Failure, AuthEntity>(model.toEntity());
    } on UnauthorizedException catch (e) {
      return Left<Failure, AuthEntity>(UnauthorizedFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left<Failure, AuthEntity>(ValidationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left<Failure, AuthEntity>(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left<Failure, AuthEntity>(NetworkFailure(message: e.message));
    } catch (e) {
      return Left<Failure, AuthEntity>(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> recover({required String email}) async {
    try {
      await remoteDataSource.recover(email: email);
      return const Right<Failure, void>(null);
    } on ValidationException catch (e) {
      return Left<Failure, void>(ValidationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left<Failure, void>(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left<Failure, void>(NetworkFailure(message: e.message));
    } catch (e) {
      return Left<Failure, void>(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> reset({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      await remoteDataSource.reset(
        email: email,
        code: code,
        newPassword: newPassword,
      );
      return const Right<Failure, void>(null);
    } on ValidationException catch (e) {
      return Left<Failure, void>(ValidationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left<Failure, void>(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left<Failure, void>(NetworkFailure(message: e.message));
    } catch (e) {
      return Left<Failure, void>(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getMe() async {
    try {
      final model = await remoteDataSource.getMe();
      return Right<Failure, UserEntity>(
        UserEntity(
          id: model.id,
          username: model.username,
          email: model.email,
          hasRecoveryEmail: model.hasRecoveryEmail,
        ),
      );
    } on UnauthorizedException catch (e) {
      return Left<Failure, UserEntity>(UnauthorizedFailure(message: e.message));
    } on ServerException catch (e) {
      return Left<Failure, UserEntity>(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left<Failure, UserEntity>(NetworkFailure(message: e.message));
    } catch (e) {
      return Left<Failure, UserEntity>(UnknownFailure(message: e.toString()));
    }
  }
}
