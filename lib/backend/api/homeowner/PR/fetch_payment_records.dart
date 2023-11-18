
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



Future<List<PaymentRecords>> fetchRecords() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int id = prefs.getInt('id') ?? 0;

    String host = dotenv.get("API_HOST", fallback: "");
    String fetchPaymentRecordsApi = dotenv.get(
        "FETCH_PAYMENT_RECORDS_API", fallback: "");
    final url = '$host$fetchPaymentRecordsApi$id';
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
      print(responseData);
      try {
        final String? messageData = responseData['message'];

        final List<PaymentRecords> records = (responseData['records'] as List<dynamic>)
            .map((requestData) {
          return PaymentRecords(
              message: messageData,
              transactionNumber: requestData['transaction_number'],
              paymentDate: requestData['payment_date'],
              notes: requestData['notes'],
              paymentAmount: requestData['payment_amount'],
              admin: AdminComplaints(
                id: requestData['admin']['id'],
                userName: requestData['admin']['user_name'],
                firstName: requestData['admin']['first_name'],
                lastName: requestData['admin']['last_name'],
                photo: requestData['admin']['photo'],
              )
          );
        })
            .toList();

        for (var data in records) {
          print('message: ${data.message}');

          print('transactionNumber: ${data.transactionNumber}');
          print('paymentDate: ${data.paymentDate}');
          print('notes: ${data.notes}');
          print('paymentAmount: ${data.paymentAmount}');

          print('Admin ID: ${data.admin?.id}');
          print('Admin Username: ${data.admin?.userName}');
          print('Admin First Name: ${data.admin?.firstName}');
          print('Admin Last Name: ${data.admin?.lastName}');
          print('Admin photo: ${data.admin?.photo}');



        }
        return records;
      } catch (e) {
        // Handle other errors here
        throw Exception('Error fetching data: $e');
      }

    } else {
      throw Exception('not 200');
    }
  } catch (e, stackTrace) {
    print('An error occurred: $e');
    print(stackTrace);
    throw Exception('An error occurred');
  }
}
