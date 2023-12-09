import 'package:flutter/material.dart';

class SecurityNotificationsPage extends StatefulWidget {
  const SecurityNotificationsPage({Key? key}) : super(key: key);

  @override
  State<SecurityNotificationsPage> createState() => _SecurityNotificationsPageState();
}

class _SecurityNotificationsPageState extends State<SecurityNotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTIFICATIONS'),
      ),
    );
  }
}
