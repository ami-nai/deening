import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/recover_usecase.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'auth_provider.g.dart';

// Provider for secure storage
final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage();
});

// Provider for API client
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

// Provider for remote data source
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRemoteDataSourceImpl(dio: apiClient.dio);
});

// Provider for repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource: remoteDataSource);
});

// Usecase providers
final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterUseCase(repository: repository);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository: repository);
});

final recoverUseCaseProvider = Provider<RecoverUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RecoverUseCase(repository: repository);
});

// Auth state notifier
@riverpod
class AuthNotifier extends _$AuthNotifier {
  late SecureStorage _secureStorage;

  @override
  FutureOr<AuthEntity?> build() async {
    _secureStorage = ref.watch(secureStorageProvider);
    // Try to restore auth from storage
    return null;
  }

  Future<void> register({
    required String username,
    required String password,
    String? email,
  }) async {
    state = const AsyncValue.loading();
    final usecase = ref.read(registerUseCaseProvider);

    final result = await usecase(
      username: username,
      password: password,
      email: email,
    );

    result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return null;
      },
      (auth) {
        _saveAuth(auth);
        state = AsyncValue.data(auth);
        return null;
      },
    );
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final usecase = ref.read(loginUseCaseProvider);

    final result = await usecase(
      username: username,
      password: password,
    );

    result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return null;
      },
      (auth) {
        _saveAuth(auth);
        state = AsyncValue.data(auth);
        return null;
      },
    );
  }

  Future<void> recover({required String email}) async {
    final usecase = ref.read(recoverUseCaseProvider);
    await usecase(email: email);
  }

  Future<void> logout() async {
    await _secureStorage.clearAll();
    state = const AsyncValue.data(null);
  }

  void _saveAuth(AuthEntity auth) {
    _secureStorage.saveAccessToken(auth.accessToken);
    _secureStorage.saveRefreshToken(auth.refreshToken);
    _secureStorage.saveUserId(auth.id);
    _secureStorage.saveUsername(auth.username);
  }
}


