

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../model/models.dart';

Future<List<Notification>> getNotifications() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int id = prefs.getInt('id') ?? 0;

    String host = dotenv.get("API_HOST", fallback: "");
    String getNotificationApi = dotenv.get("GET_NOTIFICATIONS", fallback: "");
    final url = ('$host$getNotificationApi$id');
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
      List<Notification> notifications = [];

      for (var notificationData in responseData['notifications']) {
        notifications.add(Notification(
          id: notificationData['id'],
          recipientId: notificationData['recipient_id'],
          title: notificationData['title'],
          body: notificationData['body'],
          date: DateTime.parse(notificationData['created_at']),
        ));
      }

      return notifications;
    }
  } catch (e) {
    throw Exception('An error occurred: $e');
  }

  return []; // Return an empty list if there is an error
}
