
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<User> profileUser() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int id = prefs.getInt('id') ?? 0;

    String host = dotenv.get("API_HOST", fallback: "");
    String profileApi = dotenv.get("PROFILE_API", fallback: "");

    final url = ('$host$profileApi$id');
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData.containsKey('data')) {

        Map<String, dynamic> userData = responseData['data'];
        User user = User(
          firstName: userData['first_name'],
          lastName: userData['last_name'],
          userName: userData['user_name'],
          contactNumber: userData['contact_number'],
          email: userData['email'],
          blockNo: userData['block_no'],
          lotNo: userData['lot_no'],
          manualVisitOption: userData['manual_visit_option'],
          photo: userData['photo'],
          familyMember: userData['family_member']
        );
        return user;

      } else {
        throw Exception('User data not found in the API response');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: User session expired');
    } else {
      throw Exception('HTTP Error: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
