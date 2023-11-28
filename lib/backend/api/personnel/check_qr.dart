import 'package:communisyncmobile/backend/model/models.dart'; // Import your model

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<RequestQr>> checkQr(context, int id, int homeowner, int visitor) async {
  try {
    String host = dotenv.get("API_HOST", fallback: "");
    String checkQrApi = dotenv.get("CHECK_QR_RECEIVED_BY_SP", fallback: "");
    final url = '$host$checkQrApi';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        "id": id.toString(),
        "homeowner_id": homeowner.toString(),
        "visitor_id": visitor.toString(),
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final data = jsonResponse['data']; // Access the "data" field
      final request = RequestQr(
        id: data['id'],
        visitorId: data['visitor_id'],
        homeownerId: data['homeowner_id'],
        adminId: data['admin_id'],
        personnelId: data['personnel_id'],
        // date: DateTime.parse(data['date']),
        // time: DateTime.parse(data['time']),
        destinationPerson: data['destination_person'],
        visitMembers: List<String>.from(json.decode(data['visit_members'])),
        visitStatus: data['visit_status'],
        qrCode: data['qr_code'], // Include the QR code
        visitor: Visitor(
          id: data['visitor']['id'],
          userName: data['visitor']['user_name'],
          firstName: data['visitor']['first_name'],
          lastName: data['visitor']['last_name'],
          contactNumber: data['visitor']['contact_number'],
          photo: data['visitor']['photo'],
          role: data['visitor']['role'],
          email: data['visitor']['email'],
          // createdAt: DateTime.parse(requestData['visitor']['created_at']),
          // updatedAt: DateTime.parse(requestData['visitor']['updated_at']),
        ),
      );

      return [request]; // Return the RequestQr object


    } else {
      throw Exception('An error occurred');
    }
  } catch (e, stackTrace) {

    throw Exception('An error occurred');
  }
}