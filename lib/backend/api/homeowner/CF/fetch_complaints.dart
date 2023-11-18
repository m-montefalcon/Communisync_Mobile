
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



Future<List<Complaint>> fetchComplaints() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int id = prefs.getInt('id') ?? 0;

    String host = dotenv.get("API_HOST", fallback: "");
    String fetchAnnouncementApi = dotenv.get(
        "FETCH_COMPLAINTS_BY_ID_API", fallback: "");
    final url = '$host$fetchAnnouncementApi$id';
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

      // Parse complaint updates
      List<dynamic> complaintListData = responseData['data'];
      List<Complaint> complaints = complaintListData.map((complaintData) {
        List<dynamic>? complaintUpdatesData = complaintData['complaint_updates'] != null
            ? json.decode(complaintData['complaint_updates'])
            : null;

        List<ComplaintUpdate>? complaintUpdates;
        if (complaintUpdatesData != null) {
          try {
            complaintUpdates = complaintUpdatesData
                .map((updateData) {
              List<String>? updates;
              if (updateData['update'] is List) {
                updates = List<String>.from(updateData['update'].map((e) => e.toString()));
              } else if (updateData['update'] is String) {
                updates = [updateData['update']];
              }
              return ComplaintUpdate(
                update: updates ?? [],
                resolution: updateData['resolution'],
                date: updateData['date'],
              );
            })
                .toList();


          } catch (e) {
            print('Error decoding complaint updates: $e');
          }
        }







        AdminComplaints? admin;
        if (complaintData['admin'] != null) {
          admin = AdminComplaints(
            id: complaintData['admin']['id'],
            userName: complaintData['admin']['user_name'],
            firstName: complaintData['admin']['first_name'],
            lastName: complaintData['admin']['last_name'],
            photo: complaintData['admin']['photo'],
          );
        }

        return Complaint(
          title: complaintData['complaint_title'],
          description: complaintData['complaint_desc'],
          photo: complaintData['complaint_photo'],
          status: complaintData['complaint_status'],
          admin: admin,
          updates: complaintUpdates,
        );

      }).toList();

      for (var data in complaints) {
        print('Title: ${data.title}');
        print('Description: ${data.description}');
        print('Photo: ${data.photo}');

        print('Admin ID: ${data.admin?.id}');
        print('Admin Username: ${data.admin?.userName}');
        print('Admin First Name: ${data.admin?.firstName}');
        print('Admin Last Name: ${data.admin?.lastName}');
        print('Admin photo: ${data.admin?.photo}');

        if (data.updates != null) {
          for (var update in data.updates!) {
            print('Update: ${update.update}');
            print('Resolution: ${update.resolution}');
            print('Date: ${update.date}');
          }
        }
      }

      return complaints;
    } else {
      throw Exception('An error occurred');
    }
  } catch (e, stackTrace) {
    print('An error occurred: $e');
    print(stackTrace);
    throw Exception('An error occurred');
  }
}
