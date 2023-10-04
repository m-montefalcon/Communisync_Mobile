
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Announcement>> fetchAnnouncements()async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String role = prefs.getString('role') ?? '';

    String host = dotenv.get("API_HOST", fallback: "");
    String fetchAnnouncementApi = dotenv.get(
        "FETCH_ANNOUNCEMENT_API", fallback: "");
    final url = '$host$fetchAnnouncementApi$role';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },

    );
    if (response.statusCode == 200) {
      // Remove token and role from shared preferences
      final responseData = json.decode(response.body);

      print('$responseData');
      List<dynamic> announcementListData = responseData['data'];
      List<Announcement> announcements = announcementListData.map((announcementData) {
        return Announcement(
          title: announcementData['announcement_title'],
          description: announcementData['announcement_description'],
          photo: announcementData['annoucement_photo'],
          admin: Admin(
            id: announcementData['admin']['id'],
            userName: announcementData['admin']['user_name'],
            firstName: announcementData['admin']['first_name'],
            lastName: announcementData['admin']['last_name'],
          ),
        );
      }).toList();

      for (var data in announcements) {
        print('Title: ${data.title}');
        print('Description: ${data.description}');
        print('Photo: ${data.photo}');
        print('Admin ID: ${data.admin.id}');
        print('Admin Username: ${data.admin.userName}');
        print('Admin First Name: ${data.admin.firstName}');
        print('Admin Last Name: ${data.admin.lastName}');
      }


      return announcements;

    }else{
      throw Exception('not 200');
    }

  }
  catch (e, stackTrace) {
    print('An error occurred: $e');
    print(stackTrace);
    throw Exception('An error occurred');
  }
}