import 'package:communisyncmobile/screens/security%20personnel/security_dashboard.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_profuile_page.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_qr_code.dart';
import 'package:flutter/material.dart';

class SecurityPersonnelBottomBar extends StatefulWidget {
  const SecurityPersonnelBottomBar({Key? key}) : super(key: key);

  @override
  State<SecurityPersonnelBottomBar> createState() => _SecurityPersonnelBottomBarState();
}

class _SecurityPersonnelBottomBarState extends State<SecurityPersonnelBottomBar> {

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    SecurityDashboard(),
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
      bottomNavigationBar: BottomNavigationBar(

        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.purple,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded, size: 25,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.qr_code_rounded, size: 35 , color: Colors.white),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded, size: 25,),
            label: 'Profile',
          ),
        ],

      ),

    );
  }
}
