import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/auth_entity.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel {
  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  final String username;

  final String? id;

  AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.username,
    this.id,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);

  AuthEntity toEntity() {
    return AuthEntity(
      id: id ?? '',
      username: username,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}

@JsonSerializable()
class UserResponseModel {
  final String id;
  final String username;
  final String? email;

  @JsonKey(name: 'has_recovery_email')
  final bool hasRecoveryEmail;

  UserResponseModel({
    required this.id,
    required this.username,
    this.email,
    required this.hasRecoveryEmail,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);
}
