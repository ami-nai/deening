// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseModel _$AuthResponseModelFromJson(Map<String, dynamic> json) =>
    AuthResponseModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      username: json['username'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$AuthResponseModelToJson(AuthResponseModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'username': instance.username,
      'id': instance.id,
    };

UserResponseModel _$UserResponseModelFromJson(Map<String, dynamic> json) =>
    UserResponseModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String?,
      hasRecoveryEmail: json['has_recovery_email'] as bool,
    );

Map<String, dynamic> _$UserResponseModelToJson(UserResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'has_recovery_email': instance.hasRecoveryEmail,
    };
