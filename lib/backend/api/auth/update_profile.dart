
import 'package:communisyncmobile/screens/security%20personnel/security_bttmbar.dart';
import 'package:communisyncmobile/screens/visitor/visitor_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


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
    String role = prefs.getString('role') ?? '';

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


      if(role == '3' || role == '4'){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SecurityPersonnelBottomBar()),
        );
      }
      else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VisitorBottombar()),
        );
      }



    } else {
      throw Exception('An error occurred');

    }
  } catch (e, stackTrace) {
    throw Exception('An error occurred');
  }
}
