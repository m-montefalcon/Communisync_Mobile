import 'dart:convert';

import 'package:communisyncmobile/backend/model/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Request>> getCafRequestsApi(BuildContext context, int id) async {

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    String host = dotenv.get("API_HOST", fallback: "");
    String getRequestsApi = dotenv.get("FETCHES_ALL_REQUEST_HOMEOWNER_API", fallback: "");
    final url = ('$host$getRequestsApi$id');
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
        final List<Request> requests = (responseData['data'] as List<dynamic>)
            .map((requestData) {
          final dynamic visitMembersData = requestData['visit_members'];
          final List<String>? visitMembers = visitMembersData is String
              ? List<String>.from([visitMembersData])
              : visitMembersData?.cast<String>();
          final String dateString = requestData['date'];
          final String timeString = requestData['time'];
          final DateTime dateTime = DateTime.parse('$dateString $timeString');

          return Request(
            id: requestData['id'],
            visitorId: requestData['visitor_id'],
            homeownerId: requestData['homeowner_id'],
            adminId: requestData['admin_id'],
            personnelId: requestData['personnel_id'],
            date: dateTime,
            time: dateTime,
            destinationPerson: requestData['destination_person'],
            visitMembers: visitMembers,
            visitStatus: requestData['visit_status'],
            // qrCode: requestData['qr_code'],
            // createdAt: DateTime.parse(requestData['created_at']),
            // updatedAt: DateTime.parse(requestData['updated_at']),
            visitor: Visitor(
              id: requestData['visitor']['id'],
              userName: requestData['visitor']['user_name'],
              firstName: requestData['visitor']['first_name'],
              lastName: requestData['visitor']['last_name'],
              contactNumber: requestData['visitor']['contact_number'],
              photo: requestData['visitor']['photo'],
              role: requestData['visitor']['role'],
              email: requestData['visitor']['email'],
              // createdAt: DateTime.parse(requestData['visitor']['created_at']),
              // updatedAt: DateTime.parse(requestData['visitor']['updated_at']),
            ),
          );
        })
            .toList();

        return requests;
      } catch (e) {
        // Handle other errors here
        throw Exception('Error fetching data: $e');
      }
    } else {
      // Handle the case where the API response is not successful
      throw Exception('API request failed with status code ${response.statusCode}');
    }
  } catch (e) {
    // Handle other errors here
    throw Exception('Error fetching data: $e');
  }
}




Future<List<Request>> getIdFromSharedPreferencesAndFetchData(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? id = prefs.getInt('id');

  if (id != null) {
    return getCafRequestsApi(context, id);
  } else {
    // Handle the case where 'id' is not stored in SharedPreferences
    throw Exception('ID not found in SharedPreferences');
  }
}
