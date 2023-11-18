
import 'dart:convert';

import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<void> MvoAdd(context, int homeownerId, String contactNumber, String destinationPerson,List visitMembers) async{
  try{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int id = prefs.getInt('id') ?? 0;
    String host = dotenv.get("API_HOST", fallback: "");
    String addMvo = dotenv.get("MANUALLY_ADD_MVO", fallback: "");
    final url = '$host$addMvo';

    print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        'homeowner_id' : homeownerId.toString(),
        'personnel_id' : id.toString(),
        'contact_number' : contactNumber,
        'destination_person' : destinationPerson,
        "visit_members":visitMembers.toString()
      }
    );
    if (response.statusCode == 200) {
      // Remove token and role from shared preferences
      print(': ${response.body}');
      // Navigate to SecurityBottomBar
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SecurityPersonnelBottomBar()), // Replace with your actual route
            (route) => false, // Remove all previous pages from the navigation stack
      );

    } else {
      print(': ${response.body}');
      throw Exception(Exception);
    }

  }
  catch(e, stackTrace){
    print('An error occurred: $e');
    print(stackTrace);
    throw Exception('An error occurred');
  }

}

