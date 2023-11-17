
import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../../model/models.dart';

Future<Homeowner> checksIfMvoOn(String fullName) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    String host = dotenv.get("API_HOST", fallback: "");
    String checkMvoOn = dotenv.get("CHECK_IF_MVO_ON", fallback: "");
    final url = '$host$checkMvoOn';

    print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        'full_name': fullName,
      },
    );

    if (response.statusCode == 200) {
      // Parse the JSON response manually
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final Map<String, dynamic> userJson = jsonResponse['user'];

      dynamic familyMemberJson = userJson['family_member'];
      List<String>? familyMember;

      if (familyMemberJson != null) {
        if (familyMemberJson is String) {
          // Convert the String to a List if it is a String
          familyMember = List<String>.from(json.decode(familyMemberJson));
        } else if (familyMemberJson is List) {
          // Use the List if it is already a List
          familyMember = List<String>.from(familyMemberJson);
        }
      }

      Homeowner homeowner = Homeowner(
        id: userJson['id'] as int,
        userName: userJson['user_name'] as String,
        firstName: userJson['first_name'] as String,
        lastName: userJson['last_name'] as String,
        familyMember: familyMember,
      );
      // Access homeowner properties
      print('Homeowner ID: ${homeowner.id}');
      print('Homeowner UserName: ${homeowner.userName}');
      print('Homeowner UserName: ${homeowner.familyMember}');
      // ... other properties
      return homeowner;

    } else {
      print(': ${response.body}');
      throw (': ${response.body}');
    }


  } catch (e, stackTrace) {
    print('An error occurred: $e');
    print(stackTrace);
    throw Exception('An error occurred');
  }
}
