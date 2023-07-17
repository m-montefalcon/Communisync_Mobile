import 'package:flutter/material.dart';

class QrCode extends StatefulWidget {
  const QrCode({Key? key}) : super(key: key);

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: const [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              'Qr Code',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
