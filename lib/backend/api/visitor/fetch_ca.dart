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
        'search': search,
      },
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(response.body);
      // Check if responseData is a list and extract the inner list
      final List<dynamic> dataList = responseData is List ? responseData[0] : [];

      // Parse the JSON response and create a list of Homeowner objects
      final List<Homeowner> homeowners = dataList.map((requestData) {
        List<String> familyMembers = [];
        if (requestData['family_member'] != null) {
          if (requestData['family_member'] is String) {
            familyMembers.add(requestData['family_member'] as String);
          } else if (requestData['family_member'] is List) {
            familyMembers.addAll(requestData['family_member'] as List<String>);
          }
        }
        Homeowner homeowner = Homeowner(
          id: requestData['id'] as int,
          userName: requestData['user_name'] as String,
          firstName: requestData['first_name'] as String,
          lastName: requestData['last_name'] as String,
          familyMember: familyMembers,
          // Add other properties here as needed
        );

        // Print the current homeowner instance
        print(homeowner);

        return homeowner;
      }).toList();

      // Loop through the list and print each Homeowner instance
      for (Homeowner homeowner in homeowners) {
        print(homeowner);
      }

      return homeowners; // Return the list of Homeowner objects
    } else {

      throw Exception('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('An error occurred while making the request');
  }
}
