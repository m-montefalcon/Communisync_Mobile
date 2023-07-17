import 'package:communisyncmobile/screens/homeowner/announcements_page.dart';
import 'package:communisyncmobile/screens/homeowner/complaints_page.dart';
import 'package:communisyncmobile/screens/homeowner/dashboard_page.dart';
import 'package:communisyncmobile/screens/homeowner/profile_page.dart';
import 'package:communisyncmobile/screens/qr_code.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarPart2 extends StatefulWidget {
  const BottomNavigationBarPart2({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarPart2> createState() => _BottomNavigationBarPart2State();
}

class _BottomNavigationBarPart2State extends State<BottomNavigationBarPart2> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    ComplaintsPage(),
    QrCode(),
    AnnouncementPage(),
    ProfilePage(),
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
          const BottomNavigationBarItem(
            icon: Icon(Icons.wechat_rounded, size: 25,),
            label: 'Complain',
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
            icon: Icon(Icons.tips_and_updates_rounded, size: 25,),
            label: 'Announce',
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
