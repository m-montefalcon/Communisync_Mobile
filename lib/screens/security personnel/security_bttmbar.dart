import 'package:communisyncmobile/screens/security%20personnel/security_announcement_page.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_dashboard.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_profile_page.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_qr_code.dart';
import 'package:flutter/material.dart';

class SecurityPersonnelBottomBar extends StatefulWidget {
  const SecurityPersonnelBottomBar({Key? key}) : super(key: key);

  @override
  State<SecurityPersonnelBottomBar> createState() =>
      _SecurityPersonnelBottomBarState();
}

class _SecurityPersonnelBottomBarState
    extends State<SecurityPersonnelBottomBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    SecurityDashboard(),
    SecurityAnnouncementPage(),
    SecurityQrCode(),
    SecurityProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.green,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                size: 25,
              ),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.tips_and_updates_rounded,
                size: 25,
              ),
              label: 'Announce',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.qr_code_rounded,
                size: 25,
              ),
              label: 'QR Code',
            ),

            const BottomNavigationBarItem(
              icon: Icon(
                Icons.person_rounded,
                size: 25,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
