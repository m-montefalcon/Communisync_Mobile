
import 'dart:convert';

import 'package:communisyncmobile/screens/visitor/visitor_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<void> markAsRead(context) async{
  try{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    int id = prefs.getInt('id') ?? 0; // Use 0 as the default value

    String host = dotenv.get("API_HOST", fallback: "");
    String markReadApi = dotenv.get("MARK_READ_NOTIFICATIONS", fallback: "");
    final url = '$host$markReadApi';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        "id": id.toString(),
      },
    );

    if (response.statusCode == 200) {
    } else {

      throw (Exception);

    }



  }
  catch(e, stackTrace){
    throw Exception(e);
  }


}