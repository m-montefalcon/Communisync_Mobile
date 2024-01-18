
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

    final response = await http.put(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },

    );
    if (response.statusCode == 200) {

    } else {
      throw Exception('An error occurred');
    }

  }
  catch(e, stackTrace){

    throw Exception('An error occurred: No internet connection');
  }

}

