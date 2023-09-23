import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:communisyncmobile/screens/root_page.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_bttmbar.dart';
import 'package:communisyncmobile/screens/visitor/visitor_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> loginUser(context, String email, String password) async {
  try {
    String host = dotenv.get("API_HOST", fallback: "");
    String loginApi = dotenv.get("LOGIN_API", fallback: "");
    final url = ('$host$loginApi');
    final response = await http.post(
      Uri.parse(url),
      body: {
        'user_name': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      String token = responseData['token'];
      Map<String, dynamic> user = responseData['user'] as Map<String, dynamic>;
      String role = user['role'];
      int id = user['id'];

      if (token != null && role != null) {
        print('Login successful');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        print('Token: $token');
        print('Role: $role');
        print('ID: $id');


        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('role', role);
        await prefs.setInt('id', id);

        if (role == '1') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const VisitorBottombar()),
                (route) => false,
          );
        } else if (role == '2') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeownerBottomNavigationBar()),
                (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SecurityPersonnelBottomBar()),
                (route) => false,
          );
        }
      } else {
        print('Token or role not found in the response data');
        throw Exception('Invalid API response');
      }
    } else {
      print('Login failed');
      throw Exception('Login failed');
    }
  } catch (e) {
    print('An error occurred: $e');
    throw Exception('An error occurred');
  }
}
