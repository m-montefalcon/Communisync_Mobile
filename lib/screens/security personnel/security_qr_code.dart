import 'dart:convert';
import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            toolbarHeight: 110,
            elevation: 0.0,
            flexibleSpace: ClipPath(
              clipper: AppBarCustomClipper(),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.purple.shade700),
                child: const Center(
                  child: Text(
                    'CommuniSync',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
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
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'QR Data: $qrData',
                    style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
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
        parseAndDisplayData(qrData);
      });
      controller.stopCamera();
    });
  }

  void parseAndDisplayData(String qrData) {
    try {
      Map<String, dynamic> data = jsonDecode(qrData);
      int id = data['ID'];
      int homeowner = data['Homeowner'];
      int visitor = data['Visitor'];

      printData(id, homeowner, visitor);
    } catch (e) {
      print('Error parsing QR data: $e');
    }
  }

  void printData(int id, int homeowner, int visitor) {
    print('ID: $id');
    print('Homeowner: $homeowner');
    print('Visitor: $visitor');
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
