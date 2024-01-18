
import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


Future<void> submitBlockedlists(context, String firstName, String lastName, String contactNumber, String reason)async{
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int id = prefs.getInt('id') ?? 0;

    String host = dotenv.get("API_HOST", fallback: "");
    String submitBlockedListRequest = dotenv.get("SUBMIT_BLOCKLISTS", fallback: "");
    final url = '$host$submitBlockedListRequest';
    final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "homeowner_id" : id.toString(),
          "first_name" : firstName,
          "last_name" : lastName,
          "contact_number" : contactNumber,
          "blocked_reason" : reason,
        }
    );
    if (response.statusCode == 200) {
      // Remove token and role from shared preferences

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const HomeownerBottomNavigationBar(),
        ),
            (Route<dynamic> route) => false,
      );
    } else {
      throw Exception('');
    }



  }
  catch(e, stackTrace){
    throw Exception('An error occurred: No internet connection');
  }

}