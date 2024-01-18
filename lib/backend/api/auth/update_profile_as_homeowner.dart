import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


Future<void> updateProfileAsHomeowner(
    BuildContext context,
    String profilePicturePath,
    String userName,
    String firstName,
    String lastName,
    String email,
    String contactNumber,
    String blockNo,
    String lotNo,
    bool isManualVisitEnabled,
    List<String> familyMembers,
    ) async {
  try {
    String host = dotenv.get("API_HOST", fallback: "");
    String updateProfileAsHomeowner = dotenv.get("UPDATE_PROFILE_AS_HOMEOWNER", fallback: "");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
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
        'block_no' : blockNo.toString(),
        'lot_no' : lotNo.toString(),
        'manual_visit_option': isManualVisitEnabled ? '1' : '0', // Use a conditional statement
        'family_member' : familyMembers.toString(),
      }
    );


    if (response.statusCode == 200) {


      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeownerBottomNavigationBar()),
      );

    } else {
      throw Exception('An error occurred');

    }
  } catch (e, stackTrace) {
    throw Exception('An error occurred: No internet connection');
  }
}
