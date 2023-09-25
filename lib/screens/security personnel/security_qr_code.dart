import 'dart:convert';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:communisyncmobile/backend/api/personnel/check_qr.dart';

class SecurityQrCode extends StatefulWidget {
  const SecurityQrCode({Key? key}) : super(key: key);

  @override
  State<SecurityQrCode> createState() => _SecurityQrCodeState();
}

class _SecurityQrCodeState extends State<SecurityQrCode> {
  GlobalKey qrKey = GlobalKey();
  QRViewController? controller;
  String qrData = '';
  bool isScanning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: isScanning
                  ? QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              )
                  : Image.asset('assets/images/default-qr.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isScanning = true; // Allow scanning again
                  });
                },
                child: const Text('Start Scanning'),
              ),
            ),
            // Use FutureBuilder to display scanned data
            Expanded(child:
            FutureBuilder<List<RequestQr>>(
              future: parseAndDisplayData(qrData),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // If the Future is still running, show a loading indicator
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // If there's an error, show an error message
                  return Text('Please scan a QR');
                } else if (!snapshot.hasData) {
                  // If there's no data, show a message indicating that
                  return Text('No data available');
                } else {
                  // If the Future completed successfully, you can access the data here
                  final data = snapshot.data;
                  // Render your UI based on the data
                  // For example, you can create a ListView.builder to display a list of items
                  return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      // Build a widget for each item in the data
                      return ListTile(
                        title: Text('Visitor: ${item.visitor.firstName} ${item.visitor.lastName}'),
                        // Add more fields as needed
                      );
                    },
                  );
                }
              },
            )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement your logic for accepting the request here
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black54),
                  child: const Text('Accept'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement your logic for declining the request here
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black54),
                  child: const Text('Decline'),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrData = scanData.code!;
        isScanning = false;
      });
      controller.stopCamera();
    });
  }
  Future<List<RequestQr>> parseAndDisplayData(String qrData) async {
    try {
      Map<String, dynamic> data = jsonDecode(qrData);
      int id = data['ID'];
      int homeowner = data['Homeowner'];
      int visitor = data['Visitor'];

      // Call the asynchronous function to fetch and return data
      final result = await checkQr(context, id, homeowner, visitor);
      return result;
    } catch (e) {
      print('Error parsing QR data: $e');
      throw e;
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
