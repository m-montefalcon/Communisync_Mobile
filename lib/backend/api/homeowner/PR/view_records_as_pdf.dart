
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_payment_pdfviewer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<void> fetchPdfRecord(BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int id = prefs.getInt('id') ?? 0;

    String host = dotenv.get("API_HOST", fallback: "");
    String fetchPaymentRecordsAsPdfApi = dotenv.get(
        "FETCH_PAYMENT_RECORDS_AS_PDF_API", fallback: "");
    final url = '$host$fetchPaymentRecordsAsPdfApi$id';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/pdf', // Set the Accept header to indicate that you expect a PDF response
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      // Save the PDF file to a temporary file
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File file = File('$tempPath/payment_record.pdf');
      await file.writeAsBytes(response.bodyBytes);

      // Display the PDF viewer widget in your app
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewer(path: file.path),
        ),
      );
    } else {
      throw Exception('Response status code is not 200');
    }
  } catch (e, stackTrace) {
    print('An error occurred: $e');
    print(stackTrace);
    throw Exception('An error occurred');
  }
}
