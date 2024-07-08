// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: json['token'] as String,
      loginStatus: json['loginStatus'] as int,
      id: json['id'] as String,
      name: json['name'] as String,
      customer: json['customer'] as String,
      username: json['username'] as String,
      role: json['role'] as String,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      validFor: json['validFor'] as String,
      validFrom: json['validFrom'] as String,
      validUpto: json['validUpto'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'loginStatus': instance.loginStatus,
      'id': instance.id,
      'name': instance.name,
      'customer': instance.customer,
      'username': instance.username,
      'role': instance.role,
      'permissions': instance.permissions,
      'validFor': instance.validFor,
      'validFrom': instance.validFrom,
      'validUpto': instance.validUpto,
    };
