import 'dart:convert';

import 'package:communisyncmobile/backend/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<List<FetchAllQr>> fetchAllRequestApi(BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int id = prefs.getInt('id') ?? 0;
    String host = dotenv.get("API_HOST", fallback: "");
    String getAllValidatedRequests = dotenv.get("FETCH_ALL_VALIDATED_REQUEST_API", fallback: "");
    final url = ('$host$getAllValidatedRequests$id');

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      try {
        final List<FetchAllQr> fetchQr = (responseData['data'] as List<dynamic>)
            .map((requestData) {
          final dynamic visitMembersData = requestData['visit_members'];
          final List<String>? visitMembers = visitMembersData is String
              ? List<String>.from([visitMembersData])
              : visitMembersData?.cast<String>();

          return FetchAllQr(
            id: requestData['id'],
            destinationPerson: requestData['destination_person'],
            visitMembers: visitMembers,
            qrCode: requestData['qr_code'],
            homeowner: Homeowner(
              id: requestData['homeowner']['id'],
              userName: requestData['homeowner']['user_name'],
              firstName: requestData['homeowner']['first_name'],
              lastName: requestData['homeowner']['last_name'],
            ),
            admin: Admin(
              id: requestData['admin']['id'],
              userName: requestData['admin']['user_name'],
              firstName: requestData['admin']['first_name'],
              lastName: requestData['admin']['last_name'],
            )
          );
        })
            .toList();


        return fetchQr;
      } catch (e) {
        // Handle other errors here
        throw Exception('Error fetching data');
      }
    } else {
      // Handle the case where the API response is not successful
      throw Exception('Error fetching data');
    }
  } catch (e) {
    // Handle other errors here
    throw Exception('Error fetching data');
  }
}
