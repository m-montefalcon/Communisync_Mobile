
import 'dart:convert';

import 'package:communisyncmobile/screens/visitor/visitor_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<void> getVerified(context, int blockNo, int lotNo,
    List familyMembers
    ) async{


  try{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    int id = prefs.getInt('id') ?? 0; // Use 0 as the default value

    String host = dotenv.get("API_HOST", fallback: "");
    String getVerifiedApi = dotenv.get("GET_VERIFIED_API", fallback: "");
    final url = '$host$getVerifiedApi';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        "user_id": id.toString(),
        "family_member": (familyMembers.isEmpty) ? '' : familyMembers.toString(), // Send the list as JSON, or null if it's empty
        "block_no": blockNo.toString(),
        "lot_no": lotNo.toString(),
      },
    );

    if (response.statusCode == 200) {

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const VisitorBottombar(),
        ),
            (Route<dynamic> route) => false,
      );
    } else {
      throw Exception('An error occurred:');
    }



  }
  catch(e, stackTrace){
    throw Exception('An error occurred:');
  }


}