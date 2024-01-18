

import 'package:communisyncmobile/screens/root_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


import 'package:shared_preferences/shared_preferences.dart';

Future<void> logout(context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String host = dotenv.get("API_HOST", fallback: "");
    String logoutApi = dotenv.get("LOGOUT_API", fallback: "");
    String role = prefs.getString('role') ?? '';
    int id = prefs.getInt('id') ?? 0;

    final url = '$host$logoutApi';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Remove token and role from shared preferences
      await prefs.remove('token');
      await prefs.remove('role');
      await prefs.remove('id');
      // await prefs.remove('fcm_token');

      // Unsubscribe from Firebase Messaging topics
      FirebaseMessaging.instance.unsubscribeFromTopic('role_$role');
      FirebaseMessaging.instance.unsubscribeFromTopic('id_$id');

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const RootPage(),
        ),
            (Route<dynamic> route) => false,
      );
    } else {
      throw Exception('Logout failed');
    }
  } catch (e, stackTrace) {
    throw Exception('An error occurred: No internet connection');
  }
}
