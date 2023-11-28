
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<void> submitComplaint(context, String title, String description, String photoPath) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int id = prefs.getInt('id') ?? 0;

    String host = dotenv.get("API_HOST", fallback: "");
    String submitComplaintsApi = dotenv.get("SUBMIT_COMPLAINTS_API", fallback: "");
    final url = '$host$submitComplaintsApi';

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $token';

    // Add the complaint details as fields
    request.fields['homeowner_id'] = id.toString();
    request.fields['complaint_title'] = title;
    request.fields['complaint_desc'] = description;

    // Read the photo file as bytes
    File photoFile = File(photoPath);
    List<int> photoBytes = await photoFile.readAsBytes();

    // Add the photo file as a part
    request.files.add(http.MultipartFile.fromBytes('complaint_photo', photoBytes, filename: 'photo.jpg'));

    // Send the request
    var response = await request.send();
    if (response.statusCode == 200) {
      // Handle the response
    } else {
      print('Submission failed');
      // Handle the error
    }
  } catch (e, stackTrace) {
    throw Exception('An error occurred');

  }
}
