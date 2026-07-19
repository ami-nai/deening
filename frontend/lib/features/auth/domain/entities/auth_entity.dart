import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String id;
  final String username;
  final String? email;
  final String accessToken;
  final String refreshToken;

  const AuthEntity({
    required this.id,
    required this.username,
    this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [id, username, email, accessToken, refreshToken];
}

class UserEntity extends Equatable {
  final String id;
  final String username;
  final String? email;
  final bool hasRecoveryEmail;

  const UserEntity({
    required this.id,
    required this.username,
    this.email,
    required this.hasRecoveryEmail,
  });

  @override
  List<Object?> get props => [id, username, email, hasRecoveryEmail];
}
