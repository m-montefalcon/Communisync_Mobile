import 'dart:convert';
import 'package:communisyncmobile/screens/login_page.dart';
import 'package:communisyncmobile/screens/visitor/visitor_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> registerUser(
    context,
    String userName,
    String firstName,
    String lastName,
    String contactNumber,
    String email,
    String password,
    ) async {
  try {
    String host = dotenv.get("API_HOST", fallback: "");
    String registerApi = dotenv.get("REGISTER_API", fallback: "");
    final url = ('$host$registerApi');
    print("URL: $url");
    final response = await http.post(
      Uri.parse(url),
      body: {
        'user_name': userName,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'contact_number': contactNumber,
        'password': password,
      },
      headers: {'Accept': 'application/json'},
    );
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      print('Login successful');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
      );
    } else {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'];
      throw (errorMessage);
    }
  } catch (e) {
    print("Exception caught in registerUser: ");
    throw (e);
  }
}
