import 'package:flutter/material.dart';

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({Key? key}) : super(key: key);

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              'Complaints',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
