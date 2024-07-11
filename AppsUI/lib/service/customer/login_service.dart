import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Weyeyet/helper/api_endpoint.dart';
import 'package:Weyeyet/model/customer/login_request.dart';
import 'package:Weyeyet/model/customer/login_response.dart';

class LoginService {
  final String _loginUrl = '${ApiEndPoint.main}/v1/customer/login';

  Future<LoginResponse?> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(_loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        var loginResponse = LoginResponse.fromJson(jsonDecode(response.body));

        // Store the user's name and other details in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', loginResponse.username);
        prefs.setString('token', loginResponse.token);
        prefs.setInt('loginStatus', loginResponse.loginStatus);
        prefs.setString('id', loginResponse.id);
        prefs.setString('name', loginResponse.name);
        prefs.setString('customer', loginResponse.customer);
        prefs.setString('role', loginResponse.role);
        prefs.setStringList('permissions', loginResponse.permissions ?? []);
        prefs.setString('validFor', loginResponse.validFor);
        prefs.setString('validFrom', loginResponse.validFrom);
        prefs.setString('validUpto', loginResponse.validUpto);

        return loginResponse;
      } else if (response.statusCode == 400) {
        var errorJson = jsonDecode(response.body);
        var errorMessage = errorJson['message'] ?? 'Login failed. Please try again.';
        throw Exception(errorMessage);
      } else {
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error during login: $e');
      throw Exception('Error during login: $e');
    }
  }

  // Method to get the LoginResponse from shared preferences
  Future<LoginResponse?> getStoredLoginResponse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? token = prefs.getString('token');
    int? loginStatus = prefs.getInt('loginStatus');
    String? id = prefs.getString('id');
    String? name = prefs.getString('name');
    String? customer = prefs.getString('customer');
    String? role = prefs.getString('role');
    List<String>? permissions = prefs.getStringList('permissions');
    String? validFor = prefs.getString('validFor');
    String? validFrom = prefs.getString('validFrom');
    String? validUpto = prefs.getString('validUpto');

    if (username != null &&
        token != null &&
        loginStatus != null &&
        id != null &&
        name != null &&
        customer != null &&
        role != null &&
        permissions != null &&
        validFor != null &&
        validFrom != null &&
        validUpto != null) {
      return LoginResponse(
        token: token,
        loginStatus: loginStatus,
        id: id,
        name: name,
        customer: customer,
        username: username,
        role: role,
        permissions: permissions,
        validFor: validFor,
        validFrom: validFrom,
        validUpto: validUpto,
      );
    }
    return null;
  }
}
