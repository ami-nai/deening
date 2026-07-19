import '../../../../core/error/failures.dart';
import '../../../../core/error/either.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<Either<Failure, AuthEntity>> call({
    required String username,
    required String password,
    String? email,
  }) async {
    return await repository.register(
      username: username,
      password: password,
      email: email,
    );
  }
}


