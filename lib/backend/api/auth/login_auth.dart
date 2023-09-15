import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> loginUser(String email, String password) async {
  try {
    String loginApi = dotenv.get("API_HOST", fallback: "");
    final url = ('$loginApi/api/login/store/mobile');
    final response = await http.post(
      Uri.parse(url),
      body: {
        'user_name': email,
        'password': password,
      },
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      // Retrieve the token from the response data
      String token = responseData['token'];

      if (token != null) {
        print('Login successful');
        print('Token: $token');
      } else {
        // Token not found in the response data
        print('Token not found in the response data');
      }
    } else {
      // Login failed
      print('Login failed');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}
