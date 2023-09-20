import 'dart:convert';

import 'package:communisyncmobile/screens/visitor/visitor_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future <void> registerUser(context, String userName, String firstName, String lastName,
    String contactNumber, String email, String password)async {
    try{
      String host = dotenv.get("API_HOST", fallback: "");
      String registerAPi = dotenv.get("REGISTER_API", fallback: "");
      final url = ('$host$registerAPi');
      final response = await http.post(
        Uri.parse(url),
        body: {
          'user_name' : userName,
          'email' : email,
          'first_name' : firstName,
          'last_name' : lastName,
          'contact_number' : contactNumber,
          'password' : password,
          'role' : 1
        }
      );

      if(response.statusCode == 200){
        print('Login successful');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const VisitorBottombar()),
              (route) => false,
        );
      }
      else{
        throw Exception('Invalid credentials');
      }
    }
    catch(e){
      throw Exception('Invalid');
    }
}