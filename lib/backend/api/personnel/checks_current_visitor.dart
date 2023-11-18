
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Logbook>> checksCurrentVisitors() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    String host = dotenv.get("API_HOST", fallback: "");
    String checksCurrentVisitorsApi = dotenv.get(
        "LOGOUT_CHECKS_FOR_OUT_VISITOR", fallback: "");
    final url = '$host$checksCurrentVisitorsApi';
    print(url);

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('$responseData');

      List<dynamic> logbookListData = responseData['data'];
      List<Logbook> logbook = logbookListData.map((logbookData) {
        // Parse the visit_members string as JSON array
        final visitMembersData = logbookData['visit_members'];
        final List<String>? visitMember = visitMembersData != null
            ? (visitMembersData is String
            ? List<String>.from(json.decode(visitMembersData))
            : visitMembersData.cast<String>())
            : null;


        return Logbook(
          id: logbookData['id'],
          visitDate: logbookData['visit_date_in'],
          visitTime: logbookData['visit_time_in'],
          contactNumber: logbookData['contact_number'],
          visitMembers: visitMember,
          visitor: logbookData['visitor'] != null
              ? Visitor(
            id: logbookData['visitor']['id'],
            userName: logbookData['visitor']['user_name'],
            firstName: logbookData['visitor']['first_name'],
            lastName: logbookData['visitor']['last_name'],
            contactNumber: logbookData['visitor']['contact_number'],
            role: logbookData['visitor']['role'],
            email: logbookData['visitor']['email'],
            photo: logbookData['visitor']['photo'],
          )
              : null,

        );
      }).toList();

      for (var data in logbook) {
        print('Title: ${data.id}');
        print('Description: ${data.visitor?.firstName}');
        print('Description: ${data.visitor?.lastName}');
        print('Description: ${data.visitor?.contactNumber}');
        print('Description: ${data.visitor?.email}');
        print('Description: ${data.visitor?.photo}');
        print('Photo: ${data.visitMembers}');
        print('Admin ID: ${data.visitDate}');
        print('Admin Username: ${data.visitTime}');
      }


      // Print the logbook for debugging


      return logbook;
    } else {
      throw Exception('Failed to load data');
    }

  } catch (e, stackTrace) {
    print('An error occurred: $e');
    print(stackTrace);
    throw Exception('An error occurred');
  }
}

