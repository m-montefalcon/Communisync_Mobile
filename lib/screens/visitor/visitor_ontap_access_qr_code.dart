import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DisplayQrCode extends StatelessWidget {
  final String svgData;
  const DisplayQrCode({Key? key, required this.svgData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
      ),
      // body: ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the SVG QR code using SvgPicture.string
            SvgPicture.string(
              svgData,
              width: 300, // Set the desired width
              height: 300, // Set the desired height
            ),
          ],
        ),
      ),
    );
  }
}
