
import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../screens/security personnel/security_bttmbar.dart';
import '../../../screens/visitor/visitor_bttmbar.dart';


Future<void> submitChangePassword(context, String currentPassword, String newPassword) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int id = prefs.getInt('id') ?? 0;
    String host = dotenv.get("API_HOST", fallback: "");
    String role = prefs.getString('role') ?? '';

    String changePasswordRequest = dotenv.get("CHANGE_PASSWORD", fallback: "");
    final url = '$host$changePasswordRequest';

    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        "homeowner_id": id.toString(),
        "current_password": currentPassword,
        "new_password": newPassword,
      },
    );

    if (response.statusCode == 200) {
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
    } else if (response.statusCode == 400) {
      // Display error message as a SnackBar
      final snackBar = SnackBar(
        content: Text('Current password is incorrect'),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (response.statusCode == 401) {
      // Display error message as a SnackBar
      final snackBar = SnackBar(
        content: Text('Current password and new password should not be the same'),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      // Display error message as a SnackBar
      final snackBar = SnackBar(
        content: Text('Error: ${response.body}'),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  } catch (e, stackTrace) {
    // Display error message as a SnackBar
    final snackBar = SnackBar(
      content: Text('An error occurred: No internet connection'),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
