
import 'package:communisyncmobile/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';



Future<void> logout(context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String host = dotenv.get("API_HOST", fallback: "");
    String logoutApi = dotenv.get("LOGOUT_API", fallback: "");

    final url = '$host$logoutApi';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print('Logout API status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      // Remove token from shared preferences
      print(token);
      await prefs.remove('token');
      print('Logout successful');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginPage(),
        ),
            (Route<dynamic> route) => false,
      );
    } else {
      print('Logout failed: ${response.body}');
      throw Exception('Logout failed');
    }
  } catch (e, stackTrace) {
    print('An error occurred: $e');
    print(stackTrace);
    throw Exception('An error occurred');
  }
}
