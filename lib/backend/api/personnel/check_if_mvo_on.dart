

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../../model/models.dart';

Future<List<Homeowner>> checksIfMvoOn(String fullName) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    String host = dotenv.get("API_HOST", fallback: "");
    String checkMvoOn = dotenv.get("CHECK_IF_MVO_ON", fallback: "");
    final url = '$host$checkMvoOn';

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
      final List<dynamic> jsonResponse = json.decode(response.body)['user'];

      List<Homeowner> homeowners = jsonResponse.map((userJson) {
        List<String>? familyMember = [];

        if (userJson.containsKey('family_member')) {
          dynamic familyMemberJson = userJson['family_member'];

          if (familyMemberJson != null) {
            if (familyMemberJson is String) {
              familyMember = List<String>.from(json.decode(familyMemberJson));
            } else if (familyMemberJson is List) {
              familyMember = List<String>.from(familyMemberJson);
            }
          }
        }

        return Homeowner(
          id: userJson['id'] as int,
          userName: userJson['user_name'] as String,
          firstName: userJson['first_name'] as String,
          lastName: userJson['last_name'] as String,
          familyMember: familyMember,
        );
      }).toList();



      return homeowners;
    } else {
      throw Exception('An error occurred');

    }
  } catch (e, stackTrace) {
    throw Exception('An error occurred');
  }
}
