
import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<void> acceptRequestCa(context, int id)async{
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String host = dotenv.get("API_HOST", fallback: "");
    String acceptRequestApi = dotenv.get("ACCEPT_REQUEST_VISITOR_API", fallback: "");
    final url = '$host$acceptRequestApi';
    final response = await http.put(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "id": id.toString()
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
      throw Exception('An error occured');
    }

  }
  catch(e, stackTrace){

    throw Exception('An error occurred: No internet connection');
  }

}
