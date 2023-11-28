import 'dart:convert';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_visitor_full_info_page.dart';
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
            Expanded(
                child: FutureBuilder<List<RequestQr>>(
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
                      String visitorFullName =
                          '${item.visitor.firstName} ${item.visitor.lastName}';
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the next page or perform the desired action when tapped
                          // You can replace 'NextPage()' with the actual page you want to navigate to
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VisitorFullInfoPage(requestQr: item,)),
                          );
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Visitor: '),
                              Text(
                                visitorFullName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            )),

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
      throw e;
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
