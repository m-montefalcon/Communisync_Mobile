import 'package:communisyncmobile/screens/login_page.dart';
import 'package:communisyncmobile/screens/root_page.dart';
import 'package:communisyncmobile/screens/visitor/visitor_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main () async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CommuniSync',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const RootPage(),
    );
  }
}
