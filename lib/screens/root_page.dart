import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_bttmbar.dart';
import 'package:communisyncmobile/screens/visitor/visitor_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override

  String role = '';
  Future<Widget> _getRolePage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    role = prefs.getString('role') ?? '';

    if (role == '1') {
      return const VisitorBottombar();
    } else if (role == '2') {
      return const HomeownerBottomNavigationBar();
    } else if (role == '3' || role == '4') {
      return const SecurityPersonnelBottomBar();
    } else {
      return const LoginPage();
    }
  }
  @override

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getRolePage(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // loading spinner until the Future completes
        } else {
          return snapshot.data ?? const CircularProgressIndicator(); // returns the Widget once Future completes
        }
      },
    );
  }
}