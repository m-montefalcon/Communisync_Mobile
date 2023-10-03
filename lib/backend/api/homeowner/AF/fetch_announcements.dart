
import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchAnnouncements()async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String role = prefs.getString('role') ?? '';

    String host = dotenv.get("API_HOST", fallback: "");
    String fetchAnnouncementApi = dotenv.get(
        "FETCH_ANNOUNCEMENT_API", fallback: "");
    final url = '$host$fetchAnnouncementApi$role';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },

    );
    if (response.statusCode == 200) {
      // Remove token and role from shared preferences
      print(': ${response.body}');
    }else{
      throw Exception('not 200');
    }
  }
  catch (e, stackTrace) {
    print('An error occurred: $e');
    print(stackTrace);
    throw Exception('An error occurred');
  }
}