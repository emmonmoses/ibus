import 'dart:convert';
import 'package:Weyeyet/model/customer/registeration.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = 'http://196.188.237.130:5051/api/v1/customer';

  Future<bool> registerUser(CustomerRegistration user) async {
    final url = Uri.parse(baseUrl);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(user.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        // Registration successful
        return true;
      } else {
        // Handle other status codes or error responses
        print('Failed to register user: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error occurred while registering user: $e');
      return false;
    }
  }
}
