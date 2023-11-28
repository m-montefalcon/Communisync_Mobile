import 'dart:convert';

import 'package:communisyncmobile/screens/visitor/visitor_get_verified_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<void> verificationExisting(context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    int id = prefs.getInt('id') ?? 0; // Use 0 as the default value

    String host = dotenv.get("API_HOST", fallback: "");
    String checkIfVerifiedApi = dotenv.get("CHECKS_VERIFICATION_STATUS_API", fallback: "");
    final url = '$host$checkIfVerifiedApi$id';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {

      // Parse the response body
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data['message'];





      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>  const GetVerifiedVisitor(),
        ),

      );
    }
    if (response.statusCode == 410) {

      // Parse the response body
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data['message'];

      ScaffoldMessenger.of(context).showSnackBar(buildErrorSnackBar(message));


      // Use the message as needed in your code
    }
    if (response.statusCode == 403) {

      // Parse the response body
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data['message'];

      // Print the message
      ScaffoldMessenger.of(context).showSnackBar(buildErrorSnackBar(message));

      // Use the message as needed in your code
    }


  } catch (e, stackTrace) {
    print('An error occurred: $e');
    print(stackTrace);
  }
}
SnackBar buildErrorSnackBar(String errorMessage) {
  return SnackBar(
    content: Text(errorMessage),
    backgroundColor: Colors.red,
  );
}
