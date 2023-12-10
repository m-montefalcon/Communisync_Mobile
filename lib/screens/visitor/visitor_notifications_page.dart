import 'package:flutter/material.dart';

class VisitorNotificationsPage extends StatefulWidget {
  const VisitorNotificationsPage({Key? key}) : super(key: key);

  @override
  State<VisitorNotificationsPage> createState() => _VisitorNotificationsPageState();
}

class _VisitorNotificationsPageState extends State<VisitorNotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTIFICATIONS'),
      ),
    );
  }
}
