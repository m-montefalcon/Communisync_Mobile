


import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../screens/visitor/visitor_bttmbar.dart';

Future<void> requestCa(context, int homeownerId, String destinationPerson,
    List visitMembers
    ) async{


  try{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    Object objectId = prefs.getInt('id') ?? 0; // Use 0 as the default value
    int id = int.parse(objectId.toString()); // Convert to String and then parse to int

    String host = dotenv.get("API_HOST", fallback: "");
    String makeRequestApi = dotenv.get("MAKE_REQUEST_TO_HOMEOWNER_API", fallback: "");
    final url = '$host$makeRequestApi';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',

        'Authorization': 'Bearer $token',
      },
        body: {
          "visitor_id": id.toString(),
          "homeowner_id": homeownerId.toString(),
          "destination_person": destinationPerson,
          "visit_members": visitMembers.toString()
        }

    );
    if (response.statusCode == 200) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VisitorBottombar()),
      );
    } else {
      throw Exception('An error occurred');
    }



  }
catch(e, stackTrace){
  throw Exception('An error occurred');

}


}