import 'dart:convert';
import 'dart:io';
import 'package:communisyncmobile/screens/login_page.dart';
import 'package:communisyncmobile/screens/visitor/visitor_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> registerUser(
    context,
    String userName,
    String firstName,
    String lastName,
    String contactNumber,
    String email,
    String password,
    String photoPath
    ) async {
  try {
    String host = dotenv.get("API_HOST", fallback: "");
    String registerApi = dotenv.get("REGISTER_API", fallback: "");
    final url = ('$host$registerApi');
    print("URL: $url");

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Accept'] = 'application/json';

    // Add fields as parts
    request.fields['user_name'] = userName;
    request.fields['email'] = email;
    request.fields['first_name'] = firstName;
    request.fields['last_name'] = lastName;
    request.fields['contact_number'] = contactNumber;
    request.fields['password'] = password;

    // Add photo as a part
    // Read the photo file as bytes
    File photoFile = File(photoPath);
    List<int> photoBytes = await photoFile.readAsBytes();

    // Add the photo file as a part
    request.files.add(http.MultipartFile.fromBytes('photo', photoBytes, filename: 'photo.jpg'));

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Login successful');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
      );
    } else {
      final responseBody = await response.stream.bytesToString();
      final errorMessage = jsonDecode(responseBody)['message'];
      throw errorMessage;
    }
  } catch (e) {
    print("Exception caught in registerUser: $e");
    throw (e);
  }
}
