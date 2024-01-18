import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../screens/security personnel/security_bttmbar.dart';

Future<void> MvoAdd(context, int homeownerId, String contactNumber, String destinationPerson, List visitMembers) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int id = prefs.getInt('id') ?? 0;
    String host = dotenv.get("API_HOST", fallback: "");
    String addMvo = dotenv.get("MANUALLY_ADD_MVO", fallback: "");
    final url = '$host$addMvo';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        'homeowner_id': homeownerId.toString(),
        'personnel_id': id.toString(),
        'contact_number': contactNumber,
        'destination_person': destinationPerson,
        "visit_members": visitMembers.toString()
      },
    );

    if (response.statusCode == 200) {
      // Successful request
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SecurityPersonnelBottomBar()),
            (route) => false,
      );
    } else if (response.statusCode == 403) {
      // Forbidden: Access denied
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      print("Access denied. You don't have permission to perform this action.");
    } else {
      // Other error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: ${response.statusCode}'),
        ),
      );
      print("Error: ${response.statusCode}");
      print(response.body);
      throw Exception('An error occurred');
    }
  } catch (e, stackTrace) {
    // Show a SnackBar for exceptions
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('An error occurred: No internet connection'),
      ),
    );
    print('An error occurred: $e');
    throw Exception('An error occurred: No internet connection');
  }
}
