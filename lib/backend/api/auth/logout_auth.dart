
import 'package:communisyncmobile/main.dart';
import 'package:communisyncmobile/screens/login_page.dart';
import 'package:communisyncmobile/screens/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

  // Future<void> logout(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   // Check if token exists
  //   if (prefs.containsKey('token')) {
  //     // Remove the token from shared preferences
  //
  //     await prefs.remove('token');
  //     print('Logout successful');
  //   } else {
  //     print('No token found');
  //   }
  //
  //   // Remove user role from shared preferences (if any)
  //   if (prefs.containsKey('role')) {
  //     await prefs.remove('role');
  //   }
  //
  //   // After token removal, redirect the user to the login page
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(
  //       builder: (BuildContext context) => const RootPage(),
  //     ),
  //         (Route<dynamic> route) => false,
  //   );
  // }

// Future<void> logout(context) async {
//   try {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString('token') ?? '';
//     String host = dotenv.get("API_HOST", fallback: "");
//     String logoutApi = dotenv.get("LOGOUT_API", fallback: "");
//
//     final url = '$host$logoutApi';
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );
//     print('Logout API status code: ${response.statusCode}');
//
//     if (response.statusCode == 200) {
//       // Remove token from shared preferences
//       print(token);
//       await prefs.remove('token');
//       print('Logout successful');
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (BuildContext context) => LoginPage(),
//         ),
//             (Route<dynamic> route) => false,
//       );
//     } else {
//       print('Logout failed: ${response.body}');
//       throw Exception('Logout failed');
//     }
//   } catch (e, stackTrace) {
//     print('An error occurred: $e');
//     print(stackTrace);
//     throw Exception('An error occurred');
//   }
// }


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
      // Remove token and role from shared preferences
      await prefs.remove('token');
      await prefs.remove('role');
      print('Logout successful');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const RootPage(),
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
