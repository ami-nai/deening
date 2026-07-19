import '../../../../core/error/failures.dart';
import '../../../../core/error/either.dart';
import '../repositories/auth_repository.dart';

class RecoverUseCase {
  final AuthRepository repository;

  RecoverUseCase({required this.repository});

  Future<Either<Failure, void>> call({
    required String email,
  }) async {
    return await repository.recover(email: email);
  }
}


