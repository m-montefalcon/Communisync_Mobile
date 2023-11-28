
import 'package:communisyncmobile/screens/security%20personnel/security_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<void> acceptQr(context, int id) async{
  try{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int myId = prefs.getInt('id') ?? 0;
    String host = dotenv.get("API_HOST", fallback: "");
    String acceptQrApi = dotenv.get("ACCEPT_QR_RECEIVED_BY_SP", fallback: "");
    final url = '$host$acceptQrApi';

    final response = await http.put(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "id": id.toString(),
          "personnel_id": myId.toString(),
        }
    );
    if (response.statusCode == 200) {
      // Remove token and role from shared preferences

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const SecurityPersonnelBottomBar(),
        ),
            (Route<dynamic> route) => false,
      );
    } else {
      throw Exception('An error occurred');
    }

  }
  catch(e, stackTrace){

    throw Exception('An error occurred');
  }

}

