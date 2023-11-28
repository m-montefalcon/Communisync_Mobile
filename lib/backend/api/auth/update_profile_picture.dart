
import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_bttmbar.dart';
import 'package:communisyncmobile/screens/visitor/visitor_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import 'dart:io';


Future<void> updateProfilePicture(context, String photoPath) async {
  try {
    // Verify that the photoPath is not empty or null
    if (photoPath == null || photoPath.isEmpty) {
      return;
    }

    // Check if the file at the specified path exists
    File imageFile = File(photoPath);
    if (!imageFile.existsSync()) {
      return;
    }

    String host = dotenv.get("API_HOST", fallback: "");
    String updateProfilePicture = dotenv.get("UPDATE_PROFILE_PICTURE", fallback: "");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int id = prefs.getInt('id') ?? 0;
    String role = prefs.getString('role') ?? '';

    final url = '$host$updateProfilePicture$id'; // Ensure you have the correct URL structure

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';
    request.headers['Content-Type'] = 'multipart/form-data'; // Not necessary
    File photoFile = File(photoPath);
    List<int> photoBytes = await photoFile.readAsBytes();

    // Add the photo file as a part
    request.files.add(http.MultipartFile.fromBytes('photo', photoBytes, filename: 'photo.jpg'));


    var response = await request.send();

    if (response.statusCode == 200) {


      if(role == '3' || role == '4'){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SecurityPersonnelBottomBar()),
        );
      }

      else if(role == '2'){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeownerBottomNavigationBar()),
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
  } catch (e) {
    throw ('An error occurred');
  }
}
