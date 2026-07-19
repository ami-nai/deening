import '../../../../core/error/failures.dart';
import '../../../../core/error/either.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, AuthEntity>> call({
    required String username,
    required String password,
  }) async {
    return await repository.login(
      username: username,
      password: password,
    );
  }
}


