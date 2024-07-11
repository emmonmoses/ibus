import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String token;
  final int loginStatus;
  final String id;
  final String name;
  final String customer;
  final String username;
  final String role;
  final List<String> permissions;
  final String validFor;
  final String validFrom;
  final String validUpto;

  LoginResponse({
    required this.token,
    required this.loginStatus,
    required this.id,
    required this.name,
    required this.customer,
    required this.username,
    required this.role,
    required this.permissions,
    required this.validFor,
    required this.validFrom,
    required this.validUpto,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['authorization']?['token'] ?? '',
      loginStatus: json['loginStatus'] ?? 0,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      customer: json['customer'] ?? '',
      username: json['username'] ?? '',
      role: json['role'] ?? '',
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      validFor: json['authorization']?['validFor'] ?? '',
      validFrom: json['authorization']?['validFrom'] ?? '',
      validUpto: json['authorization']?['validUpto'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
