import 'package:communisyncmobile/backend/model/models.dart'; // Import your model
import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_profile_page.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_bttmbar.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_dashboard.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart'; // Import the 'path' package to work with file paths

Future<void> UpdateProfile(
    BuildContext context,
    String userName,
    String firstName,
    String lastName,
    String email,
    String contactNumber,

    ) async {
  try {
    String host = dotenv.get("API_HOST", fallback: "");
    String updateProfileAsHomeowner = dotenv.get("UPDATE_PROFILE_AS_HOMEOWNER", fallback: "");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int id = prefs.getInt('id') ?? 0;
    final url = '$host$updateProfileAsHomeowner$id';
    final response = await http.put(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'user_name': userName,
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'contact_number': contactNumber,
        }
    );


    if (response.statusCode == 200) {
      print('successful');

      // Print the message
      print(' ${response.statusCode}');
      print(' ${response.body}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SecurityPersonnelBottomBar()),
      );


    } else {
      print('Error: ${response.statusCode}');
      throw Exception('Server responded with status ${response.statusCode}');

    }
  } catch (e, stackTrace) {
    print('An error occurred: $e');
    print(stackTrace);
    throw Exception('An error occurred $e');
  }
}
