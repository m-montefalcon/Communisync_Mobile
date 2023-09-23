import 'dart:convert';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Homeowner>> getCafSearchRequestApi(String search) async {
  print('reached getCafRequestsApi');
  print(search);
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    String host = dotenv.get("API_HOST", fallback: "");
    String cafSearchHmApi = dotenv.get("SEARCH_HOMEOWNER_API", fallback: "");
    final url = ('$host$cafSearchHmApi');
    print(url);
    final response = await http.post(
      Uri.parse(url),
      body: {
        'username': search,
      },
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData);

      try {
        // Parse the JSON response and create a list of Homeowner objects
        final List<Homeowner> homeowners = (responseData as List<dynamic>)
            .map((requestData) {
          return Homeowner(
            id: requestData['id'] as int,
            userName: requestData['user_name'] as String,
            firstName: requestData['first_name'] as String,
            lastName: requestData['last_name'] as String,
            // Add other properties here as needed
          );
        }).toList();

        return homeowners; // Return the list of Homeowner objects
      } catch (e) {
        print(e);
      }
    }
  } catch (e) {
    print(e);
  }

  return []; // Return an empty list if there is an error or no data
}
