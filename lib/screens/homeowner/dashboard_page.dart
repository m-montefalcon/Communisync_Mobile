import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
              'Homepage',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
