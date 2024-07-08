import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  final String username;
  final String password;

  LoginRequest({required this.username, required this.password});

  // A necessary factory constructor for creating a new LoginRequest instance
  // from a map. Pass the map to the generated `_$LoginRequestFromJson()` constructor.
  // The constructor is named after the source class, in this case, LoginRequest.
  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  // A necessary method that converts the instance into a map.
  // The method is named after the source class, in this case, LoginRequest.
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
