import 'package:flutter/material.dart';

class DisplayQrCode extends StatelessWidget {
  final String itemId;
  final String qrCode;
  const DisplayQrCode({Key? key, required this.itemId, required this.qrCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
      ),
      // body: ,
    );
  }
}
