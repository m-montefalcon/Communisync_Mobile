import 'package:flutter/material.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
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
              'Announcements',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
