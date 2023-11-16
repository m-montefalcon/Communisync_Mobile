
import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<void> outVisitor(int logbookId) async{
  try{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    String host = dotenv.get("API_HOST", fallback: "");
    String outVisitor = dotenv.get("LOGBOOK_OUT_VISITOR", fallback: "");
    final url = '$host$outVisitor$logbookId';

    print(url);
    final response = await http.put(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },

    );
    if (response.statusCode == 200) {
      // Remove token and role from shared preferences
      print(': ${response.body}');

    } else {
      print(': ${response.body}');
      throw Exception(Exception);
    }

  }
  catch(e, stackTrace){
    print('An error occurred: $e');
    print(stackTrace);
    throw Exception('An error occurred');
  }

}

