import 'package:flutter/material.dart';

class HomeOwnerNotificationsPage extends StatefulWidget {
  const HomeOwnerNotificationsPage({Key? key}) : super(key: key);

  @override
  State<HomeOwnerNotificationsPage> createState() => _HomeOwnerNotificationsPageState();
}

class _HomeOwnerNotificationsPageState extends State<HomeOwnerNotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTIFICATIONS'),
      ),
    );
  }
}
