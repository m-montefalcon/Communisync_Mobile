import 'dart:convert';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Homeowner>> getCafSearchRequestApi(String search) async {

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    String host = dotenv.get("API_HOST", fallback: "");
    String cafSearchHmApi = dotenv.get("SEARCH_HOMEOWNER_API", fallback: "");
    final url = ('$host$cafSearchHmApi');

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


      try {
        // Parse the JSON response and create a list of Homeowner objects
        final List<Homeowner> homeowners = (responseData as List<dynamic>)
            .map((requestData) {
          List<String> familyMembers = [];
          if (requestData['family_member'] != null) {
            if (requestData['family_member'] is String) {
              familyMembers.add(requestData['family_member'] as String);
            } else if (requestData['family_member'] is List) {
              familyMembers.addAll(requestData['family_member'] as List<String>);
            }
          }
          return Homeowner(
            id: requestData['id'] as int,
            userName: requestData['user_name'] as String,
            firstName: requestData['first_name'] as String,
            lastName: requestData['last_name'] as String,
            familyMember: familyMembers,
            // Add other properties here as needed
          );
        }).toList();


        return homeowners; // Return the list of Homeowner objects
      } catch (e) {
        throw Exception('An error occured');
      }
    }
  } catch (e) {
    throw Exception('An error occured');
  }

  return []; // Return an empty list if there is an error or no data
}
